import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:number_your_days/data_providers/event_data_provider.dart';
import 'package:number_your_days/models/event.dart';
import 'package:sqflite/sqflite.dart';
import './bloc.dart';

class EventsBloc extends Bloc<EventsEvent, EventsState> {
  final EventDataProvider eventDataProvider;

  EventsBloc({@required this.eventDataProvider});

  @override
  EventsState get initialState => InitialEventsState();

  @override
  Stream<EventsState> mapEventToState(
    EventsEvent blocEvent,
  ) async* {
    if (blocEvent is LoadEvents) {
      yield* _mapLoadEventsToState();
    } else if (blocEvent is AddEvent) {
      yield* _mapAddEventToState(blocEvent);
    } else if (blocEvent is UpdateEvent) {
      yield* _mapUpdateEventToState(blocEvent);
    } else if (blocEvent is DeleteEvent) {
      yield* _mapDeleteEventToState(blocEvent);
    }
  }

  Stream<EventsState> _mapLoadEventsToState() async* {
    yield EventsLoading();

    String databasesPath = await getDatabasesPath();
    String path = databasesPath + databaseEvent;
    //await deleteDatabase(path);
    await eventDataProvider.open(path);
    List<Event> events = await eventDataProvider.getAllEvents();
    yield EventsLoaded(events);
  }

  Stream<EventsState> _mapAddEventToState(blocEvent) async* {
    if (state is EventsLoaded) {
      final List<Event> updatedEvents =
          List.from((state as EventsLoaded).events)..add(blocEvent.event);
      yield EventsLoaded(updatedEvents);
      eventDataProvider.insert(blocEvent.event);
    }
  }

  Stream<EventsState> _mapUpdateEventToState(blocEvent) async* {
    if (state is EventsLoaded) {
      List<Event> updatedEvents = [];
      (state as EventsLoaded).events.forEach((Event event) {
        return event.id == blocEvent.updatedEvent.id
            ? updatedEvents.add(blocEvent.updatedEvent)
            : updatedEvents.add(event);
      });
      yield EventsLoaded(updatedEvents);
      eventDataProvider.update(blocEvent.updatedEvent);
    }
  }

  Stream<EventsState> _mapDeleteEventToState(blocEvent) async* {}
}
