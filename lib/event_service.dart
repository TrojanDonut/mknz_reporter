import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import 'Models/event_model.dart';

import 'package:http/http.dart' as http;

class EventService {

  Future <List<EventModel>> fetchEvent() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final accessToken = prefs.getString("accessToken");
    final response = await http.get(Uri.parse("https://graph.facebook.com/v12.0/108561498366274/events?access_token=$accessToken&fields=id,cover,name,description,start_time"));

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
}