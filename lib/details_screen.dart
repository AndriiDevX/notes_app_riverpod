import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:notes_app/note_model.dart';
import 'package:notes_app/note_provider.dart';


class DetailsScreen extends ConsumerWidget {
  final NoteModel note;
  const DetailsScreen({super.key, required this.note});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = TextEditingController(text: note.title);

    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Note'),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              ref.read(noteProvider.notifier).updateNote(note, controller.text);
              if (context.canPop()) {
                context.pop();
              } else {
                context.go('/');
              }
            },
            icon: Icon(Icons.save),
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: TextField(controller: controller),
      ),
    );
  }
}
