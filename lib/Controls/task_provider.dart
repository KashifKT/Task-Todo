import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import '../Models/task.dart';

class TaskProvider extends ChangeNotifier {
  final List<Task> _tasks = [];
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  List<Task> get tasks => _tasks;

  bool _obsecurePassword = true;
  bool get obsecurePassword => _obsecurePassword;

  // 🔹 Helper: convert email to safe Firestore ID
  String? get _userDocId {
    final user = _auth.currentUser;
    if (user == null || user.email == null) return null;
    return user.email!.replaceAll('.', '_');
  }

  // 🔹 Add Task
  Future<void> addTask(String title, String description) async {
    final docId = _userDocId;
    if (docId == null) return;

    final docRef = await _firestore
        .collection('users')
        .doc(docId)
        .collection('tasks')
        .add({
      'title': title,
      'description': description,
      'createdAt': FieldValue.serverTimestamp(),
    });

    _tasks.add(Task(id: docRef.id, title: title, description: description));
    notifyListeners();
  }

  // 🔹 Load Tasks
  Future<void> loadTasks() async {
    final docId = _userDocId;
    if (docId == null) return;

    final snapshot = await _firestore
        .collection('users')
        .doc(docId)
        .collection('tasks')
        .orderBy('createdAt', descending: true)
        .get();

    _tasks.clear();
    for (var doc in snapshot.docs) {
      _tasks.add(Task(
        id: doc.id,
        title: doc['title'] ?? '',
        description: doc['description'] ?? '',
      ));
    }

    notifyListeners();
  }

  // 🔹 Update Task
  Future<void> updateTask(int index, String newTitle, String newDescription) async {
    final docId = _userDocId;
    if (docId == null) return;

    final task = _tasks[index];
    if (task.id == null) return;

    await _firestore
        .collection('users')
        .doc(docId)
        .collection('tasks')
        .doc(task.id)
        .update({
      'title': newTitle,
      'description': newDescription,
    });

    task.title = newTitle;
    task.description = newDescription;
    notifyListeners();
  }

  // 🔹 Delete Task
  Future<void> deleteTask(int index) async {
    final docId = _userDocId;
    if (docId == null) return;

    final task = _tasks[index];
    if (task.id == null) return;

    await _firestore
        .collection('users')
        .doc(docId)
        .collection('tasks')
        .doc(task.id)
        .delete();

    _tasks.removeAt(index);
    notifyListeners();
  }

  // 🔹 Toggle Password Visibility
  void obsecurepass() {
    _obsecurePassword = !_obsecurePassword;
    notifyListeners();
  }
}
