import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'note_provider.dart';

class NotesScreen extends ConsumerStatefulWidget {
  const NotesScreen({super.key});

  @override
  ConsumerState<NotesScreen> createState() => _NotesScreenState();
}

class _NotesScreenState extends ConsumerState<NotesScreen> {
  String query = '';
  bool showOnlyFavorites = false;
  bool showOnlyNotFavorites = false;

  @override
  Widget build(BuildContext context) {
    final notes = ref.watch(noteProvider);

    final filteredNotes = notes
        .where((note) => note.title.toLowerCase().contains(query.toLowerCase()))
        .where(
          (note) =>
              (!showOnlyFavorites && !showOnlyNotFavorites)||
              (showOnlyFavorites && note.isFavorite)||
              (showOnlyNotFavorites && !note.isFavorite)
        )
        .toList();

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
      appBar: AppBar(
        title: Text('My notes'),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                showOnlyFavorites = !showOnlyFavorites;
              });
            },
            icon: Icon(Icons.star),
          ),
        ],
      ),
      body: Column(
        children: [
          TextField(
            onChanged: (value) {
              setState(() {
                query = value;
              });
            },
          ),
          Expanded(
            child: ListView.builder(
              itemCount: filteredNotes.length,
              itemBuilder: (context, index) {
                final note = filteredNotes[index];
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
                      note.isFavorite ? Icons.star : Icons.star_border,
                    ),
                  ),
                  trailing: IconButton(
                    onPressed: () {
                      ref.read(noteProvider.notifier).removeNote(note.id);
                    },
                    icon: Icon(Icons.delete),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
