import 'package:flutter/material.dart';
import 'package:liquid_galaxy_kiss_app/components/alert_dialog.dart';
import 'package:liquid_galaxy_kiss_app/connection/ssh.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  SearchScreenState createState() => SearchScreenState();
}

class SearchScreenState extends State<SearchScreen> {
  SSH ssh = SSH();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: DecoratedBox(
            decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/images/space.png"),
                  fit: BoxFit.cover),
            ),
            child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(children: [
                  Center(
                      child: Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15.0),
                              color: Colors.grey),
                          height: 50,
                          width: 300,
                          child: Row(
                            children: [
                              Image.asset('assets/images/search.png'),
                              const SizedBox(
                                width: 8,
                              ),
                              TextButton(
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              Alert_Dialog()));
                                },
                                child: Text(
                                  'SEARCH',
                                  style: TextStyle(color: Colors.white),
                                ),
                              )
                            ],
                          ))),
                  SizedBox(
                    height: 40,
                  ),
                  Container(
                      width: double.infinity,
                      height: 200,
                      // color: Colors.grey,

                      child: Expanded(
                          child: Row(
                              // This next line does the trick.
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                            Padding(
                              padding: EdgeInsets.all(10),
                              child: Container(
                                padding: EdgeInsets.all(10),
                                width: 200,
                                height: 100,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15.0),
                                    color: Color.fromARGB(255, 49, 31, 72),
                                    gradient: const LinearGradient(colors: [
                                      Color.fromARGB(255, 2, 14, 23),
                                      Color.fromARGB(255, 39, 64, 85)
                                    ])),
                                child: Center(
                                    child: TextButton(
                                  child: const Text(
                                    'SHUT DOWN LG',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  onPressed: () async {
                                    await ssh.shutdownLG();
                                  },
                                )),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(10),
                              child: Container(
                                padding: EdgeInsets.all(10),
                                width: 200,
                                height: 100,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15.0),
                                    color: Color.fromARGB(255, 49, 31, 72),
                                    gradient: LinearGradient(colors: [
                                      Color.fromARGB(255, 2, 14, 23),
                                      Color.fromARGB(255, 39, 64, 85)
                                    ])),
                                child: Center(
                                    child: TextButton(
                                  child: Text(
                                    'REBOOT LG',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  onPressed: () async {
                                    await ssh.rebootLG();
                                  },
                                )),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(10),
                              child: Container(
                                padding: EdgeInsets.all(10),
                                width: 200,
                                height: 100,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15.0),
                                    color: Color.fromARGB(255, 49, 31, 72),
                                    gradient: LinearGradient(colors: [
                                      Color.fromARGB(255, 2, 14, 23),
                                      Color.fromARGB(255, 39, 64, 85)
                                    ])),
                                child: Center(
                                    child: TextButton(
                                        child: const Text(
                                          'REFRESH',
                                          style: TextStyle(color: Colors.white),
                                        ),
                                        onPressed: () async {
                                          await ssh.refresh();
                                        })),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(10),
                              child: Container(
                                padding: EdgeInsets.all(10),
                                width: 200,
                                height: 100,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15.0),
                                    color:
                                        const Color.fromARGB(255, 49, 31, 72),
                                    gradient: const LinearGradient(colors: [
                                      Color.fromARGB(255, 2, 14, 23),
                                      Color.fromARGB(255, 39, 64, 85)
                                    ])),
                                child: Center(
                                  child: Expanded(
                                      child: TextButton(
                                    child: const Text(
                                      'RELAUNCH LG',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    onPressed: () async {
                                      await ssh.relaunchLG();
                                    },
                                  )),
                                ),
                              ),
                            ),
                          ])))
                ]))));
  }
}
