import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'note_model.dart';

class NoteNotifier extends StateNotifier<List<NoteModel>>{
NoteNotifier() : super([]);

void addNote(String title,){
  final newNote = NoteModel(id: state.length , title: title, isFavorite: false);
  state = [...state, newNote];
}

void removeNote(int id){
  state = state.where((n) => n.id != id).toList();
}

void favoriteNote(NoteModel note){
 state = state.map((n){
    if(n.id == note.id){
      return n.copyWith(isFavourite: !n.isFavorite);
    }else{
      return n;
    }
  }).toList();
}





void updateNote(NoteModel note, String newTitle){
  state = state.map((n){
    if(n.id == note.id){
      return n.copyWith(title: newTitle);
    }else{
      return n;
    }
  }).toList();
}
}


final noteProvider = StateNotifierProvider<NoteNotifier, List<NoteModel>>(
  (ref) => NoteNotifier(),
);
