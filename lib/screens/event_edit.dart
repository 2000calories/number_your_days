import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:number_your_days/blocs/events/bloc.dart';
import 'package:number_your_days/models/event.dart';
import 'package:number_your_days/widgets/widgets.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class EventEditScreen extends StatefulWidget {
  final Event event;
  EventEditScreen({@required this.event});

  @override
  _EventEditScreenState createState() => _EventEditScreenState(event: event);
}

class _EventEditScreenState extends State<EventEditScreen> {
  final Event event;
  _EventEditScreenState({@required this.event});

  final GlobalKey<FormBuilderState> _fbKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    //ignore: close_sinks
    final EventsBloc eventsBloc = BlocProvider.of<EventsBloc>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Edit'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: FormBuilder(
            key: _fbKey,
            initialValue: {
              'event_name': event.eventName,
              'event_date': event.eventDate,
              'is_annual': event.isAnnual,
              'every_n_days': event.everyNDays.toString(),
              'days_ahead': event.daysAhead.toString(),
            },
            autovalidate: true,
            child: Column(children: <Widget>[
              FormBuilderTextField(
                attribute: "event_name",
                decoration: InputDecoration(labelText: "Event Name"),
                validators: [
                  FormBuilderValidators.required(),
                ],
              ),
              FormBuilderDateTimePicker(
                attribute: "event_date",
                inputType: InputType.date,
                format: DateFormat("yyyy-MM-dd"),
                decoration: InputDecoration(labelText: "Appointment Time"),
                validators: [
                  FormBuilderValidators.required(),
                ],
              ),
              FormBuilderCheckbox(
                attribute: 'is_annual',
                leadingInput: true,
                label: Text("Is this an annual event?"),
              ),
              FormBuilderTextField(
                attribute: "every_n_days",
                decoration: InputDecoration(labelText: "Remind Every N Days"),
                validators: [
                  FormBuilderValidators.required(),
                  FormBuilderValidators.numeric(),
                ],
              ),
              FormBuilderTextField(
                attribute: "days_ahead",
                decoration: InputDecoration(labelText: "Remind N Days Ahead"),
                validators: [
                  FormBuilderValidators.required(),
                  FormBuilderValidators.numeric(),
                ],
              ),
            ]),
          ),
        ),
      ),
      bottomNavigationBar: MyBottomNavBar(
        selectedIndex: 0,
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: 'Update',
        child: Icon(Icons.done),
        onPressed: () {
          if (_fbKey.currentState.saveAndValidate()) {
            var value = _fbKey.currentState.value;

            var updatedEvent = Event(
              id: event.id,
              eventName: value['event_name'],
              eventDate: value['event_date'],
              isAnnual: value['is_annual'],
              everyNDays: int.parse(value['every_n_days']),
              daysAhead: int.parse(value['days_ahead']),
            );
            eventsBloc.add(UpdateEvent(updatedEvent: updatedEvent));
            Navigator.pop(context);
          }
        },
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
