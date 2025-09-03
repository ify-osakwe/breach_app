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
