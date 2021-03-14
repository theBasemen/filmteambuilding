import 'package:filmteambuilding/models/user_model.dart';
import 'package:filmteambuilding/screens/authenticate.dart';
import 'package:filmteambuilding/screens/home.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _ftUser = Provider.of<FtUser>(context);

    if (_ftUser == null) {
      return Authenticate();
    } else {
      return Home();
    }
  }
}
