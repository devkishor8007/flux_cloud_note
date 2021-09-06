import 'package:flutter/material.dart';
import 'package:flux_cloud/model/note_model.dart';
import 'package:flux_cloud/services/note_services.dart';

class EditPage extends StatefulWidget {
  final NoteModel noteModel;
  EditPage({required this.noteModel});

  @override
  _EditPageState createState() => _EditPageState();
}

class _EditPageState extends State<EditPage> {
  late TextEditingController _title;
  late TextEditingController _desc;

  @override
  void initState() {
    super.initState();

    _title = TextEditingController(text: widget.noteModel.title);
    _desc = TextEditingController(text: widget.noteModel.desc);
  }

  @override
  void dispose() {
    _desc.dispose();
    _title.dispose();
    super.dispose();
  }

  GlobalKey<FormState> _key = GlobalKey<FormState>();

  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Page"),
      ),
      body: Form(
        key: _key,
        child: ListView(
          children: [
            TextFormField(
              validator: (val) {
                if (val!.isEmpty) return "Field is Empty";
                return null;
              },
              controller: _title,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: "Enter a title",
              ),
            ),
            TextFormField(
              validator: (val) {
                if (val!.isEmpty) return "Field is Empty";
                return null;
              },
              controller: _desc,
              maxLength: 500,
              maxLines: 10,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: "Enter a description",
              ),
            ),
            SizedBox(
              height: 10,
            ),
            _isLoading
                ? Center(
                    child: Container(
                      width: 50,
                      height: 50,
                      child: CircularProgressIndicator(),
                    ),
                  )
                : ElevatedButton(
                    onPressed: () async {
                      final isValid = _key.currentState!.validate();
                      if (!isValid) {
                        return;
                      } else {
                        setState(() {
                          _isLoading = true;
                        });
                        _key.currentState!.save();
                        await NoteFirestoreServices.updateNote(
                          widget.noteModel.id.toString(),
                          _title.text,
                          _desc.text,
                        );
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            duration: Duration(
                              seconds: 2,
                            ),
                            content: Text("Updated"),
                          ),
                        );

                        Navigator.pop(context);
                      }
                    },
                    child: Text(
                      "Update".toUpperCase(),
                      style: TextStyle(
                        fontSize: Theme.of(context).textTheme.button!.fontSize,
                      ),
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
