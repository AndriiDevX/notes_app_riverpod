import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'note_provider.dart';

class NotesScreen extends ConsumerStatefulWidget {
  const NotesScreen({super.key});

  @override
  ConsumerState<NotesScreen> createState() => _NotesScreenState();
}

enum Filter { all, onlyFavorites, onlyNotFavorites }

class _NotesScreenState extends ConsumerState<NotesScreen> {
  String query = '';

  Filter selectedFilter = Filter.all;

  @override
  Widget build(BuildContext context) {
    final notes = ref.watch(noteProvider);

    final filteredNotes = notes
        .where((note) => note.title.toLowerCase().contains(query.toLowerCase()))
        .where(
          (note) =>
              (selectedFilter == Filter.all) ||
              (selectedFilter == Filter.onlyFavorites && note.isFavorite) ||
              (selectedFilter == Filter.onlyNotFavorites && !note.isFavorite),
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
                if (selectedFilter == Filter.all) {
                  selectedFilter = Filter.onlyFavorites;
                } else if (selectedFilter == Filter.onlyFavorites) {
                  selectedFilter = Filter.onlyNotFavorites;
                } else {
                  selectedFilter = Filter.all;
                }
              });
            },
            icon: Icon(Icons.star),
          ),
        ],
      ),
      body: filteredNotes.isEmpty
          ? Center(child: Text('No notes found'))
          : Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        selectedFilter = Filter.all;
                      });
                    }, 
                    child: Icon(Icons.notes)),
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          selectedFilter = Filter.onlyFavorites;
                        });
                      } , 
                      child: Icon(Icons.star)),
                      ElevatedButton(onPressed: () {
                        setState(() {
                          selectedFilter = Filter.onlyNotFavorites;
                        });
                      }, child: Icon(Icons.star_border) )
                ],

              ),
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
