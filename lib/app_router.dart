import 'package:go_router/go_router.dart';
import 'package:notes_app_riverpod/note_model.dart';
import 'package:notes_app_riverpod/notes_screen.dart';
import 'package:notes_app_riverpod/details_screen.dart';

final router = GoRouter(
  routes: [
    GoRoute(path: '/', builder: (context, state) => NotesScreen()),
    GoRoute(path: '/details', 
    builder: (context, state) {
        final note = state.extra as NoteModel;
        return DetailsScreen(note: note);
    }),
  ],
);
