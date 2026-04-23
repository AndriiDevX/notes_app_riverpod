import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'note_provider.dart';


class NotesScreen extends ConsumerWidget {
  const NotesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notes = ref.watch(noteProvider);
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              final controller = TextEditingController();
              return AlertDialog(
                title: Text('Add note'),
                content: TextField(controller: controller),
                actions: [
                  TextButton(
                    onPressed: () {
                      ref.read(noteProvider.notifier).addNote(controller.text);
                      Navigator.pop(context);
                    },
                    child: Icon(Icons.add),
                  ),
                ],
              );
            },
          );
        },
      ),
      appBar: AppBar(title: Text('My notes'), centerTitle: true),
      body: ListView.builder(
        itemCount: notes.length,
        itemBuilder: (context, index) {
          final note = notes[index];
          return ListTile(
            onTap: () {
              context.go('/details', extra: note);
            },
            title: Text(note.title),
            leading: IconButton(
              onPressed: () {
                 ref.read(noteProvider.notifier).favoriteNote(note);
              }, 
              icon: Icon(
                note.isFavorite ? Icons.star
                : Icons.star_border
              )),
            trailing: IconButton(
              onPressed: () {
                ref.read(noteProvider.notifier).removeNote(note.id);
              },
              icon: Icon(Icons.delete),
            ),
          );
        },
      ),
    );
  }
}
