import 'dart:math';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:noterec/screens/note_editor.dart';
import 'package:noterec/screens/note_reader.dart';
import 'package:noterec/styles/app_style.dart';
import 'package:noterec/widgets/notes_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int color_id = Random().nextInt(AppStyle.cardColor.length);

  final TextEditingController _contentController = TextEditingController();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _creationDateController = TextEditingController();
  final TextEditingController _searchController = TextEditingController();

  Future<void> _update([DocumentSnapshot? documentSnapshot]) async {
    String date = DateTime.now().toString();
    if (documentSnapshot != null) {
      _titleController.text = documentSnapshot['note_title'];
      _creationDateController.text = documentSnapshot['creation_date'];
      _contentController.text = documentSnapshot['note_content'];
    }
    await showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (BuildContext ctx) {
          return Container(
            decoration: const BoxDecoration(
              // color: Colors.black,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30.0),
                topRight: Radius.circular(30.0),
              ),
            ),
            padding: EdgeInsets.only(
                top: 20,
                right: 20,
                left: 20,
                bottom: MediaQuery.of(ctx).viewInsets.bottom + 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Center(
                  child: Text(
                    "Update your item",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
                TextField(
                  controller: _titleController,
                  decoration: const InputDecoration(
                      labelText: 'Title', hintText: 'eg.Python'),
                ),
                TextField(
                  controller: _contentController,
                  decoration: const InputDecoration(
                      contentPadding: EdgeInsets.symmetric(vertical: 100.0),
                      labelText: 'notes',
                      hintMaxLines: 1000,
                      hintText: 'eg.text'),
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    ElevatedButton(
                        onPressed: () {
                          final String name = _titleController.text;

                          final String number = _contentController.text;
                          FirebaseFirestore.instance
                              .collection('Notes')
                              .doc(documentSnapshot!.id)
                              .update({
                            'note_title': _titleController.text,
                            'creation_date': date,
                            'note_content': _contentController.text,
                            'color_id': color_id,
                          }).then((value) {
                            Navigator.pop(context);
                          }).catchError((error) =>
                                  print('Fail to add new Note due to $error'));
                        },
                        child: const Text("Update")),
                    SizedBox(
                      width: 20,
                    ),
                    ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: const Text("Cencel")),
                  ],
                ),
              ],
            ),
          );
        });
  }

  Future<void> _delete(String productID) async {
    await FirebaseFirestore.instance
        .collection('Notes')
        .doc(productID)
        .delete();
  }

  bool isSearchClicked = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppStyle.mainColor,
      appBar: AppBar(
        elevation: 0.0,
        title: isSearchClicked
            ? Container(
                height: 40,
                decoration: BoxDecoration(
                  color: Color.fromARGB(224, 35, 56, 63),
                  borderRadius: BorderRadius.circular(20.0),
                ),
                child: TextField(
                  autocorrect: true,
                  controller: _searchController,
                  decoration: const InputDecoration(
                    hintText: 'Search..',
                    contentPadding: EdgeInsets.fromLTRB(16, 20, 16, 12),
                    hintStyle: TextStyle(color: Colors.black),
                    border: InputBorder.none,
                  ),
                ),
              )
            : const Text('FireNotes'),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                isSearchClicked = !isSearchClicked;
              });
            },
            icon: Icon(isSearchClicked ? Icons.close_rounded : Icons.search),
          ),
        ],
        backgroundColor: AppStyle.mainColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Your recent Notes',
              style: GoogleFonts.roboto(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 22,
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream:
                    FirebaseFirestore.instance.collection('Notes').snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }

                  if (snapshot.hasError) {
                    return Center(
                      child: Text('Error: ${snapshot.error}'),
                    );
                  }

                  if (snapshot.hasData && snapshot.data != null) {
                    return GridView(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                      ),
                      children: snapshot.data!.docs
                          .map((note) => noteCard(() {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        NoteReaderScreen(note),
                                  ),
                                );
                              }, _update, _delete, note))
                          .toList(),
                    );
                  }
                  return Text(
                    'There are no Notes',
                    style: GoogleFonts.nunito(color: Colors.white),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Colors.amber[600],
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => NoteEditorScreen(),
            ),
          );
        },
        label: Text(
          'Add Note',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        icon: Icon(Icons.add),
      ),
    );
  }
}

// int color_id = Random().nextInt(AppStyle.cardColor.length);
// int color_id = Random().nextInt(AppStyle.cardColor.length);
String date = DateTime.now().toString();

 
  // Future<void> _create([DocumentSnapshot? documentSnapshot]) async {
  //   await showModalBottomSheet(
  //       isScrollControlled: true,
  //       context: context,
  //       builder: (BuildContext ctx) {
  //         return Padding(
  //           padding: EdgeInsets.only(
  //               top: 20,
  //               right: 20,
  //               left: 20,
  //               bottom: MediaQuery.of(ctx).viewInsets.bottom + 20),
  //           child: Column(
  //             mainAxisSize: MainAxisSize.min,
  //             crossAxisAlignment: CrossAxisAlignment.start,
  //             children: [
  //               const Center(
  //                 child: Text(
  //                   "Create your item",
  //                   style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
  //                 ),
  //               ),
  //               TextField(
  //                 controller: _titleController,
  //                 decoration: const InputDecoration(
  //                     labelText: 'Name', hintText: 'eg.Elon'),
  //               ),
  //               TextField(
  //                 controller: _contentController,
  //                 decoration: const InputDecoration(
  //                     labelText: 'Number', hintText: 'eg.10'),
  //               ),
  //               const SizedBox(
  //                 height: 20,
  //               ),
  //               Row(
  //                 mainAxisAlignment: MainAxisAlignment.start,
  //                 children: [
  //                   ElevatedButton(
  //                     onPressed: () async {
  //                       final String title = _titleController.text;
  //                       final String content = _contentController.text;
  //                       if (content != null) {
  //                         FirebaseFirestore.instance.collection('Notes').add({
  //                           'note_title': _titleController.text,
  //                           'creation_date': date,
  //                           'note_content': _contentController.text,
  //                         }).then((value) {
  //                           Navigator.pop(context);
  //                         }).catchError((error) =>
  //                             print('Fail to add new Note due to $error'));
  //                       }
  //                       ;

  //                       Navigator.of(context).pop();
  //                     },
  //                     child: const Text("Create"),
  //                   ),
  //                   SizedBox(
  //                     width: 20,
  //                   ),
  //                   ElevatedButton(
  //                       onPressed: () {
  //                         Navigator.of(context).pop();
  //                       },
  //                       child: const Text("Cencel")),
  //                 ],
  //               )
  //             ],
  //           ),
  //         );
  //       });
  // }

 