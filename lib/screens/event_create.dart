import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:number_your_days/blocs/events/bloc.dart';
import 'package:number_your_days/models/event.dart';
import 'package:number_your_days/widgets/widgets.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class EventCreateScreen extends StatefulWidget {
  @override
  _EventCreateScreenState createState() => _EventCreateScreenState();
}

class _EventCreateScreenState extends State<EventCreateScreen> {
  final GlobalKey<FormBuilderState> _fbKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    //ignore: close_sinks
    final EventsBloc eventsBloc = BlocProvider.of<EventsBloc>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Create'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: FormBuilder(
            key: _fbKey,
            initialValue: {
              'event_date': DateTime.now(),
              'is_annual': false,
              'every_n_days': '0',
              'days_ahead': '0'
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
        tooltip: 'Create',
        child: Icon(Icons.done),
        onPressed: () {
          if (_fbKey.currentState.saveAndValidate()) {
            var value = _fbKey.currentState.value;
            var event = Event(
              eventName: value['event_name'],
              eventDate: value['event_date'],
              isAnnual: value['is_annual'],
              everyNDays: int.parse(value['every_n_days']),
              daysAhead: int.parse(value['days_ahead']),
            );
            eventsBloc.add(AddEvent(event));
            Navigator.pop(context);
          }
        },
      ),
    );
  }
}
