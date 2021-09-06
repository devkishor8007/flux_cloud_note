import 'package:cloud_firestore/cloud_firestore.dart';

class NoteFirestoreServices {
  static FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  static Future insertNote(String title, String desc, String uid) async {
    try {
      await _firebaseFirestore.collection('notes').add({
        'title': title,
        'desc': desc,
        'dateTime': DateTime.now(),
        'userId': uid,
        'timeStamp': Timestamp.now(),
      });
    } catch (e) {
      print(e);
    }
  }

  static Future updateNote(String docId, String title, String desc) async {
    try {
      await _firebaseFirestore.collection('notes').doc(docId).update({
        'title': title,
        'desc': desc,
        'timeStamp': Timestamp.now(),
        'dateTime': DateTime.now(),
      });
    } catch (e) {
      print(e);
    }
  }

  static Future deleteNote(String docId) async {
    try {
      await _firebaseFirestore.collection('notes').doc(docId).delete();
    } catch (e) {
      print(e);
    }
  }
}
