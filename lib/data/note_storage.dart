import 'package:hive_flutter/adapters.dart';
import '../models/note_model.dart';

class NoteStorage {
  List<NoteModel> loadNotes() {
    final notesBox = Hive.box('notes');
    final notesData = notesBox.get('notes') as List?;

    if (notesData == null) {
      return [];
    }

    return notesData.map((note) {
      return NoteModel(
        id: note['id'],
        title: note['title'],
        isFavorite: note['isFavorite'],
      );
    }).toList();
  }

  void saveNotes(List<NoteModel> notes) {
    final notesBox = Hive.box('notes');
    final notesJson = notes.map((note) {
      return {
        'id': note.id,
        'title': note.title,
        'isFavorite': note.isFavorite,
      };
    }).toList();
    notesBox.put('notes', notesJson);
  }
}
