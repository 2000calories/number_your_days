import 'package:number_your_days/data_providers/event_data_provider.dart';
import 'package:bloc/bloc.dart';
import 'package:number_your_days/route_generator.dart';
import 'package:number_your_days/screens/event_list.dart';
import 'blocs/simple_bloc_delegate.dart';
import 'widgets/bottom_nav_bar.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:i18n_extension/i18n_widget.dart';                 
import 'common.dart';

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
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: [
        const Locale('en'),
        const Locale('zh', "CN"),
        const Locale('zh', "HK"),
      ],
      onGenerateRoute: RouteGenerator.generateRoute,
      theme: ThemeData(
        primaryColor:  Colors.green,
        primarySwatch: Colors.green,
      ),
      home: I18n(child: MyHomePage()),
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
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Text(title.i18n),
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
