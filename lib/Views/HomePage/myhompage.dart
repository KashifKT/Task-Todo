import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../Utils/utilsAppBar.dart';
import '../Drawer/cusDrawer.dart';
import '../Screens/DialogBox/dialogscreen.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(

        drawer: cusDrawer(context),
        body: DialogScreen(),
      ),
    );
  }
}