import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:mknz_reporter/pages/home_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  Map? _userData;
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text('Facebook (Logged ' +
              (_userData == null ? 'Out' : 'In') +
              'Out)')),
      body: Center(
        child: Column(
          children: [
            ElevatedButton(
                child: Text('Log In'),
                onPressed: () async {
                  final result = await FacebookAuth.i
                      .login(permissions: ["public_profile", "email"]);

                  if (result.status == LoginStatus.success) {
                    final accessToken = result.accessToken?.token;
                    SharedPreferences prefs = await SharedPreferences.getInstance();
                    await prefs.setString("accessToken", accessToken!);
                    final userData = await FacebookAuth.i.getUserData(
                      fields: "email,name",
                    ).then((value) => Navigator.push(context, MaterialPageRoute(builder: (context) => const HomePage())));
                  }
                }),
          ],
        ), // Column
      ), // Center
    );
  }
}
