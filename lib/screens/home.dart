import 'package:filmteambuilding/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:filmteambuilding/models/user_model.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final AuthService _authService = AuthService();
    final _ftUser = Provider.of<FtUser>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(_ftUser.phoneNumber),
        actions: <Widget>[
          ElevatedButton.icon(
              onPressed: () async {
                _authService.signOut();
              },
              icon: Icon(Icons.logout),
              label: Text('Logout'))
        ],
      ),
      body: Center(child: Text(_ftUser.uid)),
    );
  }
}
