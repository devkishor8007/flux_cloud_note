import 'package:flutter/material.dart';
import 'package:flux_cloud/model/note_model.dart';
import 'package:flux_cloud/services/note_services.dart';

deleteDialog(BuildContext context, NoteModel noteModel) async {
  showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          title: Text("Delete"),
          content: Text("Are you sure to delete?"),
          actions: [
            TextButton(
              onPressed: () async {
                await NoteFirestoreServices.deleteNote(noteModel.id.toString());
                Navigator.pop(context);
              },
              child: Text("Yes"),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text("No"),
            ),
          ],
        );
      });
}
