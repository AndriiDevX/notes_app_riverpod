import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../data/note_storage.dart';
import '../models/note_model.dart';

class NoteNotifier extends Notifier<List<NoteModel>> {
  final _storage = NoteStorage();

  @override
  List<NoteModel> build() {
    return _storage.loadNotes();
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
    state = state.where((n) => n.id != id).toList();
    saveNotes();
  }

  void favoriteNote(NoteModel note) {
    state = state.map((n) {
      if (n.id == note.id) {
        return n.copyWith(isFavorite: !n.isFavorite);
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

  void saveNotes() {
    _storage.saveNotes(state);
  }
}

final noteProvider = NotifierProvider<NoteNotifier, List<NoteModel>>(
  () => NoteNotifier(),
);
