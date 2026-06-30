import 'package:go_router/go_router.dart';
import 'package:notes_app/models/note_model.dart';
import 'package:notes_app/screens/notes_screen.dart';
import 'package:notes_app/screens/details_screen.dart';

final router = GoRouter(
  routes: [
    GoRoute(path: '/', builder: (context, state) => const NotesScreen()),
    GoRoute(
      path: '/details',
      builder: (context, state) {
        final note = state.extra as NoteModel;
        return DetailsScreen(note: note);
      },
    ),
  ],
);
