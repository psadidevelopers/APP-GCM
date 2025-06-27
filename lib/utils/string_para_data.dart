DateTime stringParaData(String dataString) {
  final parts = dataString.split(
    '/',
  ); // Ex: '27/06/2025' -> ['27', '06', '2025']
  return DateTime(
    int.parse(parts[2]), // ano
    int.parse(parts[1]), // mês
    int.parse(parts[0]), // dia
  );
}
