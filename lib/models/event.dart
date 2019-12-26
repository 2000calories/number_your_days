final String tableEvent = "events";
final String columnId = 'id';
final String columnEventName = "event_name";
final String columnEventDate = "event_date";
final String columnEventType = "event_type";

class Event {
  int id;
  DateTime eventDate;
  String eventName;
  String eventType;
  Event({this.id,this.eventName, this.eventDate, this.eventType});

  String today = new DateTime.now().toString();

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      columnEventName: eventName,
      columnEventDate: eventDate.toIso8601String(),
      columnEventType: eventType,
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
    eventType = map[columnEventType];
  }
}

