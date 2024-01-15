import 'package:flutter/material.dart';
import 'package:liquid_galaxy_kiss_app/components/connection_flag.dart';

import 'package:liquid_galaxy_kiss_app/connection/ssh.dart';
import 'package:liquid_galaxy_kiss_app/screens/connect.dart';
import 'package:liquid_galaxy_kiss_app/screens/help_screen.dart';
import 'package:liquid_galaxy_kiss_app/screens/search.dart';
import 'package:liquid_galaxy_kiss_app/utils/constants.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  late SSH ssh;

  @override
  void initState() {
    super.initState();
    ssh = SSH();
    _connectToLG();
  }

  Future<void> _connectToLG() async {
    bool? result = await ssh.connectToLG();
    setState(() {
      connection = result!;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text('Liquid Galaxy Controller',
              style: TextStyle(color: Colors.white)),
          backgroundColor: Colors.black,
          actions: <Widget>[
            ConnectionFlag(connectionStatus: connection),
            PopupMenuButton(
              itemBuilder: (context) => [
                PopupMenuItem(
                  child: Text('Connect'),
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => ConnectScreen(),
                      ),
                    );
                    setState(() {
                      _connectToLG();
                    });
                  },
                ),
                PopupMenuItem(
                  child: Text('About'),
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => AboutPage(),
                      ),
                    );
                  },
                )
              ],
            ),
          ]),
      body: SearchScreen(),
    );
  }
}
