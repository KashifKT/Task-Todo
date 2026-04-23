import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/Controls/task_provider.dart';
import 'package:todo_app/Utils/utilsDialogBox.dart';

import 'loginform.dart';

Future iconLogoutBtn(BuildContext context){

return showDialog(
    context: context,
    builder: (ctx) =>
        AlertDialog(
          title: const Text("LOG-OUT"),
          content: const Text("Are you sure you want to log out?"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context); // ❌ Close popup
              },
              child: txtBtn("Cancel"),
            ),
            TextButton(
              onPressed: () async {
                Navigator.pop(context); // Close popup first
                await FirebaseAuth.instance.signOut();

// ✅ Redirect to login screen
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginUI()),
                );

// Optional snackbar
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Logged out successfully")),
                );
              },
              child: const Text(
                "Logout",
                style: TextStyle(color: Colors.red),
              ),
            ),
          ],
        ),
  );
}

//Alert box for delete


Future iconDelBtn(BuildContext context, int index){

  return showDialog(
    context: context,
    builder: (ctx) =>
        AlertDialog(
          title: const Text("Delete Task"),
          content: const Text("Are you sure you want to delete task?"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context); // ❌ Close popup
              },
              child:  txtBtn("Cancel"),
            ),
            TextButton(
              onPressed: () async {
                Navigator.pop(context); // Close popup first
                await Provider.of<TaskProvider>(context, listen: false).deleteTask(index);
// Optional snackbar
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Deleted successfully")),
                );
              },
              child: const Text(
                "Delete",
                style: TextStyle(color: Colors.red),
              ),
            ),
          ],
        ),
  );
}

//Alert box for delete
