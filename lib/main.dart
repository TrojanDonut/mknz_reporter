import 'package:flutter/material.dart';
import 'package:mknz_reporter/pages/login_page.dart';

void main() => runApp(const FacebookApp());

class FacebookApp extends StatefulWidget {
  const FacebookApp({Key? key}) : super(key: key);

  @override
  _FacebookAppState createState() => _FacebookAppState();
}

class _FacebookAppState extends State<FacebookApp> {


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(

      ),
      darkTheme: ThemeData.dark(),
      themeMode: ThemeMode.dark,
      home: const LoginPage(),
    );
  }
}
