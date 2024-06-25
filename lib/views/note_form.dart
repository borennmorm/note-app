import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:note_app/controllers/note_controller.dart';
import 'package:note_app/models/note_model.dart';

class NoteForm extends StatelessWidget {
  final NoteController noteController = Get.find<NoteController>();
  final Note? note;

  final TextEditingController titleController = TextEditingController();
  final TextEditingController contentController = TextEditingController();

  NoteForm({super.key, this.note}) {
    if (note != null) {
      titleController.text = note!.title;
      contentController.text = note!.content;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(note == null ? 'Add Note' : 'Edit Note'),
        backgroundColor: Colors.amberAccent,
      ),
      backgroundColor: Colors.grey[100],
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: titleController,
              decoration: const InputDecoration(labelText: 'Title'),
            ),
            TextField(
              controller: contentController,
              decoration: const InputDecoration(labelText: 'Content'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.amberAccent, // Background color
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0), // Rounded corners
                ),
                elevation: 3, // Elevation
                padding: const EdgeInsets.symmetric(
                    horizontal: 16.0, vertical: 12.0), // Padding
              ),
              onPressed: () {
                if (note == null) {
                  noteController.addNote(
                    Note(
                      title: titleController.text,
                      content: contentController.text,
                    ),
                  );
                } else {
                  noteController.updateNote(
                    Note(
                      id: note!.id,
                      title: titleController.text,
                      content: contentController.text,
                    ),
                  );
                }
                Get.back();
              },
              child: Text(
                note == null ? 'Add' : 'Update',
                style: const TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
