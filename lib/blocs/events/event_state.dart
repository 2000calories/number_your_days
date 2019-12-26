import 'package:equatable/equatable.dart';
import 'package:number_your_days/models/event.dart';

abstract class EventsState extends Equatable {
  const EventsState();
  
  @override
  List<Object> get props => [];
}

class InitialEventsState extends EventsState {
  @override
  List<Object> get props => [];
}

class EventsLoading extends EventsState {}

class EventsLoaded extends EventsState {
  final List<Event> events;

  const EventsLoaded([this.events = const []]);

  @override
  List<Object> get props => [events];

  @override
  String toString() => 'EventLoaded { events: $events }';
}

class EventsNotLoaded extends EventsState {}
