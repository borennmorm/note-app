import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:note_app/controllers/note_controller.dart';
import 'package:note_app/views/note_form.dart';

class NoteList extends StatelessWidget {
  final NoteController noteController = Get.put(NoteController());

  NoteList({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notes'),
        backgroundColor: Colors.amberAccent,
      ),
      backgroundColor: Colors.grey[100],
      body: Padding(
        padding: const EdgeInsets.only(top: 12.0),
        child: Obx(() {
          return ListView.builder(
            itemCount: noteController.note.length,
            itemBuilder: (context, index) {
              final note = noteController.note[index];
              return Container(
                margin:
                    const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.1),
                      spreadRadius: 3,
                      blurRadius: 3,
                    ),
                  ],
                ),
                child: ListTile(
                  title: Text(note.title),
                  subtitle: Text(note.content),
                  onTap: () => Get.to(NoteForm(note: note)),
                  trailing: IconButton(
                    icon: const Icon(
                      CupertinoIcons.delete,
                      color: Colors.red,
                    ),
                    onPressed: () => noteController.deleteNote(note.id!),
                  ),
                ),
              );
            },
          );
        }),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Get.to(NoteForm()),
        backgroundColor: Colors.amberAccent,
        shape: const CircleBorder(),
        elevation: 1,
        child: const Icon(
          CupertinoIcons.add,
          size: 28.0,
          color: Colors.black,
        ),
      ),
    );
  }
}
