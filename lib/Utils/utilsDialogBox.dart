/*
import 'dart:ffi';
*/

import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


//Dialog Text Fields
Widget dialogtxtFld(BuildContext context ,TextEditingController controller, String? hintText ){
  return Theme(
    data: Theme.of(context).copyWith(
      textSelectionTheme: const TextSelectionThemeData(
        cursorColor: Colors.deepOrange,              // blinking cursor color
        selectionColor: Colors.orangeAccent,  // highlight color when text is selected
        selectionHandleColor: Colors.deepOrange,   // the handles (drag dots)
      ),),
    child: TextField(
      controller: controller,
      decoration: InputDecoration(
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        hintText: hintText,
      ),
    ),
  );
}
// Dialog for Elevated Buttons
ElevatedButton dialogBtn(void Function()? onPressed, String data ){
  return ElevatedButton(
      onPressed: onPressed,
      child: Text(data,style: TextStyle(color: Colors.deepOrange), ));
}
//Dialog Text for Cancel Button
Widget txtBtn(String data,){
  return Text(data, style: TextStyle(color: Colors.black),);
}
Widget dialogTitle(String data,){
  return Text(data, style: TextStyle(color: Colors.deepOrange),);
}

