import 'package:get/get.dart';
import 'package:note_app/models/note_model.dart';
import 'package:note_app/services/db_service.dart';

class NoteController extends GetxController {
  // Reactive List: Declares a list of Note objects that is observable (obs). Any changes to this list will automatically update the UI components that are observing it.
  var note = <Note>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchNotes();
  }

  void fetchNotes() async {
    var notesFromDB = await DBService().getNotes();
    note.assignAll(notesFromDB);
  }

  void addNote(Note note) async {
    await DBService().insertNote(note);
    fetchNotes();
  }

  void updateNote(Note note) async {
    await DBService().updateNote(note);
    fetchNotes();
  }

  void deleteNote(int id) async {
    await DBService().deleteNote(id);
    fetchNotes();
  }
}
