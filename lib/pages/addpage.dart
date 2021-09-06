import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flux_cloud/services/note_services.dart';

class AddPage extends StatefulWidget {
  final User uid;
  AddPage({required this.uid});

  @override
  _AddPageState createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {
  late TextEditingController _title;
  late TextEditingController _desc;

  @override
  void initState() {
    super.initState();

    _title = TextEditingController();
    _desc = TextEditingController();
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
        title: Text("Add Page"),
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
                        await NoteFirestoreServices.insertNote(
                            _title.text, _desc.text, widget.uid.uid);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            duration: Duration(
                              seconds: 2,
                            ),
                            content: Text("Added"),
                          ),
                        );

                        Navigator.pop(context);
                      }
                    },
                    child: Text(
                      "Add".toUpperCase(),
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
