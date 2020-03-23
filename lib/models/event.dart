final String databaseEvent = "events";
final String tableEvent = "events";
final String columnId = 'id';
final String columnEventName = "event_name";
final String columnEventDate = "event_date";
final String columnIsAnnual = "is_annual";
final String columnDaysAhead = "days_ahead";
final String columnEveryNDays = "every_n_days";

class Event {
  int id;
  DateTime eventDate;
  String eventName;
  bool isAnnual;
  int daysAhead;
  int everyNDays;
  Event(
      {this.id,
      this.eventName,
      this.eventDate,
      this.isAnnual,
      this.daysAhead,
      this.everyNDays});

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      columnEventName: eventName,
      columnEventDate: eventDate.toIso8601String(),
      columnIsAnnual: isAnnual,
      columnDaysAhead: daysAhead,
      columnEveryNDays: everyNDays,
    };
    if (id != null) {
      map[columnId] = id;
    }
    return map;
  }

  Event.fromMap(Map<String, dynamic> map) {
    id = map[columnId];
    eventName = map[columnEventName];
    eventDate = DateTime.parse(map[columnEventDate]);
    isAnnual = map[columnIsAnnual];
    daysAhead = map[columnDaysAhead];
    everyNDays = map[columnEveryNDays];
  }
}
