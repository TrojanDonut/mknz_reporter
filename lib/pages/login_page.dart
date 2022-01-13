import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:mknz_reporter/pages/home_page.dart';
import 'package:mknz_reporter/pages/tab_select.dart';
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
          title: const Text(
            "MKNŽ Reporter"
          )
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
                child: Text('Facebook Login'),
                onPressed: () async {
                  final result = await FacebookAuth.i
                      .login(permissions: ["public_profile", "email"]);

                  if (result.status == LoginStatus.success) {
                    final accessToken = result.accessToken?.token;
                    SharedPreferences prefs = await SharedPreferences.getInstance();
                    await prefs.setString("accessToken", accessToken!);
                    await FacebookAuth.i.getUserData(
                    ).then((value) => Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const TabSelect())));
                  }
                }),
          ],
        ), // Column
      ), // Center
    );
  }
}
