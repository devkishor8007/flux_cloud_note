import 'package:cloud_firestore/cloud_firestore.dart';

class NoteModel {
  String? id;
  String? title;
  String? desc;
  Timestamp? timestamp;
  Timestamp? dateTime;
  String? uid;

  NoteModel({
    this.id,
    this.title,
    this.desc,
    this.timestamp,
    this.dateTime,
    this.uid,
  });

  factory NoteModel.fromJson(DocumentSnapshot snapshot) {
    return NoteModel(
        id: snapshot.id, // document id
        title: snapshot['title'],
        uid: snapshot['userId'], // unique id of user
        desc: snapshot['desc'],
        dateTime: snapshot['dateTime'],
        timestamp: snapshot['timeStamp']);
  }
}
