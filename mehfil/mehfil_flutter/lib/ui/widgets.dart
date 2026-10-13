import 'package:flutter/material.dart';
import 'package:mehfil_client/mehfil_client.dart';

import 'icons.dart';
import 'theme.dart';

/// A page: white, content capped at phone width and centred on wide screens.
class MPage extends StatelessWidget {
  const MPage({
    super.key,
    required this.child,
    this.maxWidth = 480,
    this.padding = const EdgeInsets.fromLTRB(M.margin, 12, M.margin, 20),
    this.background = M.bg,
  });

  final Widget child;
  final double maxWidth;
  final EdgeInsets padding;
  final Color background;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: BoxConstraints(maxWidth: maxWidth),
            child: Padding(padding: padding, child: child),
          ),
        ),
      ),
    );
  }
}

class Wordmark extends StatelessWidget {
  const Wordmark({super.key});

  @override
  Widget build(BuildContext context) => Text(
    'mehfil',
    style: M.headline.copyWith(
      fontSize: 18,
      fontWeight: FontWeight.w700,
      letterSpacing: -0.3,
    ),
  );
}

/// Grey CAPS label above a section.
class Caps extends StatelessWidget {
  const Caps(this.text, {super.key, this.color});
  final String text;
  final Color? color;

  @override
  Widget build(BuildContext context) => Text(
    text.toUpperCase(),
    style: color == null ? M.caps : M.caps.copyWith(color: color),
  );
}

/// Pill button. Primary = black, one per screen. Secondary = light grey.
class Button extends StatelessWidget {
  const Button({
    super.key,
    required this.label,
    required this.onTap,
    this.icon,
    this.primary = true,
    this.busy = false,
    this.small = false,
    this.expand = true,
  });

  final String label;
  final VoidCallback? onTap;
  final IconData? icon;
  final bool primary;
  final bool busy;
  final bool small;
  final bool expand;

  @override
  Widget build(BuildContext context) {
    final enabled = onTap != null && !busy;
    final fg = primary ? M.bg : M.ink;
    final height = small ? 40.0 : (primary ? 54.0 : 44.0);
    final child = Row(
      mainAxisSize: expand ? MainAxisSize.max : MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (busy)
          SizedBox(
            width: 16,
            height: 16,
            child: CircularProgressIndicator(strokeWidth: 2, color: fg),
          )
        else if (icon != null)
          Icon(icon, size: small ? 17 : 19, color: fg),
        if (busy || icon != null) const SizedBox(width: 8),
        Flexible(
          child: Text(
            label,
            overflow: TextOverflow.ellipsis,
            style: M.headline.copyWith(
              color: fg,
              fontSize: small ? 14 : (primary ? 17 : 15),
            ),
          ),
        ),
      ],
    );
    return Semantics(
      button: true,
      enabled: enabled,
      child: MouseRegion(
        cursor: enabled ? SystemMouseCursors.click : SystemMouseCursors.basic,
        child: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: enabled ? onTap : null,
          child: AnimatedOpacity(
            duration: const Duration(milliseconds: 120),
            opacity: enabled || busy ? 1 : 0.4,
            child: Container(
              height: height,
              padding: EdgeInsets.symmetric(horizontal: small ? 14 : 20),
              decoration: BoxDecoration(
                color: primary ? M.ink : M.surface,
                borderRadius: BorderRadius.circular(99),
              ),
              child: child,
            ),
          ),
        ),
      ),
    );
  }
}

/// 40 pt round icon button on the grey surface (or a dark one on the camera).
class IconBtn extends StatelessWidget {
  const IconBtn({
    super.key,
    required this.icon,
    required this.label,
    required this.onTap,
    this.dark = false,
    this.size = 40,
  });

  final IconData icon;
  final String label;
  final VoidCallback? onTap;
  final bool dark;
  final double size;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      label: label,
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            color: dark ? M.camPanel : M.surface,
            shape: BoxShape.circle,
          ),
          child: Icon(icon, size: 20, color: dark ? Colors.white : M.ink),
        ),
      ),
    );
  }
}

/// A list row: leading tile, headline + one grey line, trailing widget.
class InfoRow extends StatelessWidget {
  const InfoRow({
    super.key,
    required this.title,
    this.subtitle,
    this.icon,
    this.leading,
    this.trailing,
    this.onTap,
    this.divider = true,
  });

  final Widget title;
  final String? subtitle;
  final IconData? icon;
  final Widget? leading;
  final Widget? trailing;
  final VoidCallback? onTap;
  final bool divider;

  @override
  Widget build(BuildContext context) {
    final lead =
        leading ??
        (icon == null
            ? null
            : Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: M.surface,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(icon, size: 22, color: M.ink),
              ));
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      child: Container(
        constraints: const BoxConstraints(minHeight: 64),
        padding: const EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          border: divider
              ? const Border(bottom: BorderSide(color: M.line))
              : null,
        ),
        child: Row(
          children: [
            if (lead != null) ...[lead, const SizedBox(width: 14)],
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  DefaultTextStyle(style: M.headline, child: title),
                  if (subtitle != null) Text(subtitle!, style: M.subhead),
                ],
              ),
            ),
            if (trailing != null) ...[const SizedBox(width: 12), trailing!],
          ],
        ),
      ),
    );
  }
}

/// Grey tile with a mono number and a label.
class StatTile extends StatelessWidget {
  const StatTile({super.key, required this.value, required this.label});
  final String value;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: M.surface,
        borderRadius: BorderRadius.circular(M.rCard),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(value, style: M.number(22)),
          const SizedBox(height: 2),
          Text(
            label,
            style: M.footnote,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}

/// Pill chip; selected = ink with white text.
class Pill extends StatelessWidget {
  const Pill(
    this.label, {
    super.key,
    this.selected = false,
    this.onTap,
    this.icon,
  });
  final String label;
  final bool selected;
  final VoidCallback? onTap;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    final fg = selected ? M.bg : M.ink;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 34,
        padding: const EdgeInsets.symmetric(horizontal: 14),
        decoration: BoxDecoration(
          color: selected ? M.ink : M.surface,
          borderRadius: BorderRadius.circular(99),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (icon != null) ...[
              Icon(icon, size: 15, color: fg),
              const SizedBox(width: 6),
            ],
            Text(label, style: M.headline.copyWith(fontSize: 14, color: fg)),
          ],
        ),
      ),
    );
  }
}

/// Small grey tag ("Demo event").
class Tag extends StatelessWidget {
  const Tag(this.label, {super.key});
  final String label;

  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
    decoration: BoxDecoration(
      color: M.surface,
      borderRadius: BorderRadius.circular(99),
    ),
    child: Text(
      label,
      style: M.footnote.copyWith(fontSize: 12, fontWeight: FontWeight.w600),
    ),
  );
}

/// Grey status card with an icon, two lines and an optional progress bar.
class StatusCard extends StatelessWidget {
  const StatusCard({
    super.key,
    required this.icon,
    required this.title,
    this.subtitle,
    this.progress,
    this.iconColor = M.ink,
    this.trailing,
  });

  final IconData icon;
  final String title;
  final String? subtitle;
  final double? progress;
  final Color iconColor;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: M.surface,
        borderRadius: BorderRadius.circular(M.rCard),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Icon(icon, size: 22, color: iconColor),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title, style: M.headline.copyWith(fontSize: 15)),
                    if (subtitle != null) Text(subtitle!, style: M.footnote),
                  ],
                ),
              ),
              ?trailing,
            ],
          ),
          if (progress != null) ...[
            const SizedBox(height: 10),
            ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: LinearProgressIndicator(
                value: progress!.clamp(0, 1),
                minHeight: 4,
                backgroundColor: M.line,
                color: M.accent,
              ),
            ),
          ],
        ],
      ),
    );
  }
}

/// One-line message in a grey card (errors included: no red, ever).
class Note extends StatelessWidget {
  const Note(this.text, {super.key, this.icon = Ph.info});
  final String text;
  final IconData icon;

  @override
  Widget build(BuildContext context) => StatusCard(icon: icon, title: text);
}

/// Avatars made of initials, overlapping.
class Initials extends StatelessWidget {
  const Initials(this.names, {super.key, this.size = 26});
  final List<String> names;
  final double size;

  @override
  Widget build(BuildContext context) {
    final shown = names.take(3).toList();
    return SizedBox(
      width: size + (shown.length - 1).clamp(0, 9) * (size - 8),
      height: size,
      child: Stack(
        children: [
          for (final (i, n) in shown.indexed)
            Positioned(
              left: i * (size - 8),
              child: Container(
                width: size,
                height: size,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: M.line,
                  shape: BoxShape.circle,
                  border: Border.all(color: M.bg, width: 2),
                ),
                child: Text(
                  n.isEmpty ? '?' : n.characters.first.toUpperCase(),
                  style: M.footnote.copyWith(
                    fontSize: size * 0.42,
                    fontWeight: FontWeight.w700,
                    color: M.ink,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class TabItem {
  const TabItem(this.label, this.icon, this.selectedIcon);
  final String label;
  final IconData icon;
  final IconData selectedIcon;
}

/// The floating pill tab bar.
class FloatingTabs extends StatelessWidget {
  const FloatingTabs({
    super.key,
    required this.items,
    required this.index,
    required this.onSelect,
  });

  final List<TabItem> items;
  final int index;
  final ValueChanged<int> onSelect;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(6),
      decoration: BoxDecoration(
        color: M.bg,
        borderRadius: BorderRadius.circular(99),
        border: Border.all(color: M.line),
        boxShadow: M.floatShadow,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          for (final (i, item) in items.indexed)
            Semantics(
              button: true,
              selected: i == index,
              label: item.label,
              excludeSemantics: true,
              child: GestureDetector(
                onTap: () => onSelect(i),
                child: Container(
                  width: 84,
                  height: 48,
                  decoration: BoxDecoration(
                    color: i == index ? M.surface : Colors.transparent,
                    borderRadius: BorderRadius.circular(99),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        i == index ? item.selectedIcon : item.icon,
                        size: 22,
                        color: i == index ? M.ink : M.ink2,
                      ),
                      const SizedBox(height: 2),
                      Text(
                        item.label,
                        style: M.footnote.copyWith(
                          fontSize: 11,
                          fontWeight: i == index
                              ? FontWeight.w700
                              : FontWeight.w600,
                          color: i == index ? M.ink : M.ink2,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

void toast(BuildContext context, String message) {
  ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(
      SnackBar(content: Text(message), duration: const Duration(seconds: 3)),
    );
}

/// Human message for any error the server or the network throws.
String friendlyError(Object error) {
  if (error is MehfilException) return error.message;
  final text = error.toString();
  final match = RegExp(r'message: ([^,)]+)').firstMatch(text);
  if (match != null) return match.group(1)!.trim();
  if (isNoSignal(error)) {
    return 'No signal right now. Try again when you are back online.';
  }
  return 'Something went wrong. Please try again.';
}

/// True when [error] means the phone could not reach the server at all.
bool isNoSignal(Object error) {
  if (error is MehfilException) return false;
  final text = error.toString();
  return text.contains('SocketException') ||
      text.contains('XMLHttpRequest') ||
      text.contains('Failed to fetch') ||
      text.contains('ClientException');
}
