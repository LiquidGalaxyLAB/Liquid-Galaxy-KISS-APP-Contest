import 'package:flutter/material.dart';
import 'package:liquid_galaxy_kiss_app/components/connection_flag.dart';
import 'package:liquid_galaxy_kiss_app/connection/ssh.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ConnectScreen extends StatefulWidget {
  const ConnectScreen({Key? key}) : super(key: key);
  @override
  State<ConnectScreen> createState() => _ConnectScreenState();
}

class _ConnectScreenState extends State<ConnectScreen> {
  bool connectionStatus = false;
  bool passwordVisible = false;
  late SSH ssh;
  @override
  void initState() {
    super.initState();
    ssh = SSH();
    saveSettings();
    refresh();
  }

  void refresh() async {
    bool? connect = await ssh.connectToLG();

    if (connect == true) {
      setState(() {
        connectionStatus = true;
      });
    }
  }

  final TextEditingController ipController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController portController = TextEditingController();
  final TextEditingController no_of_rigs_Controller = TextEditingController();

  Future<void> saveSettings() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    if (ipController.text.isNotEmpty) {
      await prefs.setString('ipAddress', ipController.text);
    } else {
      ipController.text = prefs.getString('ipAddress') ?? '';
    }
    if (usernameController.text.isNotEmpty) {
      await prefs.setString('username', usernameController.text);
    } else {
      usernameController.text = prefs.getString('username') ?? '';
    }
    if (passwordController.text.isNotEmpty) {
      await prefs.setString('password', passwordController.text);
    } else {
      passwordController.text = prefs.getString('password') ?? '';
    }
    if (portController.text.isNotEmpty) {
      await prefs.setString('sshPort', portController.text);
    } else {
      portController.text = prefs.getString('sshPort') ?? '';
    }
    if (no_of_rigs_Controller.text.isNotEmpty) {
      await prefs.setString('numberOfRigs', no_of_rigs_Controller.text);
    } else {
      no_of_rigs_Controller.text = prefs.getString('numberOfRigs') ?? '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            'Connect to Liquid Galaxy',
            style: TextStyle(color: Colors.white),
          ),
          leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              color: Colors.white,
              onPressed: () {
                Navigator.pop(context);
              }),
          backgroundColor: Colors.black,
          actions: <Widget>[ConnectionFlag(connectionStatus: connectionStatus)],
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.all(14),
                    child: TextField(
                      controller: ipController,
                      decoration: const InputDecoration(
                        // prefixIcon: Icon(Icons.computer),
                        labelText: 'IP address',
                        hintText: 'Enter Master IP',
                        border: UnderlineInputBorder(),
                      ),
                      keyboardType: TextInputType.number,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    padding: const EdgeInsets.all(14),
                    child: TextField(
                      controller: usernameController,
                      decoration: const InputDecoration(
                        // prefixIcon: Icon(Icons.computer),
                        labelText: 'LG Username',
                        hintText: 'Enter username',
                        border: UnderlineInputBorder(),
                      ),
                      keyboardType: TextInputType.text,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    padding: const EdgeInsets.all(14),
                    child: TextField(
                      controller: passwordController,
                      obscureText: !passwordVisible,
                      decoration: InputDecoration(
                        // prefixIcon: Icon(Icons.computer),
                        labelText: 'LG Password',
                        hintText: 'Enter password',
                        border: const UnderlineInputBorder(),

                        suffixIcon: IconButton(
                          icon: Icon(passwordVisible == false
                              ? Icons.visibility
                              : Icons.visibility_off),
                          onPressed: () {
                            setState(
                              () {
                                passwordVisible = !passwordVisible;
                              },
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    padding: const EdgeInsets.all(14),
                    child: TextField(
                      controller: portController,
                      decoration: const InputDecoration(
                        //   prefixIcon: Icon(Icons.computer),
                        labelText: 'SSH Port',
                        hintText: 'Enter port number',
                        border: UnderlineInputBorder(),
                      ),
                      keyboardType: TextInputType.number,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    padding: const EdgeInsets.all(14),
                    child: TextField(
                      controller: no_of_rigs_Controller,
                      decoration: const InputDecoration(
                        labelText: 'Number of LG rigs',
                        hintText: 'Enter no of rigs',
                        border: UnderlineInputBorder(),
                      ),
                      // keyboardType: TextInputType.number,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextButton(
                      onPressed: () async {
                        await saveSettings();
                        ssh = SSH();
                        bool? connect = await ssh.connectToLG();

                        if (connect == true) {
                          setState(() {
                            connectionStatus = true;
                          });
                        }
                      },
                      style: const ButtonStyle(
                        backgroundColor: MaterialStatePropertyAll(
                          Colors.black,
                        ),
                        // shape:MaterialStatePropertyAll(Rounded)
                      ),
                      child: const Text(
                        'Connect',
                        style: TextStyle(color: Colors.white),
                      ))
                ]),
          ),
        ));
  }
}
