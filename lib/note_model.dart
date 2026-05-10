class NoteModel {
  final int id;
  final String title;
  final bool isFavorite;

  NoteModel({required this.id, required this.title, required this.isFavorite});

  NoteModel copyWith({int? id, String? title, bool? isFavourite}) {
    return NoteModel(
      id: id ?? this.id,
      title: title ?? this.title,
      isFavorite: isFavourite ?? isFavorite,
    );
  }
}
