import 'package:number_your_days/common.dart';

class SettingsScreen extends StatelessWidget {
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
        ),
        bottomNavigationBar: MyBottomNavBar(
          selectedIndex: 2,
        ));
  }
}
