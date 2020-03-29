import 'package:number_your_days/common.dart';
import 'package:number_your_days/models/event.dart';

class EventListScreen extends StatefulWidget {
  @override
  _EventListScreenState createState() => _EventListScreenState();
}

class _EventListScreenState extends State<EventListScreen> {
  List<Event> events;
  TextEditingController filterController = new TextEditingController();
  String filter;

  @override
  void initState() {
    super.initState();
    filterController.addListener(() {
      setState(() {
        filter = filterController.text;
      });
    });
  }

  @override
  void dispose() {
    filterController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EventsBloc, EventsState>(
      builder: (context, state) {
        if (state is EventsLoading) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is EventsLoaded) {
          events = state.events;
          return Column(
            children: <Widget>[
              //search and filter box
              Padding(
                padding: EdgeInsets.all(15.0),
                child: Row(
                  children: <Widget>[
                    Flexible(
                      child: TextField(
                        decoration: InputDecoration(
                            border: InputBorder.none, hintText: 'Search'.i18n),
                        controller: filterController,
                      ),
                    ),
                  ],
                ),
              ),

              //event list
              Expanded(
                child: ListView.builder(
                  itemCount: events.length,
                  itemBuilder: (BuildContext context, int index) {
                    var event = events[index];
                    Map<String, dynamic> arguments = new Map();
                    arguments['event'] = event;
                    if (filter == null || filter == "") {
                      return EventItem(
                        event: event,
                        onTap: () async {
                          Navigator.of(context)
                              .pushNamed('/eventEdit', arguments: arguments);
                        },
                      );
                    }
                    if (event.eventName
                        .toLowerCase()
                        .contains(filter.toLowerCase())) {
                      return EventItem(
                        event: event,
                        onTap: () async {
                          Navigator.of(context)
                              .pushNamed('/eventEdit', arguments: arguments);
                        },
                      );
                    } else {
                      return Container();
                    }
                  },
                ),
              ),
            ],
          );
        } else {
          return Container();
        }
      },
    );
  }
}
