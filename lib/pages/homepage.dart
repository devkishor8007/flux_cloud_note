import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flux_cloud/model/note_model.dart';
import 'package:flux_cloud/pages/addpage.dart';
import 'package:flux_cloud/pages/editpage.dart';
import 'package:flux_cloud/widget/delete_note_widget.dart';
import 'package:flux_cloud/widget/drawer_widget.dart';

class HomePage extends StatefulWidget {
  final User user;
  HomePage({required this.user});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (_) => AddPage(
                        uid: widget.user,
                      )));
        },
      ),
      appBar: AppBar(
        title: Text("Flux Cloud"),
      ),
      drawer: EasyDrawer(),
      body: StreamBuilder<QuerySnapshot>(
        stream: firebaseFirestore
            .collection('notes')
            .orderBy(
              "timeStamp",
              descending: true,
            )
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.connectionState == ConnectionState.active) {
            if (snapshot.data!.docs.isNotEmpty) {
              return ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    NoteModel noteModel =
                        NoteModel.fromJson(snapshot.data!.docs[index]);
                    return ListTile(
                      title: Text(noteModel.title ?? ""),
                      subtitle: Text(noteModel.desc ?? ""),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => EditPage(
                              noteModel: noteModel,
                            ),
                          ),
                        );
                      },
                      onLongPress: () async {
                        await deleteDialog(context, noteModel);
                      },
                    );
                  });
            } else {
              return LinearProgressIndicator(
                color: Colors.red,
                backgroundColor: Colors.indigo,
              );
            }
          }
          return Text("Something is Error");
        },
      ),
    );
  }
}
