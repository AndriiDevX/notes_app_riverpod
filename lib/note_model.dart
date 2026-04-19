class NoteModel {
  final int id;
  final String title;

  NoteModel({required this.id, required this.title});

  NoteModel copyWith({
    int? id,
    String? title,
  }) {
    return NoteModel(
      id: id??this.id,
      title: title??this.title,
    );
  }
}
