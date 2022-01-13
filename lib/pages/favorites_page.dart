import 'package:flutter/material.dart';
import 'package:mknz_reporter/Models/event_model.dart';

import 'package:mknz_reporter/pages/event_page.dart';

import 'package:mknz_reporter/event_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FavoritesPage extends StatefulWidget {
  const FavoritesPage({Key? key}) : super(key: key);

  @override
  State<FavoritesPage> createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {

  final EventService eventService = EventService();
  late Map<String, dynamic> prefMap;
  late Future<List<EventModel>> eventModel;

  static Future <bool> isFavorites(id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isFavorite = prefs.getBool(id) ?? false;
    print(id + isFavorite.toString());
    return isFavorite;
  }

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
              if (snapshot.hasData) {
                return ListView.builder(
                    itemCount: snapshot.data?.length,
                    itemBuilder: (context, index) {
                      return FutureBuilder<bool?>(
                          future: isFavorites(snapshot.data![index].eventId),
                          builder: (context, snapshot1) {
                            if (snapshot1.hasData) {
                              return Column(
                                children: [
                                  SizedBox(height: 5),
                                  Visibility(
                                    visible: snapshot1.data!,
                                    child: ListTile(
                                        onTap: () =>
                                            Navigator.push(context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        EventPage(
                                                            eventModel: snapshot
                                                                .data![index]))),
                                        leading: SizedBox(child: Image.network(
                                            snapshot.data![index].cover, fit: BoxFit.cover),
                                          height: 100,
                                          width: 100,),
                                        title: Text(
                                            snapshot.data![index].title),
                                        subtitle: Text(
                                            snapshot.data![index].description,
                                            maxLines: 3,
                                            overflow: TextOverflow.ellipsis)
                                    ),
                                  ),
                                  SizedBox(height: 5)
                                ],
                              );
                            }
                            return Center(child: CircularProgressIndicator());
                          });
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
