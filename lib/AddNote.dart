import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:inote/main.dart';
import 'package:inote/noteDB.dart';

class AddNote extends StatelessWidget {
  const AddNote({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController _controller = TextEditingController();

    final TextEditingController _controller2 = TextEditingController();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          "Add Note",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.w400),
        ),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            final note1 = Note();
            note1.title = _controller.text;
            note1.note = _controller2.text;
            // if(note1.isInBox){
            //          // note1.save();
            // }else{
            final Box<Note> box = Hive.box(noteBoxName);

            box.add(note1);
            //}
            Navigator.of(context).pop();
          },
          label: const Text("Save")),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: TextField(
                controller: _controller,
                decoration: const InputDecoration(
                    label: Text(
                  "Title...",
                )),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: TextField(
                controller: _controller2,
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  contentPadding: EdgeInsets.symmetric(
                      vertical: MediaQuery.of(context).size.height / 5),
                  label: const Text("Note..."),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
