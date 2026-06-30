class NoteModel {
  final int id;
  final String title;
  final bool isFavorite;

  const NoteModel({required this.id, required this.title, required this.isFavorite});

  NoteModel copyWith({int? id, String? title, bool? isFavorite}) {
    return NoteModel(
      id: id ?? this.id,
      title: title ?? this.title,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }
}
