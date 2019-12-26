import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:number_your_days/widgets/event_item.dart';
import '../blocs/events/bloc.dart';

class EventListScreen extends StatefulWidget {
  @override
  _EventListScreenState createState() => _EventListScreenState();
}

class _EventListScreenState extends State<EventListScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EventsBloc, EventsState>(
      builder: (context, state) {
        if (state is EventsLoading) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is EventsLoaded) {
          final events = state.events;
          return ListView.builder(
            itemCount: events.length,
            itemBuilder: (BuildContext context, int index) {
              final event = events[index];
              Map<String, dynamic> arguments = new Map();
              arguments['event'] = event;
              return EventItem(
                event: event,
                onTap: () async {
                 Navigator.of(context).pushNamed('/eventEdit',arguments:arguments);
                },
              );
            },
          );
        } else {
          return Container();
        }
      },
    );
  }
}