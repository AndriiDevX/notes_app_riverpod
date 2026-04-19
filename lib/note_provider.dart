import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'note_model.dart';

class NoteNotifier extends StateNotifier<List<NoteModel>>{
NoteNotifier() : super([]);

void addNote(String title,){
  final newNote = NoteModel(id: state.length , title: title);
  state = [...state, newNote];
}

void removeNote(int id){
  state = state.where((n) => n.id != id).toList();
}
}

final noteProvider = StateNotifierProvider<NoteNotifier, List<NoteModel>>(
  (ref) => NoteNotifier(),
);
