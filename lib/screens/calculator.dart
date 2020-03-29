import 'package:number_your_days/common.dart';
import 'package:intl/intl.dart';

class CalculatorScreen extends StatefulWidget {
  @override
  _CalculatorScreenState createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController startDateFieldController =
      TextEditingController();
  final TextEditingController endDateFieldController = TextEditingController();
  final TextEditingController numberFieldController = TextEditingController();

  DateTime startDate;
  DateTime endDate;
  int number;

  Future _selectStartDate() async {
    DateTime picked = await showDatePicker(
        context: context,
        initialDate: new DateTime.now(),
        firstDate: new DateTime(1900),
        lastDate: new DateTime(2100));
    if (picked != null) {
      setState(() => startDate = picked);
      startDateFieldController.text = DateFormat('yyyy-MM-dd').format(picked);
      changeStartDate();
    }
  }

  Future _selectEndDate() async {
    DateTime picked = await showDatePicker(
        context: context,
        initialDate: new DateTime.now(),
        firstDate: new DateTime(1900),
        lastDate: new DateTime(2100));
    if (picked != null) {
      setState(() => endDate = picked);
      endDateFieldController.text = DateFormat('yyyy-MM-dd').format(picked);
      changeEndDate();
    }
  }

  bool dateValidation(String dateString) {
    String p = "[0-9]{4}-[0-9]{2}-[0-9]{2}";
    RegExp regExp = new RegExp(p);

    if (regExp.hasMatch(dateString)) {
      // So, the email is valid
      return true;
    }
    return false;
  }

  changeNumber() {
    String _startDateString = startDateFieldController.text;
    String _endDateString = endDateFieldController.text;
    int number = int.tryParse(numberFieldController.text);
    //if start date valid, then change end date
    if (dateValidation(_startDateString) && (number != null)) {
      var endDate =
          DateTime.parse(_startDateString).add(Duration(days: number));
      endDateFieldController.text = endDate.toString().substring(0, 10);
      return;
    }
    //if start date invaild and end date valid, then change start date
    if (dateValidation(_endDateString) && (number != null)) {
      var endDate = DateTime.parse(_endDateString).add(Duration(days: number));
      startDateFieldController.text = endDate.toString().substring(0, 10);
      return;
    }
  }

  changeStartDate() {
    String _startDateString = startDateFieldController.text;
    String _endDateString = endDateFieldController.text;
    int number = int.tryParse(numberFieldController.text);
    if (dateValidation(_startDateString) && dateValidation(_endDateString)) {
      number = DateTime.parse(_endDateString)
          .difference(DateTime.parse(_startDateString))
          .inDays;
      numberFieldController.text = number.toString();
      return;
    }
    if (dateValidation(_startDateString) && (number != null)) {
      var endDate =
          DateTime.parse(_startDateString).add(Duration(days: number));
      endDateFieldController.text = endDate.toString().substring(0, 10);
      return;
    }
  }

  changeEndDate() {
    String _startDateString = startDateFieldController.text;
    String _endDateString = endDateFieldController.text;
    int number = int.tryParse(numberFieldController.text);
    if (dateValidation(_startDateString) && dateValidation(_endDateString)) {
      number = DateTime.parse(_endDateString)
          .difference(DateTime.parse(_startDateString))
          .inDays;
      numberFieldController.text = number.toString();
      return;
    }
    if (dateValidation(_endDateString) && (number != null)) {
      var endDate = DateTime.parse(_endDateString).add(Duration(days: number));
      startDateFieldController.text = endDate.toString().substring(0, 10);
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    //ignore: close_sinks

    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          centerTitle: true,
          title: Text('Calculator'.i18n),
        ),
        body: Padding(
          padding: EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: ListView(
              children: [
                TextFormField(
                  controller: startDateFieldController,
                  style: TextStyle(fontSize: 16),
                  decoration: InputDecoration(
                    labelText: 'Start Date'.i18n,
                    hintText: '',
                  ),
                  onTap: () => _selectStartDate(),
                ),
                TextFormField(
                  controller: endDateFieldController,
                  style: TextStyle(fontSize: 16),
                  decoration: InputDecoration(
                    labelText: 'End Date'.i18n,
                    hintText: '',
                  ),
                  onTap: () => _selectEndDate(),
                ),
                TextFormField(
                  autovalidate: true,
                  controller: numberFieldController,
                  style: TextStyle(fontSize: 16),
                  decoration: InputDecoration(
                    labelText: 'Number of Days'.i18n,
                    hintText: '1000',
                  ),
                  onChanged: (value) => changeNumber(),
                )
              ],
            ),
          ),
        ),
        bottomNavigationBar: MyBottomNavBar(
          selectedIndex: 1,
        ));
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is removed from the
    // widget tree.
    startDateFieldController.dispose();
    endDateFieldController.dispose();
    numberFieldController.dispose();
    super.dispose();
  }
}
