String formatDate(DateTime dt) {
  const months = [
    'JAN',
    'FEB',
    'MAR',
    'APR',
    'MAY',
    'JUN',
    'JUL',
    'AUG',
    'SEP',
    'OCT',
    'NOV',
    'DEC',
  ];
  final d = dt.day.toString().padLeft(2, '0');
  return '$d ${months[dt.month - 1]} ${dt.year}';
}

String formatDateUpper(DateTime d) {
  // 12 DEC 2022
  const months = [
    'JAN',
    'FEB',
    'MAR',
    'APR',
    'MAY',
    'JUN',
    'JUL',
    'AUG',
    'SEP',
    'OCT',
    'NOV',
    'DEC',
  ];
  final m = months[d.month - 1];
  return '${d.day.toString().padLeft(2, '0')} $m ${d.year}';
}
