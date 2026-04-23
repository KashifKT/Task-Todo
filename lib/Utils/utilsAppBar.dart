import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/Screens/Form%20Pages/loginform.dart';
import '../Drawer/cusDrawer.dart';
//  for Login and Sign Up
AppBar formAppBar({required Widget title }){
  return AppBar(
    title: title,
    //leading: const Icon(Icons.menu),
    foregroundColor: Colors.white,
    backgroundColor: Colors.deepOrange,
    shadowColor: Colors.black,
    centerTitle: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(20),
          bottomRight: Radius.circular(20)),
    ),
  );
}


// for MyHomepage

AppBar appBarCus(BuildContext context, Widget title){
  return AppBar(
    leading: IconButton(
        onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context)=>cusDrawer(context)));
        },
        icon: Icon(Icons.menu)),
    title: title,
    automaticallyImplyLeading: true,
    foregroundColor: Colors.white,
    backgroundColor: Colors.deepOrange,
    shadowColor: Colors.black,
    centerTitle: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(20),
          bottomRight: Radius.circular(20)),
    ),
    //leadingWidth: ,
    //bottomOpacity: ,
    //toolbarHeight:  double.infinity,
    actions: [
      IconButton(
        icon: const Icon(Icons.search),
        onPressed: (){
          //Tap on SearchBtn
        },
      ),
      IconButton(
        icon: const Icon(Icons.logout),
        onPressed: (){
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginUI()),);

        },
      ),
    ],



    elevation: 10,

  );
}

