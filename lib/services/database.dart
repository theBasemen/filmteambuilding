import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  final String uid;

  DatabaseService({this.uid});

  Future updateUserData(
      {String videoTitle,
      String videoNote,
      String videoPath,
      bool videoUploaded}) async {
    return await FirebaseFirestore.instance
        .collection(uid)
        .doc(videoTitle)
        .set({
      'videoNote': videoNote,
      'videoPath': videoPath,
      'videoUploaded': videoUploaded
    });
  }
}
