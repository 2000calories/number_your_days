import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:number_your_days/models/event.dart';

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
      return "Anniversary";
    }
    return number.toString() + " until next anniversary";
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      //decoration: BoxDecoration(border: new Border.all(color: Colors.grey)),
      child: Row(
        children: <Widget>[
          Container(
            width: MediaQuery.of(context).size.width / 2 - 1,
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
            width: MediaQuery.of(context).size.width / 2 - 1,
            child: ListTile(
              onTap: onTap,
              title: Container(
                child: Text(
                  numberEventDays(event).toString() + ' Days',
                  style: Theme.of(context).textTheme.body2,
                ),
              ),
              subtitle: Text(
                event.isAnnual ? annualEventNotification(event) : "",
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.subhead,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
