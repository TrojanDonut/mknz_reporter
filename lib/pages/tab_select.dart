import 'package:flutter/material.dart';
import 'package:mknz_reporter/pages/favorites_page.dart';
import 'package:mknz_reporter/pages/home_page.dart';
import 'package:mknz_reporter/pages/login_page.dart';

class TabSelect extends StatelessWidget {
  const TabSelect({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.black54,
            actions: [
              IconButton(onPressed: (){
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginPage()));
              }, icon: Icon(Icons.logout))
            ],
            bottom: const TabBar(
              tabs: [
                Tab(icon: Icon(Icons.event)),
                Tab(icon: Icon(Icons.star))
              ],
            ),
            title: const Text('MKNŽ Reporter'),
          ),
          body: const TabBarView(
            children: [
              HomePage(),
              FavoritesPage()
            ],
          ),
        ),
      ),
    );
  }
}