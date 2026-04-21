import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:notes_app_riverpod/note_model.dart';

class DetailsScreen extends StatelessWidget {
  final NoteModel note;
  const DetailsScreen({super.key, required this.note});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.pop();
        },
      ),
      appBar: AppBar(title:  Text('Details'), centerTitle: true,),
      body: Center(child: Text(note.title),),
    );
  }
}
