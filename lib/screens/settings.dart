import 'package:number_your_days/common.dart';
import 'package:number_your_days/models/event.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_porter/utils/csv_utils.dart';
import 'package:number_your_days/data_providers/event_data_provider.dart';
import 'package:number_your_days/my_shared_preference.dart';

class SettingsScreen extends StatefulWidget {
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final mySharedPreferences = MySharedPreferences();
  bool isSyncOnCalendar = true;

  @override
  void initState() {
    super.initState();
    getIsSyncOnCalendarSetting();
  }

  getIsSyncOnCalendarSetting() async {
    var _isSyncOnCalendar = await mySharedPreferences.getIsSyncOnCalendar();
    setState(() {
      isSyncOnCalendar = _isSyncOnCalendar;
    });
  }

  updateIsSyncOnCalendarSetting(bool value) async {
    await mySharedPreferences.setIsSyncOnCalendar(value);
    setState(() {
      isSyncOnCalendar = value;
    });
  }

  exportToCSV() async {
    final eventDataProvider = EventDataProvider();
    String databasesPath = await getDatabasesPath();
    String path = databasesPath + databaseEvent;
    //await deleteDatabase(path);
    await eventDataProvider.open(path);
    var eventData = await eventDataProvider.getEventTableData();
    var csv = mapListToCsv(eventData);
  }

  Widget settingCard(Widget child) {
    return Card(
      margin: EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: EdgeInsets.only(left: 16, top: 8.0, right: 8.0, bottom: 8.0),
        child: child,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          centerTitle: true,
          title: Text('Setting'.i18n),
        ),
        body: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              settingCard(
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      'Sync Events on Calendar'.i18n,
                      style: Theme.of(context).textTheme.subhead,
                    ),
                    Switch(
                        value: isSyncOnCalendar,
                        // activeColor: cyanColor,
                        onChanged: (bool value) {
                          updateIsSyncOnCalendarSetting(value);
                        }),
                  ],
                ),
              ),
              settingCard(
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      'Export Data to CSV File'.i18n,
                      style: Theme.of(context).textTheme.subhead,
                    ),
                    IconButton(
                      //color: Theme.of(context).primaryColor,
                      icon: Icon(Icons.file_download),
                      onPressed: () {
                        exportToCSV();
                      },
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
        bottomNavigationBar: MyBottomNavBar(
          selectedIndex: 2,
        ));
  }
}
