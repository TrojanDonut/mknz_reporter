import 'package:flutter/material.dart';
import 'package:mknz_reporter/Models/event_model.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EventPage extends StatefulWidget {

  final EventModel  eventModel ;

  const EventPage({Key? key, required this.eventModel}) : super(key: key);

  @override
  State<EventPage> createState() => _EventPageState();
}

class _EventPageState extends State<EventPage> {

  bool isFavorite = false;

  Future<Null> getSharedPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      isFavorite = prefs.getBool(widget.eventModel.eventId) ?? false;
    });
  }

  Future<Null> favorite() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (isFavorite) {
      setState(() {
        isFavorite = false;
      });
      prefs.setBool(widget.eventModel.eventId, false);
    }else{
      setState(() {
        isFavorite = true;
      });
      prefs.setBool(widget.eventModel.eventId, true);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getSharedPrefs();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          favorite();
        },
        child: Icon( isFavorite ? Icons.star : Icons.star_border_rounded),
      ),
      appBar: AppBar(
        backgroundColor: Colors.black54,
        title: Text(widget.eventModel.title)
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(widget.eventModel.cover),
            Container(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(widget.eventModel.title, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),),
                  Text(DateFormat("dd. MM. yyyy ob HH:mm").format(DateTime.parse(widget.eventModel.startTime))),
                  const SizedBox(height: 15.0),
                  Text(widget.eventModel.description),
                  const SizedBox(height: 15.0)
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
