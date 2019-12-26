import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:number_your_days/blocs/events/bloc.dart';
import 'package:number_your_days/models/event.dart';

class EventCreateScreen extends StatefulWidget {
  @override
  _EventCreateScreenState createState() => _EventCreateScreenState();
}

class _EventCreateScreenState extends State<EventCreateScreen> {
  final int _selectedIndex = 1;
  static final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController eventDateFieldController =
      TextEditingController();
  final TextEditingController eventNameFieldController =
      TextEditingController();
  final TextEditingController eventTypeFieldController =
      TextEditingController();
  String _eventName;
  String _eventType = 'Passed';
  DateTime _eventDate;

  Future _selectEventDate() async {
    DateTime picked = await showDatePicker(
        context: context,
        initialDate: new DateTime.now(),
        firstDate: new DateTime(1900),
        lastDate: new DateTime(2100));
    if (picked != null) {
      setState(() => _eventDate = picked);
      eventDateFieldController.text = DateFormat('yyyy-MM-dd').format(picked);
    }
  }

  _selectEventType() {
    return InputDecorator(
      decoration: InputDecoration(
        labelText: 'Event Type',
        labelStyle: TextStyle(fontSize: 22),
        hintText: '',
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: _eventType,
          iconSize: 24,
          isDense: true,
          isExpanded: true,
          onChanged: (String newValue) {
            setState(() {
              _eventType = newValue;
            });
          },
          items: <String>['Passed', 'Future']
              .map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    //ignore: close_sinks
    final EventsBloc eventsBloc = BlocProvider.of<EventsBloc>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Create'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: eventNameFieldController,
                style: TextStyle(fontSize: 16),
                decoration: InputDecoration(
                  labelText: 'Event Name',
                  hintText: '',
                ),
                validator: (val) {
                  return val.trim().isEmpty
                      ? 'localizations.emptyTodoError'
                      : null;
                },
                onSaved: (value) => _eventName = value,
              ),
              new FormField(
                builder: (FormFieldState state) {
                  return _selectEventType();
                },
              ),
              TextFormField(
                controller: eventDateFieldController,
                style: TextStyle(fontSize: 16),
                decoration: InputDecoration(
                  labelText: 'Event Date',
                  hintText: '',
                ),
                onSaved: (value) => _eventDate = DateTime.parse(value),
                onTap: () => _selectEventDate(),
              )
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            title: Text('List'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            title: Text('Setting'),
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.green,
        onTap: (index) {
          if (index == _selectedIndex) {

          }
          switch (index) {
            case 0:
              Navigator.of(context).pushNamed('/');
              break;
            default:
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: 'Create',
        child: Icon(Icons.add),
        onPressed: () {
          if (_formKey.currentState.validate()) {
            _formKey.currentState.save();
            var event = Event(
                eventName: _eventName,
                eventType: _eventType,
                eventDate: _eventDate);
            eventsBloc.add(AddEvent(event));
            Navigator.pop(context);
          }
        },
      ),
    );
  }
}
