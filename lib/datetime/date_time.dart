// Retorna a data de hoje formatada como aaaammdd
String todaysDateFormatted() {
  // Hoje
  var dateTimeObject = DateTime.now();

  // Ano no formato aaaa
  String year = dateTimeObject.year.toString();

  // Mês no formato mm
  String month = dateTimeObject.month.toString();
  if (month.length == 1) {
    month = '0$month'; // Adiciona um zero à esquerda se o mês for de apenas um dígito
  }

  // Dia no formato dd
  String day = dateTimeObject.day.toString();
  if (day.length == 1) {
    day = '0$day'; // Adiciona um zero à esquerda se o dia for de apenas um dígito
  }

  // Formato final
  String aaaammdd = year + month + day;

  return aaaammdd;
}

// Converte a string aaaammdd em um objeto DateTime
DateTime createDateTimeObject(String aaaammdd) {
  int aaaa = int.parse(aaaammdd.substring(0, 4));
  int mm = int.parse(aaaammdd.substring(4, 6));
  int dd = int.parse(aaaammdd.substring(6, 8));

  // Cria um objeto DateTime com ano, mês e dia extraídos da string
  DateTime dateTimeObject = DateTime(aaaa, mm, dd);
  return dateTimeObject;
}

// Converte um objeto DateTime em uma string aaaammdd
String convertDateTimeToString(DateTime dateTime) {
  // Ano no formato aaaa
  String year = dateTime.year.toString();

  // Mês no formato mm
  String month = dateTime.month.toString();
  if (month.length == 1) {
    month = '0$month'; // Adiciona um zero à esquerda se o mês for de apenas um dígito
  }

  // Dia no formato dd
  String day = dateTime.day.toString();
  if (day.length == 1) {
    day = '0$day'; // Adiciona um zero à esquerda se o dia for de apenas um dígito
  }

  // Formato final
  String aaaammdd = year + month + day;

  return aaaammdd;
}
