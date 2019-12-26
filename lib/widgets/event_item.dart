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
              title: Hero(
                tag: '${event.id}__heroTag',
                child: Container(
                  child: Text(
                    event.id.toString() + event.eventName,
                    style: Theme.of(context).textTheme.body2,
                  ),
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
                  event.eventType == 'Passed'
                      ? (DateTime.now()
                              .difference(event.eventDate)
                              .inDays
                              .toString()) +
                          ' Days'
                      : (event.eventDate
                              .difference(DateTime.now())
                              .inDays
                              .toString()) +
                          ' Days',
                  style: Theme.of(context).textTheme.body2,
                ),
              ),
              subtitle: Text(
                event.eventType,
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
