import 'package:get_storage/get_storage.dart';
import 'package:note_app/models/note_model.dart';
import 'package:uuid/uuid.dart';

class StorageMethods {
  final _data = GetStorage();

  Future<void> deleteNote(String noteUid)async{
    try {
      List<Map<String,dynamic>> list = _data.read(NoteModel.COLLECTION_NAME);
      list.removeWhere((element) => element["uid"] == noteUid);
      await _data.write(NoteModel.COLLECTION_NAME, list);
    } catch (e) {
      null;
    }
  }

  Future<List<NoteModel>> getNoteList() async {
    List<NoteModel> list = [];
    try {
      List<Map<String, dynamic>> l = _data.read(NoteModel.COLLECTION_NAME);
      for (var i in l) {
        list.add(NoteModel.fromJson(i));
      }
    } catch (e) {
      list.clear();
    }
    return list;
  }

  Future<bool> addNewNote(String title, String note) async {
    bool res = false;
    try {
      String uid = const Uuid().v4();
      DateTime date = DateTime.now();
      var model = NoteModel(
        uid: uid,
        title: title,
        note: note,
        date: date,
      );
      List<Map<String, dynamic>> list = [];
      list = _data.read(NoteModel.COLLECTION_NAME) ?? [];
      list.add(model.toJson());
      await _data.write(NoteModel.COLLECTION_NAME, list);
      res = true;
    } catch (e) {
      null;
    }
    return res;
  }
}
