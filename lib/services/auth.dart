import 'dart:async';

import 'package:filmteambuilding/models/user_model.dart';
import 'package:filmteambuilding/services/database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  TextEditingController _smsController = TextEditingController();

  //Creates an FtUser based on Firebase User Object.
  // Includes just uid and phone number.

  FtUser _userFromFirebaseUser(User firebaseUser) {
    return firebaseUser != null
        ? FtUser(
            uid: firebaseUser.uid,
            phoneNumber: firebaseUser.phoneNumber.toString())
        : null;
  }

  //Stream that detects auth changes. The StreamProvider is listening in main.dart
  Stream<FtUser> get currentFtUser {
    return _auth.authStateChanges().map(_userFromFirebaseUser);
  }

  //Sign in with phone number. This method is called from sign_in.dart
  Future signInByPhone(String phoneNumber, BuildContext context) async {
    var completer = Completer<bool>();

    //Verify phone number
    await _auth.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      verificationCompleted: (PhoneAuthCredential credential) async {
        // Sign the user in (or link) with the auto-generated credential
        await _auth.signInWithCredential(credential);
        print('verificationCompleted : step 1 done');
        completer.complete(true);
      },
      verificationFailed: (FirebaseAuthException e) {
        if (e.code == 'invalid-phone-number') {
          print('The provided phone number is not valid.');
        } else {
          print(e.toString());
        }
        print('verificationFailed : step 2 done');
      },
      codeSent: (String verificationId, int resendToken) async {
        //UI to get sms code from user
        print('code sent function start');
        showDialog<void>(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) {
            _smsController.text = '';
            print('Alert about to start');
            return AlertDialog(
              title: Text('Enter SMS code'),
              content: SingleChildScrollView(
                child: ListBody(
                  children: <Widget>[
                    TextField(
                      maxLength: 20,
                      controller: _smsController,
                      decoration: InputDecoration(
                        hintText: 'SMS code',
                      ),
                    ),
                  ],
                ),
              ),
              actions: <Widget>[
                TextButton(
                  child: Text('SUBMIT'),
                  onPressed: () async {
                    try {
                      print('trying phone sign in');
                      PhoneAuthCredential phoneAuthCredential =
                          PhoneAuthProvider.credential(
                              verificationId: verificationId,
                              smsCode: _smsController.text.trim());
                      await _auth.signInWithCredential(phoneAuthCredential);
                      Navigator.of(context).pop();
                      await DatabaseService(uid: _auth.currentUser.uid)
                          .updateUserData(
                              videoTitle: 'test titel',
                              videoNote: 'test note',
                              videoPath: 'test path',
                              videoUploaded: false);

                      return _userFromFirebaseUser(_auth.currentUser);
                    } catch (e) {
                      print(e.toString());
                      Navigator.of(context).pop();
                      return null;
                    }
                  },
                ),
              ],
            );
          },
        );
      },
      timeout: const Duration(seconds: 0),
      codeAutoRetrievalTimeout: (String verificationId) {
        print('timed out');
      },
    );
    return completer.future;
  }

  //Sign Out
  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
