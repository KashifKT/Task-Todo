import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../Controls/task_provider.dart';
import '../../../Models/taskModel.dart';
import '../DialogBox/dialogAppear.dart';

class TaskDetailPage extends StatelessWidget {
  final TaskModel task;
  final int index;

  const TaskDetailPage({super.key, required this.task, required this.index});

  @override
  Widget build(BuildContext context) {
    final taskProvider = Provider.of<TaskProvider>(context, listen: false);
    final dialog = DialogAppeare();

    return Scaffold(
      appBar: AppBar(
        title: Text(
          task.title,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: [
          // 🗑 Delete Button
          IconButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text("Delete Task"),
                  content: const Text("Are you sure you want to delete this task?"),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text("Cancel"),
                    ),
                    TextButton(
                      onPressed: () async {
                        await taskProvider.deleteTask(index);
                        Navigator.pop(context);
                        Navigator.pop(context);
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text("Task deleted successfully")),
                        );
                      },
                      child: const Text("Delete", style: TextStyle(color: Colors.red)),
                    ),
                  ],
                ),
              );
            },
            icon: const Icon(CupertinoIcons.delete, color: Colors.red),
          ),

          // ✏️ Edit Button
          IconButton(
            onPressed: () {
              dialog.showupdateDialog(context, index, task);
            },
            icon: const Icon(CupertinoIcons.pencil, color: Colors.orange),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Card(
          elevation: 6,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 🔹 Task Image
                if (task.imageUrl != null && task.imageUrl!.isNotEmpty)
                  ClipRRect(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(15),
                      topRight: Radius.circular(15),
                    ),
                    child: Image.asset(
                      "assets/icon/app_icon",
                      width: double.infinity,
                      height: 220,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) =>
                      const Icon(Icons.broken_image, size: 100),
                    ),
                  )
                else
                  Container(
                    height: 220,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.white10,
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(15),
                        topRight: Radius.circular(15),
                      ),
                    ),
                    alignment: Alignment.center,
                    child: Image.asset(
                      "assets/icon/app_icon",
                      width: double.infinity,
                      height: 220,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) =>
                      const Icon(Icons.task, size: 100, color: Colors.deepOrange,),
                    ),
                  ),

                // 🔹 Task Details
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        task.title,
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        task.description,
                        style: const TextStyle(fontSize: 16, color: Colors.black87),
                      ),
                      const SizedBox(height: 20),
                      Row(
                        children: [
                          const Icon(Icons.calendar_today, size: 18, color: Colors.grey),
                          const SizedBox(width: 6),
                          Text(
                            "Created on: ${task.createdAt}",
                            style: const TextStyle(color: Colors.grey),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
