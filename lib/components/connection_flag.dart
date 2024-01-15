import 'package:flutter/material.dart';

class ConnectionFlag extends StatelessWidget {
  bool connectionStatus;
  ConnectionFlag({required this.connectionStatus});

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.black,
        child: Row(
          children: [
            Icon(
              Icons.flag,
              color: connectionStatus ? Colors.green : Colors.red,
            ),
            SizedBox(
              width: 10,
            ),
            Text(
              connectionStatus ? 'Connected' : 'Disconnected',
              style: TextStyle(
                  color: connectionStatus ? Colors.green : Colors.red),
            )
          ],
        ));
  }
}
