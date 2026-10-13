const _months = [
  'Jan',
  'Feb',
  'Mar',
  'Apr',
  'May',
  'Jun',
  'Jul',
  'Aug',
  'Sep',
  'Oct',
  'Nov',
  'Dec',
];

String clock(DateTime t) {
  final local = t.toLocal();
  final h = local.hour % 12 == 0 ? 12 : local.hour % 12;
  final m = local.minute.toString().padLeft(2, '0');
  return '$h:$m ${local.hour < 12 ? 'AM' : 'PM'}';
}

/// "today, 9:00 PM", "tomorrow, 9:00 AM" or "14 Oct, 9:00 AM" (phone's zone).
String revealLabel(DateTime at, {DateTime? now}) {
  final local = at.toLocal();
  final today = (now ?? DateTime.now()).toLocal();
  final d0 = DateTime(today.year, today.month, today.day);
  final d1 = DateTime(local.year, local.month, local.day);
  final days = d1.difference(d0).inDays;
  final day = switch (days) {
    0 => 'today',
    1 => 'tomorrow',
    _ => '${local.day} ${_months[local.month - 1]}',
  };
  return '$day, ${clock(local)}';
}

/// "04:12:09" or "2d 04:12".
String countdown(Duration left) {
  if (left.isNegative) return '00:00:00';
  String two(int n) => n.toString().padLeft(2, '0');
  final h = left.inHours;
  if (h >= 48) {
    return '${left.inDays}d ${two(h % 24)}:${two(left.inMinutes % 60)}';
  }
  return '${two(h)}:${two(left.inMinutes % 60)}:${two(left.inSeconds % 60)}';
}

/// 1240 -> "1,240".
String grouped(int n) {
  final s = n.toString();
  final out = StringBuffer();
  for (var i = 0; i < s.length; i++) {
    if (i > 0 && (s.length - i) % 3 == 0) out.write(',');
    out.write(s[i]);
  }
  return out.toString();
}

String plural(int n, String one, [String? many]) =>
    '${grouped(n)} ${n == 1 ? one : (many ?? '${one}s')}';
