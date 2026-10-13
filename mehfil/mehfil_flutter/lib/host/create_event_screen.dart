import 'package:flutter/material.dart';
import 'package:mehfil_client/mehfil_client.dart';

import '../client.dart';
import '../ui/format.dart';
import '../ui/icons.dart';
import '../ui/theme.dart';
import '../ui/widgets.dart';

/// New event: a name, who is hosting, and one roll per function with the
/// time its album opens (default: the next morning at 9:00).
class CreateEventScreen extends StatefulWidget {
  const CreateEventScreen({super.key});

  @override
  State<CreateEventScreen> createState() => _CreateEventScreenState();
}

class _Draft {
  _Draft(String name, this.revealAt) : name = TextEditingController(text: name);
  final TextEditingController name;
  DateTime revealAt;
}

class _CreateEventScreenState extends State<CreateEventScreen> {
  final _name = TextEditingController();
  final _hostedBy = TextEditingController();
  final _rolls = <_Draft>[];
  bool _demo = false;
  bool _busy = false;
  String? _error;

  static const _presets = ['Haldi', 'Mehndi', 'Sangeet', 'Shaadi', 'Reception'];

  static DateTime _nextMorning() {
    final now = DateTime.now();
    return DateTime(now.year, now.month, now.day + 1, 9);
  }

  @override
  void initState() {
    super.initState();
    _add('Sangeet');
  }

  void _add(String name) =>
      setState(() => _rolls.add(_Draft(name, _nextMorning())));

  Future<void> _pickTime(_Draft d) async {
    final date = await showDatePicker(
      context: context,
      initialDate: d.revealAt,
      firstDate: DateTime.now().subtract(const Duration(days: 1)),
      lastDate: DateTime.now().add(const Duration(days: 60)),
    );
    if (date == null || !mounted) return;
    final time = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(d.revealAt),
    );
    if (time == null) return;
    setState(
      () => d.revealAt = DateTime(
        date.year,
        date.month,
        date.day,
        time.hour,
        time.minute,
      ),
    );
  }

  Future<void> _create() async {
    final name = _name.text.trim();
    final rolls = [
      for (final d in _rolls)
        if (d.name.text.trim().isNotEmpty)
          RollDraft(
            name: d.name.text.trim(),
            revealAt: d.revealAt.toUtc(),
            shotsPerGuest: 27,
          ),
    ];
    if (name.isEmpty || rolls.isEmpty) {
      setState(
        () => _error = 'Give the event a name and at least one function.',
      );
      return;
    }
    setState(() {
      _busy = true;
      _error = null;
    });
    try {
      final created = await client.events.createEvent(
        name,
        rolls,
        isDemo: _demo,
        hostedBy: _hostedBy.text.trim(),
      );
      if (mounted) Navigator.of(context).pop(created);
    } catch (e) {
      setState(() => _error = friendlyError(e));
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return MPage(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
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
          Expanded(
            child: ListView(
              padding: const EdgeInsets.only(top: 16, bottom: 16),
              children: [
                Text('New event', style: M.largeTitle),
                const SizedBox(height: 24),
                const Caps('Event name'),
                const SizedBox(height: 8),
                TextField(
                  controller: _name,
                  textCapitalization: TextCapitalization.words,
                  style: M.body,
                  decoration: const InputDecoration(hintText: 'Riya & Arjun'),
                ),
                const SizedBox(height: 16),
                const Caps('Hosted by'),
                const SizedBox(height: 8),
                TextField(
                  controller: _hostedBy,
                  textCapitalization: TextCapitalization.words,
                  style: M.body,
                  decoration: const InputDecoration(
                    hintText: 'the Sharma family',
                  ),
                ),
                const SizedBox(height: 24),
                const Caps('Functions'),
                const SizedBox(height: 4),
                Text(
                  'Each gets 27 shots per guest and stays hidden until its time.',
                  style: M.footnote,
                ),
                const SizedBox(height: 8),
                for (final d in _rolls)
                  Container(
                    margin: const EdgeInsets.only(bottom: 8),
                    padding: const EdgeInsets.fromLTRB(14, 6, 6, 6),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(M.rCard),
                      border: Border.all(color: M.line),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: d.name,
                            style: M.headline,
                            decoration: const InputDecoration(
                              filled: false,
                              border: InputBorder.none,
                              enabledBorder: InputBorder.none,
                              focusedBorder: InputBorder.none,
                              isDense: true,
                              contentPadding: EdgeInsets.zero,
                            ),
                          ),
                        ),
                        Pill(
                          'Opens ${revealLabel(d.revealAt)}',
                          icon: Ph.clock,
                          onTap: () => _pickTime(d),
                        ),
                        if (_rolls.length > 1)
                          IconButton(
                            onPressed: () => setState(() => _rolls.remove(d)),
                            icon: const Icon(Ph.x, size: 16, color: M.ink3),
                            tooltip: 'Remove',
                          ),
                      ],
                    ),
                  ),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    for (final p in _presets)
                      if (!_rolls.any((d) => d.name.text == p))
                        Pill(p, icon: Ph.plus, onTap: () => _add(p)),
                  ],
                ),
                const SizedBox(height: 20),
                GestureDetector(
                  onTap: () => setState(() => _demo = !_demo),
                  child: Row(
                    children: [
                      Icon(
                        _demo ? Ph.checkCircle : Ph.circleFill,
                        size: 22,
                        color: _demo ? M.ink : M.line,
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          'This is a demo event (labelled "demo" everywhere)',
                          style: M.subhead.copyWith(color: M.ink),
                        ),
                      ),
                    ],
                  ),
                ),
                if (_error != null) ...[
                  const SizedBox(height: 14),
                  Note(_error!),
                ],
              ],
            ),
          ),
          Button(label: 'Create event', busy: _busy, onTap: _create),
        ],
      ),
    );
  }
}
