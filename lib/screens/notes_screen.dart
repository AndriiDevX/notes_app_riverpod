import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../core/app_colors.dart';
import '../providers/note_provider.dart';
import '../widgets/filter_choice_chip.dart';

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
      backgroundColor: AppColors.scaffoldBackground,
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              final controller = TextEditingController();

              return AlertDialog(
                title: const Text('Add note'),
                content: TextField(controller: controller),
                actions: [
                  TextButton(
                    onPressed: () {
                      ref.read(noteProvider.notifier).addNote(controller.text);
                      Navigator.pop(context);
                    },
                    child: const Icon(Icons.add),
                  ),
                ],
              );
            },
          );
        },
      ),
      appBar: AppBar(
        backgroundColor: AppColors.scaffoldBackground,
        title: const Text('My notes'),
        centerTitle: true,
      ),
      body: filteredNotes.isEmpty
          ? const Center(child: Text('No notes found'))
          : Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      FilterChoiceChip(
                        icon: Icons.notes,
                        isSelected: selectedFilter == Filter.all,
                        onSelected: (selected) {
                          if (selected) {
                            setState(() => selectedFilter = Filter.all);
                          }
                        },
                      ),
                      const SizedBox(width: 8),
                      FilterChoiceChip(
                        icon: Icons.star,
                        isSelected: selectedFilter == Filter.onlyFavorites,
                        onSelected: (selected) {
                          if (selected) {
                            setState(() => selectedFilter = Filter.onlyFavorites);
                          }
                        },
                      ),
                      const SizedBox(width: 8),
                      FilterChoiceChip(
                        icon: Icons.star_border,
                        isSelected: selectedFilter == Filter.onlyNotFavorites,
                        onSelected: (selected) {
                          if (selected) {
                            setState(
                              () => selectedFilter = Filter.onlyNotFavorites,
                            );
                          }
                        },
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: TextField(
                    onChanged: (value) {
                      setState(() {
                        query = value;
                      });
                    },
                  ),
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
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Note deleted')),
                            );
                          },
                          icon: const Icon(Icons.delete),
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
