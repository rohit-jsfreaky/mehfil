import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:mehfil_client/mehfil_client.dart';
import 'package:serverpod_offline_sync_client/serverpod_offline_sync_client.dart';

import '../client.dart';
import '../ui/format.dart';
import '../ui/icons.dart';
import '../ui/theme.dart';
import '../ui/widgets.dart';
import 'guest_session.dart';

/// Loads photo files from the album endpoint (which only answers after the
/// reveal), keeps them in memory for this visit and on the phone for the next
/// one, so an opened album still works with no signal.
class Photos {
  static final _memory = <String, Future<Uint8List>>{};
  static OfflineSyncDatabaseSession? local;

  static Future<Uint8List> get(UuidValue shotId, {bool thumb = true}) {
    final key = '${shotId.uuid}-$thumb';
    return _memory.putIfAbsent(key, () async {
      try {
        final db = local;
        if (db != null) {
          final saved = await PhotoCache.db.findFirstRow(
            db,
            where: (t) => t.shotId.equals(shotId) & t.thumb.equals(thumb),
          );
          if (saved != null) return _bytes(saved.bytes);
        }
        final data = await client.album.photo(shotId, thumb: thumb);
        if (db != null) {
          await PhotoCache.db.insertRow(
            db,
            PhotoCache(
              shotId: shotId,
              thumb: thumb,
              bytes: data,
              savedAt: DateTime.now().toUtc(),
            ),
          );
        }
        return _bytes(data);
      } catch (e) {
        _memory.remove(key);
        rethrow;
      }
    });
  }

  static Uint8List _bytes(ByteData d) =>
      d.buffer.asUint8List(d.offsetInBytes, d.lengthInBytes);
}

/// The revealed album: rows reached this phone through offline sync, the
/// pictures come from the server on demand (and stay on the phone).
class AlbumScreen extends StatefulWidget {
  const AlbumScreen({super.key, required this.session});
  final GuestSession session;

  @override
  State<AlbumScreen> createState() => _AlbumScreenState();
}

class _AlbumScreenState extends State<AlbumScreen> {
  int? _rollFilter;
  GuestSession get s => widget.session;

  @override
  void initState() {
    super.initState();
    Photos.local = s.local;
    s.addListener(_changed);
  }

  void _changed() {
    if (mounted) setState(() {});
  }

  @override
  void dispose() {
    s.removeListener(_changed);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final openRolls = s.rolls.where((r) => r.revealedAt != null).toList();
    final photos = _rollFilter == null
        ? s.album
        : s.album.where((p) => p.rollId == _rollFilter).toList();
    final guests = s.album.map((p) => p.guestName).toSet().length;
    final firstOpen = openRolls.isEmpty
        ? null
        : openRolls
              .map((r) => r.revealedAt!)
              .reduce((a, b) => a.isBefore(b) ? a : b);
    final nextReveal = s.rolls
        .where((r) => r.revealedAt == null)
        .map((r) => r.revealAt)
        .fold<DateTime?>(null, (a, b) => a == null || b.isBefore(a) ? b : a);

    final byGuest = <String, int>{};
    for (final p in photos) {
      byGuest[p.guestName] = (byGuest[p.guestName] ?? 0) + 1;
    }
    final top = byGuest.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value));

    return SafeArea(
      bottom: false,
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 720),
          child: CustomScrollView(
            slivers: [
              SliverPadding(
                padding: const EdgeInsets.fromLTRB(M.margin, 12, M.margin, 0),
                sliver: SliverToBoxAdapter(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 40,
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Caps(
                            firstOpen == null
                                ? 'Not open yet'
                                : 'Opened ${revealLabel(firstOpen)}',
                          ),
                        ),
                      ),
                      Text(s.event.name, style: M.display),
                      const SizedBox(height: 4),
                      Text.rich(
                        TextSpan(
                          style: M.subhead,
                          children: [
                            TextSpan(
                              text: grouped(s.album.length),
                              style: M.number(15),
                            ),
                            TextSpan(
                              text: s.album.length == 1
                                  ? ' photo · '
                                  : ' photos · ',
                            ),
                            TextSpan(
                              text: grouped(guests),
                              style: M.number(15),
                            ),
                            TextSpan(text: guests == 1 ? ' guest' : ' guests'),
                            if (s.event.isDemo) const TextSpan(text: ' · demo'),
                          ],
                        ),
                      ),
                      if (openRolls.length > 1) ...[
                        const SizedBox(height: 16),
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: [
                              Pill(
                                'All',
                                selected: _rollFilter == null,
                                onTap: () => setState(() => _rollFilter = null),
                              ),
                              for (final r in openRolls) ...[
                                const SizedBox(width: 8),
                                Pill(
                                  r.name,
                                  selected: _rollFilter == r.id,
                                  onTap: () =>
                                      setState(() => _rollFilter = r.id),
                                ),
                              ],
                            ],
                          ),
                        ),
                      ],
                      const SizedBox(height: 18),
                    ],
                  ),
                ),
              ),
              if (openRolls.isEmpty)
                SliverPadding(
                  padding: const EdgeInsets.symmetric(horizontal: M.margin),
                  sliver: SliverToBoxAdapter(
                    child: StatusCard(
                      icon: Ph.lock,
                      title: nextReveal == null
                          ? 'The album is not open yet'
                          : 'Opens ${revealLabel(nextReveal)}',
                      subtitle:
                          'Every photo stays hidden until then, even from you.',
                    ),
                  ),
                )
              else if (photos.isEmpty)
                SliverPadding(
                  padding: const EdgeInsets.symmetric(horizontal: M.margin),
                  sliver: SliverToBoxAdapter(
                    child: StatusCard(
                      icon: s.online ? Ph.cloudArrowUp : Ph.wifiSlash,
                      title: s.online
                          ? 'The album is arriving…'
                          : 'You are offline',
                      subtitle: s.online
                          ? null
                          : 'The album arrives as soon as you have signal.',
                    ),
                  ),
                )
              else
                SliverGrid(
                  gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 160,
                    mainAxisSpacing: 2,
                    crossAxisSpacing: 2,
                  ),
                  delegate: SliverChildBuilderDelegate(
                    (context, i) => _Tile(photo: photos[i]),
                    childCount: photos.length,
                  ),
                ),
              if (top.isNotEmpty)
                SliverPadding(
                  padding: const EdgeInsets.fromLTRB(M.margin, 14, M.margin, 0),
                  sliver: SliverToBoxAdapter(
                    child: Row(
                      children: [
                        Initials([
                          for (final e in top.take(3)) e.key,
                        ], size: 28),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            top
                                .take(3)
                                .map((e) => '${e.key} ${e.value}')
                                .join(' · '),
                            style: M.footnote,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              const SliverToBoxAdapter(child: SizedBox(height: 120)),
            ],
          ),
        ),
      ),
    );
  }
}

class _Tile extends StatelessWidget {
  const _Tile({required this.photo});
  final AlbumPhoto photo;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      label: 'Photo by ${photo.guestName}',
      child: GestureDetector(
        onTap: () => Navigator.of(context).push(
          MaterialPageRoute<void>(builder: (_) => PhotoViewer(photo: photo)),
        ),
        child: Container(
          color: M.surface,
          child: FutureBuilder<Uint8List>(
            future: Photos.get(photo.shotId),
            builder: (context, snap) => snap.hasData
                ? Image.memory(
                    snap.data!,
                    fit: BoxFit.cover,
                    gaplessPlayback: true,
                  )
                : const SizedBox.expand(),
          ),
        ),
      ),
    );
  }
}

/// One photo, full screen, with who took it and when (the phone's claim).
class PhotoViewer extends StatelessWidget {
  const PhotoViewer({super.key, required this.photo, this.onRemove});
  final AlbumPhoto photo;
  final Future<void> Function()? onRemove;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: M.camBg,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(12, 8, 12, 8),
              child: Row(
                children: [
                  IconBtn(
                    icon: Ph.x,
                    label: 'Close',
                    dark: true,
                    onTap: () => Navigator.of(context).pop(),
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        Text(
                          photo.guestName,
                          style: M.headline.copyWith(
                            color: Colors.white,
                            fontSize: 15,
                          ),
                        ),
                        Text(
                          '${photo.rollName} · phone says ${clock(photo.takenAt)}',
                          style: M.footnote.copyWith(color: M.camMuted),
                        ),
                      ],
                    ),
                  ),
                  if (onRemove != null)
                    IconBtn(
                      icon: Ph.trash,
                      label: 'Remove photo',
                      dark: true,
                      onTap: () async {
                        await onRemove!();
                        if (context.mounted) Navigator.of(context).pop();
                      },
                    )
                  else
                    const SizedBox(width: 40),
                ],
              ),
            ),
            Expanded(
              child: Center(
                child: FutureBuilder<Uint8List>(
                  future: Photos.get(photo.shotId, thumb: false),
                  builder: (context, snap) => snap.hasData
                      ? InteractiveViewer(child: Image.memory(snap.data!))
                      : const CircularProgressIndicator(
                          color: Colors.white,
                          strokeWidth: 2,
                        ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
