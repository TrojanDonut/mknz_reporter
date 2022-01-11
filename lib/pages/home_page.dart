import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mknz_reporter/Models/event_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<List<EventModel>> eventModel;

  Future <List<EventModel>> fetchEvent() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final accessToken = prefs.getString("accessToken");
    final response = await http.get(Uri.parse("https://graph.facebook.com/v12.0/108561498366274/events?access_token=$accessToken&fields=id,cover,name,description"));

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      List<EventModel> events = (json.decode(response.body)["data"] as List).map((i) => EventModel.fromJson(i)).toList();
      return events;
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load event!');
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    eventModel = fetchEvent();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Events"),
      ),
      body: SafeArea(
        child: FutureBuilder<List<EventModel>>(
          future: eventModel,
          builder: (context, snapshot) {
            if (snapshot.hasData){
              return ListView.builder(
                itemCount: snapshot.data?.length,
                  itemBuilder: (context, index){
                    return ListTile(
                      leading: Image.network(snapshot.data![index].cover),
                      title: Text(snapshot.data![index].title),
                      subtitle: Text(snapshot.data![index].description),
                    );
              });
            } else if (snapshot.hasError) {
              print('${snapshot.error}');
              return Text('${snapshot.error}');
            }
            return const CircularProgressIndicator();
          }
        ),
      ),
    );
  }
}
