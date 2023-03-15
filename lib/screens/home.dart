import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:note_app/includes/add_note_modal.dart';
import 'package:note_app/methods/storage_methods.dart';
import 'package:note_app/models/note_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<NoteModel> list = [];
  var storage = GetStorage();

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () async {
      list = await StorageMethods().getNoteList();
      if (mounted) {
        setState(() {});
      }
      storage.listenKey(NoteModel.COLLECTION_NAME, (value) async {
        list = await StorageMethods().getNoteList();
        if (mounted) {
          setState(() {});
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        title: const Text(
          "Note App",
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () async {
              await addNoteModal(context);
            },
            icon: const Icon(
              Icons.add,
              color: Colors.black,
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ListView.builder(
                shrinkWrap: true,
                itemCount: list.length,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, i) {
                  var element = list.elementAt(i);

                  return ListTile(
                    title: Text(element.title),
                    subtitle: Text(
                      element.note, /*  maxLines: 1, overflow: TextOverflow.ellipsis, */
                    ),
                    trailing: IconButton(
                      onPressed: () async {
                        await StorageMethods().deleteNote(element.uid);
                      },
                      icon: const Icon(CupertinoIcons.delete),
                    ),
                  );
                })
          ],
        ),
      ),
    );
  }
}
