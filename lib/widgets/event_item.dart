import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:number_your_days/models/event.dart';
import '../translation.i18n.dart';

class EventItem extends StatelessWidget {
  final GestureTapCallback onTap;
  final Event event;

  EventItem({
    Key key,
    @required this.onTap,
    @required this.event,
  }) : super(key: key);

  int numberEventDays(Event event) {
    int number = DateTime.now().difference(event.eventDate).inDays;
    return number;
  }

  String annualEventNotification(Event event) {
    var number = event.eventDate.difference(DateTime.now()).inDays;
    if (number < 0) {
      number = DateTime(event.eventDate.year + 1, event.eventDate.month,
              event.eventDate.day)
          .difference(DateTime.now())
          .inDays;
    }
    if (number == 0) {
      return "Anniversary Day".i18n;
    }
    return number.toString() + " days until next anniversary".i18n;
  }

  String everyNDaysNotification(Event event) {
    //number = 600, everyNDays = 500,
    int number = event.eventDate.difference(DateTime.now()).inDays;
    int everyNDays = event.everyNDays;
    int timesOfEvent = number ~/ everyNDays;
    int daysUntilNextEvent = number % everyNDays;
    if (daysUntilNextEvent == 0) {
      return "$timesOfEvent x $everyNDays " + "Days".i18n;
    }
    return "$daysUntilNextEvent ${"until".i18n} ${timesOfEvent + 1} x $everyNDays ${"Days".i18n}";
  }

  Widget subtitle(Event event, context) {
    List subtitleTextList = [];
    if (event.isAnnual) {
      subtitleTextList.add(annualEventNotification(event));
    }

    if (event.everyNDays > 0) {
      subtitleTextList.add(everyNDaysNotification(event));
    }
    List<Widget> subtitleChildWidgets = [];
    subtitleTextList.forEach((subtitleText) {
      subtitleChildWidgets.add(Text(
        subtitleText,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: Theme.of(context).textTheme.subhead,
      ));
    });

    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: subtitleChildWidgets);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      //decoration: BoxDecoration(border: new Border.all(color: Colors.grey)),
      child: Row(
        children: <Widget>[
          Container(
            width: MediaQuery.of(context).size.width * 2 / 5 - 1,
            child: ListTile(
              onTap: onTap,
              title: Container(
                child: Text(
                  event.eventName,
                  style: Theme.of(context).textTheme.body2,
                ),
              ),
              subtitle: Text(
                DateFormat('yyyy-MM-dd').format(event.eventDate),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.subhead,
              ),
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width * 3 / 5 - 1,
            child: ListTile(
              onTap: onTap,
              title: Container(
                child: Text(
                  numberEventDays(event).toString() + ' Days'.i18n,
                  style: Theme.of(context).textTheme.body2,
                ),
              ),
              subtitle: subtitle(event, context),
            ),
          ),
        ],
      ),
    );
  }
}
