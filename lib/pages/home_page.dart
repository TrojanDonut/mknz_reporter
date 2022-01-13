import 'package:flutter/material.dart';
import 'package:mknz_reporter/Models/event_model.dart';
import 'package:mknz_reporter/event_service.dart';
import 'package:mknz_reporter/pages/event_page.dart';

import 'login_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final EventService eventService = EventService();
  late Future<List<EventModel>> eventModel;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    eventModel = eventService.fetchEvent();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: FutureBuilder<List<EventModel>>(
          future: eventModel,
          builder: (context, snapshot) {
            if (snapshot.hasData){
              return ListView.builder(
                itemCount: snapshot.data?.length,
                  itemBuilder: (context, index){
                    return Column(
                      children: [
                        SizedBox(height: 5),
                        ListTile(
                          onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => EventPage(eventModel: snapshot.data![index]))),
                          leading: SizedBox(child: Image.network(snapshot.data![index].cover, fit: BoxFit.cover), height: 100, width: 100),
                          title: Text(snapshot.data![index].title),
                          subtitle: Text(snapshot.data![index].description, maxLines: 3, overflow: TextOverflow.ellipsis)
                        ),
                        SizedBox(height: 5)
                      ],
                    );
              });
            } else if (snapshot.hasError) {
              print('${snapshot.error}');
              return Text('${snapshot.error}');
            }
            return const Center(child: CircularProgressIndicator());
          }
        ),
      ),
    );
  }
}
