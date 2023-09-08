import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:inote/addNote.dart';
import 'package:inote/main.dart';
import 'package:inote/models.dart';
import 'package:inote/noteDB.dart';
import 'package:animate_do/animate_do.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final box = Hive.box<Note>(noteBoxName);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (BuildContext context) {
            return const AddNote();
          }));
        },
        label: const Icon(CupertinoIcons.add),
      ),
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverAppBar.large(
            foregroundColor: Colors.black,
            elevation: 1,
            backgroundColor: Colors.white,
            surfaceTintColor: Colors.white,
            centerTitle: true,
            title: const Text(
              "iNote",
              style: TextStyle(fontWeight: FontWeight.w300),
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: IconButton(
                  icon: const Icon(CupertinoIcons.info),
                  onPressed: () {
                    infoDialog(context);
                  },
                ),
              )
            ],
          ),
          SliverToBoxAdapter(
              child: ValueListenableBuilder(
            valueListenable: box.listenable(),
            builder: (context, value, child) {
              return GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 2.0,
                      mainAxisSpacing: 2.0),
                  scrollDirection: Axis.vertical,
                  physics: const BouncingScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: box.values.length,
                  itemBuilder: (context, index) {
                    final Note note = box.values.toList()[index];
                    final Box<Note> _box = Hive.box(noteBoxName);
                    return noteItems(_box, index, note);
                  });
            },
          ))
        ],
      ),
    );
  }

  Widget noteItems(Box<Note> _box, int index, Note note) {
    return BounceInUp(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: InkWell(
          onLongPress: () {
            _box.deleteAt(index);
            setState(() {});
          },
          child: Container(
            decoration: BoxDecoration(
              color: Colors.transparent,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.1),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: const Offset(0, 3), // changes position of shadow
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(20)),
              child: Container(
                color: Colors.grey.shade300,
                child: Padding(
                  padding: const EdgeInsets.all(1.0),
                  child: ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(20)),
                    child: Container(
                      color: Colors.white,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Directionality(
                              textDirection: isRTL(note.title)
                                  ? TextDirection.rtl
                                  : TextDirection.ltr,
                              child: Row(
                                // ignore: unnecessary_null_comparison
                                children: [
                                  Flexible(
                                    child: autoSizeTextWidget(
                                      context,
                                      note.title,
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Directionality(
                              textDirection: isRTL(note.note)
                                  ? TextDirection.rtl
                                  : TextDirection.ltr,
                              child: Row(
                                children: [
                                  Flexible(
                                    child: RichText(
                                      overflow: TextOverflow.ellipsis,
                                      strutStyle:
                                          const StrutStyle(fontSize: 20.0),
                                      text: TextSpan(
                                          style: const TextStyle(
                                              color: Colors.black),
                                          text: note.note),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
