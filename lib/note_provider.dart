import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import 'note_model.dart';

class NoteNotifier extends StateNotifier<List<NoteModel>> {
  final notesBox = Hive.box('notes');
  NoteNotifier() : super([]) {
    loadNotes();
  }

  void addNote(String title) {
    final newNote = NoteModel(
      id: state.length,
      title: title,
      isFavorite: false,
    );
    state = [...state, newNote];

    saveNotes();
  }

  void removeNote(int id) {
    state = state.where((n) => n.id != n.id).toList();
    saveNotes();
  }

  void favoriteNote(NoteModel note) {
    state = state.map((n) {
      if (n.id == note.id) {
        return n.copyWith(isFavourite: !n.isFavorite);
      }
      return n;
    }).toList();
    saveNotes();
  }

  void updateNote(NoteModel note, String newTitle) {
    state = state.map((n) {
      if (n.id == note.id) {
        return n.copyWith(title: newTitle);
      }
      return n;
    }).toList();
    saveNotes();
  }

  void loadNotes() {
    final notesData = notesBox.get('notes') as List?;

    if (notesData == null) return;
    state = notesData.map((note) {
      return NoteModel(
        id: note['id'],
        title: note['title'],
        isFavorite: note['isFavorite'],
      );
    }).toList();
  }

  void saveNotes() {
    final notesJson = state.map((note) {
      return {
        'id': note.id,
        'title': note.title,
        'isFavorite': note.isFavorite,
      };
    }).toList();
    notesBox.put('notes', notesJson);
  }
}

final noteProvider = StateNotifierProvider<NoteNotifier, List<NoteModel>>(
  (ref) => NoteNotifier(),
);
