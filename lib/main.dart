import 'package:filmteambuilding/models/user_model.dart';
import 'package:filmteambuilding/screens/wrapper.dart';
import 'package:filmteambuilding/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';

void main() async {
  //Initialize Firebase

  try {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();
    print('Firebase initialized');
    runApp(MyApp());
  } catch (e) {
    print(e);
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<FtUser>.value(
      value: AuthService().currentFtUser,
      initialData: null,
      child: MaterialApp(
        //return either HOME or AUTHENTICATE widget

        home: Wrapper(),
      ),
    );
  }
}
