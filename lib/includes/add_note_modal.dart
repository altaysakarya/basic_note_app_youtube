import 'package:flutter/material.dart';
import 'package:note_app/methods/storage_methods.dart';

Future<void> addNoteModal(BuildContext context) async {
  final formKey = GlobalKey<FormState>();
  final titleController = TextEditingController();
  final noteController = TextEditingController();
  await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(5),
        ),
      ),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(12.0),
          child: Padding(
            padding: MediaQuery.of(context).viewInsets,
            child: Form(
              key: formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextFormField(
                    controller: titleController,
                    validator: (e) {
                      if (e!.isEmpty) {
                        return "Invalid value";
                      }
                      return null;
                    },
                    minLines: 1,
                    maxLines: 1,
                    decoration: const InputDecoration(
                      labelText: "Title",
                      contentPadding: EdgeInsets.all(5.0),
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    controller: noteController,
                    minLines: 4,
                    maxLines: 8,
                    validator: (e) {
                      if (e!.isEmpty) {
                        return "Invalid value";
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                      labelText: "Note",
                      contentPadding: EdgeInsets.all(5.0),
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      if (formKey.currentState!.validate()) {
                        bool res = await StorageMethods().addNewNote(titleController.text, noteController.text);
                        if (res) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Note add succesfuly'),
                            ),
                          );
                          Navigator.pop(context);
                        }
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      shape: const StadiumBorder(),
                    ),
                    child: const Text('Save'),
                  ),
                ],
              ),
            ),
          ),
        );
      });
}
