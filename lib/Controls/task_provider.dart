
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Models/taskModel.dart';

class TaskProvider extends ChangeNotifier {
  final List<TaskModel> _tasks = [];
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  List<TaskModel> get tasks => _tasks;

  bool _obsecurePassword = true;
  //bool isLoading= true;
  bool get obsecurePassword => _obsecurePassword;

  bool _isDarkMode = false;

  bool get isDarkMode => _isDarkMode;

  TaskProvider() {
    _loadTheme();
  }

  Future<void> _loadTheme() async {
    final prefs = await SharedPreferences.getInstance();
    _isDarkMode = prefs.getBool('isDarkMode') ?? false;
    notifyListeners();
  }

  Future<void> toggleTheme() async {
    _isDarkMode = !_isDarkMode;
    notifyListeners();

    final prefs = await SharedPreferences.getInstance();
    prefs.setBool('isDarkMode', _isDarkMode);
  }

  //  Helper: convert email to safe Firestore ID
  String? get _userDocId {
    final user = _auth.currentUser;
    if (user == null || user.email == null) return null;
    return user.email!.replaceAll('.', '_');
  }

  //  Add Task
  // inside Controls/task_provider.dart (replace the two methods)

  //  Add Task (now saves server timestamp)
  Future<void> addTask(String title, String description, String? imageUrl) async {
    final docId = _userDocId;
    if (docId == null) return;

    final docRef = await _firestore
        .collection('users')
        .doc(docId)
        .collection('tasks')
        .add({
      'title': title,
      'description': description,
      'imageUrl': imageUrl,
      'createdAt': FieldValue.serverTimestamp(), // store server timestamp
    });

    // fetch the document (to get timestamp) or set createdAt as now locally
    final savedDoc = await docRef.get();
    DateTime? created;
    final createdValue = savedDoc.data()?['createdAt'];
    if (createdValue is Timestamp) {
      created = createdValue.toDate();
    }

    _tasks.add(TaskModel(
        id: docRef.id,
        title: title,
        description: description,
        imageUrl: imageUrl,
        createdAt: created ?? DateTime.now()));
    notifyListeners();
  }

  //  Load Tasks (now reads createdAt)
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
      final data = doc.data();
      DateTime? created;
      final createdValue = data['createdAt'];
      if (createdValue is Timestamp) {
        created = createdValue.toDate();
      }
      _tasks.add(TaskModel(
        id: doc.id,
        title: data['title'] ?? '',
        description: data['description'] ?? '',
        imageUrl: data['imageUrl'],
        createdAt: created,
      ));
    }

    notifyListeners();
  }


  //  Update Task
  Future<void> updateTask(int index, String newTitle, String newDescription, String? newimageUrl) async {
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
      'imageUrl' : newimageUrl
    });

    task.title = newTitle;
    task.description = newDescription;
    task.imageUrl=newimageUrl;
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
