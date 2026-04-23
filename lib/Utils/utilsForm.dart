import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';


import '../Views/Screens/Form Pages/loginform.dart';
import '../Views/Screens/Form Pages/signupfrom.dart';

// Registration Form Utils

// Form Card

Widget formCard({required Widget child}){

  return IntrinsicWidth(
    stepWidth: 80,
    child: Card(
      child: child,
      color: Colors.white,
      borderOnForeground: true,
      shadowColor: Colors.black,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        //side: BorderSide()
      ),
      elevation: 10,
      margin: EdgeInsets.all(20),
      surfaceTintColor:Colors.white,
      //semanticContainer: ,
    ),
  );
}
// Form Label Text
Widget formHeadText(String data){
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Center(child: Text(data, style:TextStyle(fontSize: 20,fontStyle: FontStyle.italic,fontWeight: FontWeight.w500, color: Colors.deepOrange),textAlign: TextAlign.center , )),
  );

}
Widget formLabelText(String data){
  return Padding(
    padding:  EdgeInsets.all(8.0),
    child: Text(data, style:TextStyle(fontSize: 20,fontWeight: FontWeight.w300),),
  );
}


// Form Text Fields

Widget formTxtFld(bool obsecureText, BuildContext context, TextEditingController controller, TextInputType keyboardType, Widget prefixIcon,
    {Widget? suffixIcon, }){
  return Theme(
    data: Theme.of(context).copyWith(
      textSelectionTheme: const TextSelectionThemeData(
        cursorColor: Colors.deepOrange,              // blinking cursor color
        selectionColor: Colors.orangeAccent,  // highlight color when text is selected
        selectionHandleColor: Colors.deepOrange,   // the handles (drag dots)
      ),
    ),
    child: TextField(

      dragStartBehavior: DragStartBehavior.start,
      //toolbarOptions: ToolbarOptions(),
      enableSuggestions: true,
      controller: controller,
      keyboardType: keyboardType,
      cursorErrorColor: Colors.red,
      obscureText: obsecureText,
      decoration: InputDecoration(
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(11),
            borderSide: const BorderSide(
                color: Colors.deepOrange,
                width: 2
            )
        ),
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,

      ),
    ),
  );
}


Widget preSufIcon({required IconData icon}){
  return Icon(icon, color: Colors.deepOrange,);
}
// RichText for account Confrimation

Widget richTextLog(BuildContext context){
  return Center(
    child: RichText(
        text: TextSpan(
            style: TextStyle(color: Colors.black),
            text: " Don't have an account? " ,
            children:[
              TextSpan(
                  text: "SignUp",
                  style: TextStyle(color: Colors.deepOrange,decoration: TextDecoration.underline, fontWeight: FontWeight.bold),
                  recognizer: TapGestureRecognizer()
                    ..onTap =() {
                      Navigator.push(context, MaterialPageRoute(builder: (context)=> SignUp()));
                    }
              )
            ]
        )),
  );
}


Widget richTextSign(BuildContext context){
  return Center(
    child: RichText(
        text: TextSpan(
            style: TextStyle(color: Colors.black),
            text: " Already have an account? " ,
            children:[
              TextSpan(
                  text: "Login",
                  style: TextStyle(color: Colors.deepOrange,decoration: TextDecoration.underline, fontWeight: FontWeight.bold),
                  recognizer: TapGestureRecognizer()
                    ..onTap =() {
                      Navigator.push(context, MaterialPageRoute(builder: (context)=> LoginUI()));
                    }
              )
            ]
        )),
  );
}
// Login and Register Button
Widget formBtn({required VoidCallback onPressed, required String data}) {
  return Center(
    child: ElevatedButton(
      style: ButtonStyle(
        animationDuration: Duration(seconds: 3), // duration of animation
        elevation: MaterialStateProperty.all(10), // shadow/elevation
        backgroundColor: MaterialStateProperty.all(Colors.deepOrange), // button color
        //padding: MaterialStateProperty.all(
        //EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        //),
        textStyle: MaterialStateProperty.all(
          TextStyle(fontSize: 15, fontWeight: FontWeight.w500, color: Colors.black),
        ),
      ),
      onPressed: onPressed,
      child: Text(data, style: TextStyle(color: Colors.white),),
    ),
  );
}
