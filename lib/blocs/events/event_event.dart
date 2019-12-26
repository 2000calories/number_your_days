import 'package:equatable/equatable.dart';
import 'package:number_your_days/models/event.dart';

abstract class EventsEvent extends Equatable {
  const EventsEvent();
  
  @override
  List<Object> get props => [];
}

class LoadEvents extends EventsEvent {}

class AddEvent extends EventsEvent {
  final Event event;

  const AddEvent(this.event);

  @override
  List<Object> get props => [event];

  @override
  String toString() => 'AddEvent { event: $event }';
}

class UpdateEvent extends EventsEvent {
  final Event updatedEvent;

  const UpdateEvent({this.updatedEvent});

  @override
  List<Object> get props => [updatedEvent];

  @override
  String toString() => 'UpdateEvent { updatedEvent: $updatedEvent }';
}

class DeleteEvent extends EventsEvent {
  final Event event;

  const DeleteEvent(this.event);

  @override
  List<Object> get props => [event];

  @override
  String toString() => 'DeleteEvent { event: $event }';
}