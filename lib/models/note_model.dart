class NoteModel {
  final String uid;
  final String title;
  final String note;
  final DateTime date;

  NoteModel({
    required this.uid,
    required this.title,
    required this.note,
    required this.date,
  });

  static String get COLLECTION_NAME => "note_list";

  factory NoteModel.fromJson(Map<String, dynamic> json) {
    return NoteModel(uid: json["uid"], title: json["title"], note: json["note"], date: DateTime.parse(json["date"]));
  }

  Map<String, dynamic> toJson() => {
        "uid": uid,
        "title": title,
        "note": note,
        "date": date.toIso8601String(),
      };
}
