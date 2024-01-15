import 'package:dartssh2/dartssh2.dart';
import 'package:flutter/material.dart';
import 'package:liquid_galaxy_kiss_app/connection/ssh.dart';

class Alert_Dialog extends StatelessWidget {
  Alert_Dialog({Key? key}) : super(key: key);
  TextEditingController location = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        title: const Text('Search a place'),
        content: TextField(
          controller: location,
          decoration: const InputDecoration(labelText: 'Enter location'),
        ),
        actions: [
          Row(
            children: [
              TextButton(
                onPressed: () async {
                  SSH ssh = SSH();
                  await ssh.connectToLG();
                  SSHSession? result = await ssh.searchplace(location.text);
                  if (result != null) print('Found successfully');
                  Navigator.pop(context);
                },
                child: const Text('Search'),
              ),
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('Cancel'))
            ],
          )
        ]);
  }
}
