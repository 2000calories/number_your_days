import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:number_your_days/blocs/events/bloc.dart';
import 'package:number_your_days/models/event.dart';

class EventEditScreen extends StatefulWidget {
  final Event event;
  EventEditScreen({@required this.event});

  @override
  _EventEditScreenState createState() => _EventEditScreenState(event: event);
}

class _EventEditScreenState extends State<EventEditScreen> {
  final Event event;
  _EventEditScreenState({@required this.event});

  final int _selectedIndex = 0;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController eventDateFieldController =
      TextEditingController();
  final TextEditingController eventNameFieldController =
      TextEditingController();

  String _eventName;
  String _eventType;
  DateTime _eventDate;
  List<String> eventTypes = ['Annual','Passed', 'Future'];

  @override
  initState() {
    setState(() {
      _eventName = event.eventName;
      _eventType = event.eventType;
      _eventDate = event.eventDate;
      eventNameFieldController.text = _eventName;
      eventDateFieldController.text =
          DateFormat('yyyy-MM-dd').format(_eventDate);
    });
    super.initState();
  }

  Future _selectEventDate() async {
    var now = new DateTime.now();
    DateTime picked = await showDatePicker(
        context: context,
        initialDate: now,
        firstDate:  _eventType=='Future'?now:new DateTime(1900),
        lastDate: _eventType=='Passed'?now: new DateTime(2100));
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
          items: eventTypes
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
        title: Text('Edit'),
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
          if (index == _selectedIndex) {}
          switch (index) {
            case 0:
              Navigator.of(context).pushNamed('/');
              break;
            default:
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: 'Update',
        child: Icon(Icons.add),
        onPressed: () {
          if (_formKey.currentState.validate()) {
            _formKey.currentState.save();
            event.id = event.id;
            event.eventName = eventNameFieldController.text;
            event.eventType = _eventType;
            event.eventDate = DateTime.parse(eventDateFieldController.text);
            eventsBloc.add(UpdateEvent(updatedEvent: event));
            Navigator.pop(context);
          }
        },
      ),
    );
  }

  @override
  void dispose() {
    eventDateFieldController.dispose();
    eventNameFieldController.dispose();
    super.dispose();
  }
}
