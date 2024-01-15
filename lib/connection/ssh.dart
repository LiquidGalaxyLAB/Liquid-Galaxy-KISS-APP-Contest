import 'dart:async';
import 'dart:io';
import 'package:dartssh2/dartssh2.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SSH {
  late String _host;
  late String _port;
  late String _username;
  late String _passwordOrKey;
  late String _numberOfRigs;
  SSHClient? _client;

  Future<void> initConnection() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    _host = prefs.getString('ipAddress') ?? 'default_host';
    _port = prefs.getString('sshPort') ?? '22';
    _username = prefs.getString('username') ?? 'lg';
    _passwordOrKey = prefs.getString('password') ?? 'lg';
    _numberOfRigs = prefs.getString('numberOfRigs') ?? '3';
  }

  Future<bool?> connectToLG() async {
    await initConnection();

    try {
      final socket = await SSHSocket.connect(_host, int.parse(_port));
      _client = SSHClient(
        socket,
        username: _username,
        onPasswordRequest: () => _passwordOrKey,
      );
      if (kDebugMode) {
        print(
            'IP: $_host, port: $_port, username: $_username, noOfRigs: $_numberOfRigs');
      }
      return true;
    } on SocketException catch (e) {
      if (kDebugMode) {
        print('Failed to connect: $e');
      }
      return false;
    }
  }

  Future<SSHSession?> searchplace(String place) async {
    try {
      if (_client == null) {
        if (kDebugMode) {
          print('SSH client is not initialized.');
        }
        return null;
      }

      final execResult =
          await _client!.execute('echo "search=$place" >/tmp/query.txt');
      return execResult;
    } catch (e) {
      if (kDebugMode) {
        print('An error occurred while executing the command: $e');
      }
      return null;
    }
  }

  Future<void> shutdownLG() async {
    try {
      await connectToLG();
      for (var i = int.parse(_numberOfRigs); i >= 0; i--) {
        await _client?.run(
            'sshpass -p ${_passwordOrKey} ssh -t lg$i "echo ${_passwordOrKey} | sudo -S poweroff"');
        print(i);
      }
    } catch (e) {
      print('Error in shut down: $e');
    }
  }

  Future<void> rebootLG() async {
    try {
      await connectToLG();

      for (var i = int.parse(_numberOfRigs); i >= 0; i--) {
        await _client?.run(
            'sshpass -p $_passwordOrKey ssh -t lg$i "echo $_passwordOrKey | sudo -S reboot"');
      }
    } catch (error) {
      print(error);
    }
  }

  Future<void> relaunchLG() async {
    try {
      await connectToLG();
      for (var i = 1; i <= int.parse(_numberOfRigs); i++) {
        await connectToLG();
        String cmd = """RELAUNCH_CMD="\\
          if [ -f /etc/init/lxdm.conf ]; then
            export SERVICE=lxdm
          elif [ -f /etc/init/lightdm.conf ]; then
            export SERVICE=lightdm
          else
            exit 1
          fi
          if  [[ \\\$(service \\\$SERVICE status) =~ 'stop' ]]; then
            echo ${_passwordOrKey} | sudo -S service \\\${SERVICE} start
          else
            echo ${_passwordOrKey} | sudo -S service \\\${SERVICE} restart
          fi
          " && sshpass -p ${_passwordOrKey} ssh -x -t lg@lg$i "\$RELAUNCH_CMD\"""";
        await _client?.run(
            '"/home/${_username}/bin/lg-relaunch" > /home/${_username}/log.txt');
        await _client?.run(cmd);
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> refresh() async {
    await connectToLG();
    try {
      const search = '<href>##LG_PHPIFACE##kml\\/slave_{{slave}}.kml<\\/href>';
      const replace =
          '<href>##LG_PHPIFACE##kml\\/slave_{{slave}}.kml<\\/href><refreshMode>onInterval<\\/refreshMode><refreshInterval>2<\\/refreshInterval>';
      final command =
          'echo ${_passwordOrKey} | sudo -S sed -i "s/$search/$replace/" ~/earth/kml/slave/myplaces.kml';

      final clear =
          'echo ${_passwordOrKey} | sudo -S sed -i "s/$replace/$search/" ~/earth/kml/slave/myplaces.kml';
      await connectToLG();
      for (var i = 2; i <= int.parse(_numberOfRigs); i++) {
        final clearCmd = clear.replaceAll('{{slave}}', i.toString());
        final cmd = command.replaceAll('{{slave}}', i.toString());
        String query = 'sshpass -p $_passwordOrKey} ssh -t lg$i \'{{cmd}}\'';

        await _client?.execute(query.replaceAll('{{cmd}}', clearCmd));
        await _client?.execute(query.replaceAll('{{cmd}}', cmd));
      }
    } catch (e) {
      print(e);
    }
  }
}
