import 'package:number_your_days/models/event.dart';
import 'package:sqflite/sqflite.dart';

class EventDataProvider {
  Database db;

  Future open(String path) async {
    //await deleteDatabase(path);
    db = await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      await db.execute('''
create table $tableEvent ( 
  $columnId integer primary key autoincrement, 
  $columnEventName text not null, 
  $columnEventDate text not null,
  $columnIsAnnual integer DEFAULT 0,
  $columnDaysAhead integer DEFAULT 0,
  $columnEveryNDays integer DEFAULT 0
  )
''');
    });
  }

  Future<Event> insert(Event event) async {
    event.id = await db.insert(tableEvent, event.toMap());
    return event;
  }

  Future<Event> getEvent(int id) async {
    List<Map> maps = await db.query(tableEvent,
        columns: [
          columnId,
          columnEventName,
          columnEventDate,
          columnIsAnnual,
          columnDaysAhead,
          columnEveryNDays
        ],
        where: '$columnId = ?',
        whereArgs: [id]);
    if (maps.length > 0) {
      return Event.fromMap(maps.first);
    }
    return null;
  }

  Future<int> delete(int id) async {
    return await db.delete(tableEvent, where: '$columnId = ?', whereArgs: [id]);
  }

  Future<int> update(Event event) async {
    return await db.update(tableEvent, event.toMap(),
        where: '$columnId = ?', whereArgs: [event.id]);
  }

  Future<List<Event>> getAllEvents() async {
    List<Map<String, dynamic>> eventRecords = await db.query(tableEvent);
    List<Event> events = eventRecords.map((eventRecord) {
      var event = new Event(
        id: eventRecord[columnId],
        eventName: eventRecord[columnEventName],
        eventDate: DateTime.parse(eventRecord[columnEventDate]),
        isAnnual: eventRecord[columnIsAnnual] == 1 ? true : false,
        daysAhead: (eventRecord[columnDaysAhead]),
        everyNDays:(eventRecord[columnEveryNDays]),
      );
      return event;
    }).toList();
    return events;
  }

  Future close() async => db.close();
}
