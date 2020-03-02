import 'package:flutter/material.dart';
import 'package:number_your_days/data_providers/event_data_provider.dart';
import 'package:number_your_days/localization.dart';
import 'package:bloc/bloc.dart';
import 'package:number_your_days/route_generator.dart';
import 'package:number_your_days/screens/event_list.dart';
import 'blocs/simple_bloc_delegate.dart';
import 'blocs/events/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  BlocSupervisor.delegate = SimpleBlocDelegate();
  var eventDataProvider = EventDataProvider();

  runApp(
    BlocProvider(
      create: (context) {
        return EventsBloc(eventDataProvider: eventDataProvider)
          ..add(LoadEvents());
      },
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Number Your Days',
      onGenerateRoute: RouteGenerator.generateRoute,
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      localizationsDelegates: [
        FlutterBlocLocalizationsDelegate(),
      ],
      home: MyHomePage(title: 'Number Your Days'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    //ignore: close_sinks
    final EventsBloc eventsBloc = BlocProvider.of<EventsBloc>(context);

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Text(widget.title),
      ),
      body: EventListScreen(),
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
            eventsBloc.add(LoadEvents());
            return;
          }
          switch (index) {
            case 0:
              Navigator.of(context).pushReplacementNamed('/');
              break;
            default:
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/eventCreate');
        },
        tooltip: 'Add',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
