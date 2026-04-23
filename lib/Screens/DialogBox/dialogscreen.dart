import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/App-State/task_provider.dart';
import 'package:todo_app/Models/task.dart';
import 'package:todo_app/utils.dart';

class DialogScreen extends StatefulWidget {
  const DialogScreen({super.key});

  @override
  State<DialogScreen> createState() => _DialogScreenState();
}

class _DialogScreenState extends State<DialogScreen> {


  @override
  void initState() {
    super.initState();
    Future.microtask(() =>
        Provider.of<TaskProvider>(context, listen: false).loadTasks());
  }
  final TextEditingController _titleControl = TextEditingController();
  final TextEditingController _descripControl = TextEditingController();


  // fn of addTask
  void _showaddDialog(BuildContext context) {
    _titleControl.clear();
    _descripControl.clear();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(

        title: const Text("Add Task"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [

            dialogtxtFld(context,_titleControl, "Enter Title "),
            const SizedBox(height: 10),
            dialogtxtFld(context,_descripControl, "Enter Description")
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: txtBtn('Cancel'),
            
          ),
         dialogBtn(
             (){
               if (_titleControl.text.trimLeft().isNotEmpty &&
                   _descripControl.text.trimLeft().isNotEmpty /*&& _titleControl == null && _descripControl==null*/){
                 Provider.of<TaskProvider>(context, listen: false).addTask(
                   _titleControl.text,
                   _descripControl.text,
                 );
                 Navigator.pop(context);
               }else{
                 ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Invalid Input")));
               }
             }, "Add")
        ],
      ),
    );
  }

  //fn of updateTask
  void _showupdateDialog(BuildContext context, int index, Task task) {
    _titleControl.text = task.title;
    _descripControl.text = task.description;

    showDialog(
      context: context,
      builder: (context) => Theme(
        data: Theme.of(context).copyWith(
          textSelectionTheme: const TextSelectionThemeData(
            cursorColor: Colors.deepOrange,              // blinking cursor color
            selectionColor: Colors.orangeAccent,  // highlight color when text is selected
            selectionHandleColor: Colors.deepOrange,   // the handles (drag dots)
          ),
        ),
        child: AlertDialog(
          title: const Text("Update Task"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              dialogtxtFld(
                  context,_titleControl,
                  "Update  Title"
              ),
              const SizedBox(height: 10),
              dialogtxtFld(
               context, _descripControl,
                "Update Description"
              )
            ],
          ),
          actions: [
            TextButton(
              child:  txtBtn("Cancel"),
              onPressed: () => Navigator.pop(context),
            ),
            dialogBtn(() async {
              final newTitle = _titleControl.text.trim();
              final newDescription = _descripControl.text.trim();

              if (newTitle.isNotEmpty && newDescription.isNotEmpty) {
                // Await the async update function
                await Provider.of<TaskProvider>(context, listen: false)
                    .updateTask(index, newTitle, newDescription);

                Navigator.pop(context); // Close the dialog after update
              } else {
                // Show error if empty
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Title and description cannot be empty.")),
                );
              }
            }, "Update"),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final taskProvider = Provider.of<TaskProvider>(context);

    return Scaffold(
      body: SafeArea(
        child: taskProvider.tasks.isEmpty
            ? const Center(child: Text("No Task Yet"))
            : ListView.builder(
          itemCount: taskProvider.tasks.length,
          itemBuilder: (context, index) {
            final task = taskProvider.tasks[index];
            return Card(
              margin: const EdgeInsets.symmetric(
                  horizontal: 10, vertical: 5),
              child: ListTile(
                title: Text(
                  task.title,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 16),
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(task.description),
                    const SizedBox(height: 4),
                  ],
                ),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.edit, color: Colors.blue),
                      onPressed: () =>
                          _showupdateDialog(context, index, task),
                    ),
                    IconButton(
                      icon: const Icon(Icons.delete, color: Colors.red),
                      onPressed: () =>
                          taskProvider.deleteTask(index),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),

      // Floating Action Button for Adding New Tasks
      floatingActionButton: FloatingActionButton(
        shape:
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        elevation: 10,
        foregroundColor: Colors.white,
        backgroundColor: Colors.deepOrange,
        splashColor: Colors.orangeAccent,
        onPressed: () {
          _showaddDialog(context);
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
