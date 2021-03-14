import 'package:filmteambuilding/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:filmteambuilding/services/auth.dart';

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  //Vars
  final AuthService _authService = AuthService();
  TextEditingController _phoneNumber = TextEditingController();
  TextEditingController _teamName = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 200, horizontal: 50),
        child: Column(
          children: [
            //User Input Phone number
            Container(
              height: 50,
              child: TextField(
                textAlign: TextAlign.start,
                textAlignVertical: TextAlignVertical.bottom,
                keyboardType: TextInputType.phone,
                controller: _phoneNumber,
              ),
            ),

            Container(
              height: 50,
              child: TextField(
                textAlign: TextAlign.start,
                textAlignVertical: TextAlignVertical.bottom,
                keyboardType: TextInputType.text,
                controller: _teamName,
              ),
            ),

            Container(
              child: ElevatedButton(
                child: Text('Sign In by Phone'),
                onPressed: () async {
                  await _authService.signInByPhone(
                      _phoneNumber.text.trim(), context);
                  print('nummer sendt til auth');
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
