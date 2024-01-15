import 'package:flutter/material.dart';

class AboutPage extends StatefulWidget {
  AboutPage({Key? key}) : super(key: key);

  @override
  AboutPageState createState() => AboutPageState();
}

class AboutPageState extends State<AboutPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          title: Text(
            'Help',
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.black,
          leading: IconButton(
              icon: Icon(Icons.arrow_back),
              color: Colors.white,
              onPressed: () {
                Navigator.pop(context);
              }),
        ),
        body: SingleChildScrollView(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Container(
              padding: EdgeInsets.all(20),
              child: const Text(
                'This app has basic functionalities to control Liquid galaxy.\nFirst of all connect the device with the LG rig by filling in the details in the Page. ',
                style: TextStyle(color: Colors.white),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
                padding: EdgeInsets.all(20),
                child: Image.asset('assets/images/connection.png',
                    height: 200, width: 500)),
            Container(
              padding: const EdgeInsets.all(20),
              child: const Text(
                'Certain functionalities can be performed with LG rig:\nShutDown\nRelaunch\nReboot\nRefresh',
                style: TextStyle(color: Colors.white),
              ),
            )
          ]),
        ));
  }
}
