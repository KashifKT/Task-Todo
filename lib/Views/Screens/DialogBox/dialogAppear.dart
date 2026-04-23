import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:provider/provider.dart';
import '../../../Controls/task_provider.dart';
import '../../../Models/taskModel.dart';
import '../../../Utils/utilsDialogBox.dart';

class DialogAppeare {
  final TextEditingController _titleControl = TextEditingController();
  final TextEditingController _descripControl = TextEditingController();
  final ImagePicker _picker = ImagePicker();
  File? _selectedImage;

  // 🔹 Pick image from gallery
  Future<void> _pickImage(
      BuildContext context, void Function(void Function()) setState) async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _selectedImage = File(pickedFile.path);
      });
    }
  }

  // 🔹 Upload image to Firebase Storage and return URL
  Future<String?> _uploadImage(File imageFile) async {
    final storageRef = FirebaseStorage.instance
        .ref()
        .child('task_images')
        .child('${DateTime.now().millisecondsSinceEpoch}.jpg');

    await storageRef.putFile(imageFile);
    return await storageRef.getDownloadURL();
  }

  // 🔹 Add Task Dialog
  void showaddDialog(BuildContext context) {
    _titleControl.clear();
    _descripControl.clear();
    _selectedImage = null;

    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) => AlertDialog(
          title: dialogTitle("Add Task"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              dialogtxtFld(context, _titleControl, "Enter Title"),
              const SizedBox(height: 10),
              dialogtxtFld(context, _descripControl, "Enter Description"),
              const SizedBox(height: 10),
              /*GestureDetector(
                onTap: () => _pickImage(context, setState),
                child: _selectedImage == null
                    ? Container(
                  height: 100,
                  width: double.infinity,
                  color: Colors.orange[100],
                  alignment: Alignment.center,
                  child: const Text("Tap to select image"),
                )
                    : Image.file(_selectedImage!,
                    height: 100, fit: BoxFit.cover),
              ),*/
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text("Cancel"),
            ),
            dialogBtn(() async {
              final title = _titleControl.text.trim();
              final desc = _descripControl.text.trim();

              // 🔒 Validate
              if (title.isNotEmpty && desc.isNotEmpty) {
                String? imageUrl;
                if (_selectedImage != null) {
                  imageUrl = await _uploadImage(_selectedImage!);
                }

                await Provider.of<TaskProvider>(context, listen: false)
                    .addTask(title, desc, imageUrl);

                Navigator.pop(context);
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Please enter valid input")),
                );
              }
            }, "Add"),
          ],
        ),
      ),
    );
  }

  // 🔹 Update Task Dialog
  void showupdateDialog(BuildContext context, int index, TaskModel task) {
    _titleControl.text = task.title;
    _descripControl.text = task.description;
    _selectedImage = null;

    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) => AlertDialog(
          title: dialogTitle("Update Task"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              dialogtxtFld(context, _titleControl, "Update Title"),
              const SizedBox(height: 10),
              dialogtxtFld(context, _descripControl, "Update Description"),
              const SizedBox(height: 10),
              /*GestureDetector(
                onTap: () => _pickImage(context, setState),
                child: _selectedImage == null
                    ? (task.imageUrl != null
                    ? Image.network(task.imageUrl!,
                    height: 100, fit: BoxFit.cover)
                    : Container(
                  height: 100,
                  width: double.infinity,
                  color: Colors.orange[100],
                  alignment: Alignment.center,
                  child: const Text("Tap to select image"),
                ))
                    : Image.file(_selectedImage!,
                    height: 100, fit: BoxFit.cover),
              ),*/
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text("Cancel"),
            ),
            dialogBtn(() async {
              final newTitle = _titleControl.text.trim();
              final newDesc = _descripControl.text.trim();

              if (newTitle.isNotEmpty && newDesc.isNotEmpty) {
                String? newImageUrl = task.imageUrl;
                if (_selectedImage != null) {
                  newImageUrl = await _uploadImage(_selectedImage!);
                }

                await Provider.of<TaskProvider>(context, listen: false)
                    .updateTask(index, newTitle, newDesc, newImageUrl);

                Navigator.pop(context);
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                      content:
                      Text("Title and description cannot be empty.")),
                );
              }
            }, "Update"),
          ],
        ),
      ),
    );
  }
}


