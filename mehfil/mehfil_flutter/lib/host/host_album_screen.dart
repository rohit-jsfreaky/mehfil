import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:mehfil_client/mehfil_client.dart';

import '../client.dart';
import '../guest/album_screen.dart';
import '../ui/format.dart';
import '../ui/icons.dart';
import '../ui/theme.dart';
import '../ui/widgets.dart';

/// The host's view of the revealed album, with the power to remove a photo
/// for everyone (it leaves every phone on the next sync).
class HostAlbumScreen extends StatefulWidget {
  const HostAlbumScreen({super.key, required this.event});
  final Event event;

  @override
  State<HostAlbumScreen> createState() => _HostAlbumScreenState();
}

class _HostAlbumScreenState extends State<HostAlbumScreen> {
  late Future<List<AlbumPhoto>> _photos = client.events.album(widget.event.id!);

  void _reload() =>
      setState(() => _photos = client.events.album(widget.event.id!));

  Future<void> _remove(AlbumPhoto photo) async {
    final ok = await showDialog<bool>(
      context: context,
      builder: (c) => AlertDialog(
        title: Text('Remove this photo?', style: M.title),
        content: Text(
          "It disappears from everyone's album, including phones that already have it.",
          style: M.body.copyWith(color: M.ink2),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(c, false),
            child: Text('Cancel', style: M.headline),
          ),
          TextButton(
            onPressed: () => Navigator.pop(c, true),
            child: Text('Remove', style: M.headline),
          ),
        ],
      ),
    );
    if (ok != true) return;
    try {
      await client.events.removePhoto(photo.shotId);
      if (mounted) toast(context, 'Photo removed for everyone');
      _reload();
    } catch (e) {
      if (mounted) toast(context, friendlyError(e));
    }
  }

  @override
  Widget build(BuildContext context) {
    return MPage(
      maxWidth: 720,
      padding: const EdgeInsets.fromLTRB(0, 12, 0, 0),
      child: FutureBuilder<List<AlbumPhoto>>(
        future: _photos,
        builder: (context, snap) {
          final photos = snap.data ?? const <AlbumPhoto>[];
          final guests = photos.map((p) => p.guestName).toSet().length;
          return CustomScrollView(
            slivers: [
              SliverPadding(
                padding: const EdgeInsets.symmetric(horizontal: M.margin),
                sliver: SliverToBoxAdapter(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 40,
                        child: Row(
                          children: [
                            IconBtn(
                              icon: Ph.caretLeft,
                              label: 'Back',
                              onTap: () => Navigator.of(context).maybePop(),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 12),
                      Text(widget.event.name, style: M.display),
                      const SizedBox(height: 4),
                      Text(
                        '${plural(photos.length, 'photo')} · ${plural(guests, 'guest')} · tap a photo to remove it',
                        style: M.subhead,
                      ),
                      const SizedBox(height: 16),
                      if (snap.hasError) Note(friendlyError(snap.error!)),
                      if (!snap.hasData && !snap.hasError)
                        const Center(
                          child: CircularProgressIndicator(
                            color: M.ink,
                            strokeWidth: 2,
                          ),
                        ),
                    ],
                  ),
                ),
              ),
              SliverGrid(
                gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 160,
                  mainAxisSpacing: 2,
                  crossAxisSpacing: 2,
                ),
                delegate: SliverChildBuilderDelegate(
                  (context, i) {
                    final p = photos[i];
                    return GestureDetector(
                      onTap: () => Navigator.of(context).push(
                        MaterialPageRoute<void>(
                          builder: (_) =>
                              PhotoViewer(photo: p, onRemove: () => _remove(p)),
                        ),
                      ),
                      child: Container(
                        color: M.surface,
                        child: FutureBuilder<Uint8List>(
                          future: Photos.get(p.shotId),
                          builder: (context, s) => s.hasData
                              ? Image.memory(
                                  s.data!,
                                  fit: BoxFit.cover,
                                  gaplessPlayback: true,
                                )
                              : const SizedBox.expand(),
                        ),
                      ),
                    );
                  },
                  childCount: photos.length,
                ),
              ),
              const SliverToBoxAdapter(child: SizedBox(height: 40)),
            ],
          );
        },
      ),
    );
  }
}
