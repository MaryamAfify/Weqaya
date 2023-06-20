class Dates {
  final List<DateTime> date;

  Dates({required this.date});

 factory Dates.fromJson(List<dynamic> json) {
    List<DateTime> dateList = json.map((date) => DateTime.parse(date)).toList();
    return Dates(date: dateList);
  }

}
