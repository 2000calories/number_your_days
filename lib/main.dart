import 'package:flutter/material.dart';
import 'package:number_your_days/data_providers/event_data_provider.dart';
import 'package:number_your_days/localization.dart';
import 'package:bloc/bloc.dart';
import 'package:number_your_days/route_generator.dart';
import 'package:number_your_days/screens/event_list.dart';
import 'blocs/simple_bloc_delegate.dart';
import 'blocs/events/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'widgets/bottom_nav_bar.dart';

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
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({
    Key key,
  }) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final title = 'Number Your Days';

  @override
  Widget build(BuildContext context) {
    //ignore: close_sinks

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Text(title),
      ),
      body: EventListScreen(),
      bottomNavigationBar: MyBottomNavBar(
        selectedIndex: 0,
      ),
      floatingActionButton: FloatingActionButton(
        heroTag: null,
        onPressed: () {
          Navigator.pushNamed(context, '/eventCreate');
        },
        tooltip: 'Add',
        child: Icon(Icons.add),
      ),
    );
  }
}
