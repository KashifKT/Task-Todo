import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/Controls/task_provider.dart';
import 'package:todo_app/Views/Screens/Form%20Pages/logoutalert.dart';
import '../Screens/Form Pages/loginform.dart';

Widget cusDrawer(BuildContext context){
  final taskProvider= Provider.of<TaskProvider>(context);
  return SafeArea(
    child: Drawer(
      child: ListView(
        padding: EdgeInsets.all(22),
        children: [
          DrawerHeader(
            decoration: BoxDecoration(color: Colors.deepOrange, borderRadius: BorderRadius.only(bottomRight: Radius.zero, bottomLeft: Radius.zero,topLeft: Radius.circular(22), topRight: Radius.circular(22))),
            child: Align(
              alignment: Alignment.bottomLeft,
              child: Column(

                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment:  CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    child: Icon(CupertinoIcons.profile_circled),
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.deepOrange,
                    //radius: 30,
                    maxRadius: 35,
                    minRadius: 20,
                  ),

                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('Name', style: TextStyle(color: Colors.white), maxLines: 1,),
                  ),

                ],
              ),
            )
          ),
          ListTile(
            leading: const Icon(Icons.dark_mode),
            title: const Text("Dark Mode"),
            trailing: Switch(
              value: taskProvider.isDarkMode,
              onChanged: (value) {
                taskProvider.toggleTheme();
              },
            ),
              ),
          Divider(),
          ListTile(
            leading: const Icon(Icons.logout, color: Colors.deepOrange,),
            title: const Text('Log-Out'),
            onTap: () {
              iconLogoutBtn(context);
            },
          ),
          Divider(),
          ListTile(
            leading: const Icon(Icons.question_answer_rounded, color: Colors.deepOrange,),
            title: const Text("FAQ's"),
            onTap: () {},
          ),
          Divider()
        ],
      ),
    ),
  );

}