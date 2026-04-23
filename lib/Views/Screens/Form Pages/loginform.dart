import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


import '../../../Controls/authservice.dart';
import '../../../Controls/task_provider.dart';
import '../../../Utils/utilsAppBar.dart';
import '../../../Utils/utilsForm.dart';

class LoginUI extends StatefulWidget {
  const LoginUI({super.key});

  @override
  State<LoginUI> createState() => _LoginUIState();
}

class _LoginUIState extends State<LoginUI> {
  final TextEditingController _emailCon=TextEditingController();
  final TextEditingController _pasCon=TextEditingController();
  @override
  Widget build(BuildContext context) {
    var obsecureTxt= Provider.of<TaskProvider>(context, listen: true).obsecurePassword;
    return SafeArea(
      child: Scaffold(
          appBar: formAppBar(title: Text("Login")),
          body :Center(
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: formCard(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      formHeadText("LOGIN PLEASE "),
                      SizedBox(height: 30,),
                      formLabelText("Enter E-mail"),
                      formTxtFld(false, context,_emailCon, TextInputType.emailAddress, preSufIcon(icon: Icons.mail,),),
                      SizedBox(height: 20,),
                      formLabelText("Enter Password"),
                      formTxtFld(obsecureTxt, context, _pasCon, TextInputType.visiblePassword, preSufIcon(icon: Icons.lock),suffixIcon: IconButton(
                        icon: Provider.of<TaskProvider>(context).obsecurePassword? preSufIcon(icon: Icons.visibility): preSufIcon(icon: Icons.visibility_off),
                        onPressed: (){ Provider.of<TaskProvider>(context,listen: false).obsecurepass();},)),
                      SizedBox(height: 20,),
                      richTextLog(context),
                      SizedBox(height: 20,),
                      formBtn(onPressed: (){
                        AuthService().registerUser(_emailCon.text, _pasCon.text);
                        _emailCon.clear();
                        _pasCon.clear();
                      }, data: "Register"),
                      formBtn(onPressed: (){
                        AuthService().loginUser(context, _emailCon.text, _pasCon.text);
                        _emailCon.clear();
                        _pasCon.clear();

                      }, data: "Login")

                    ],
                  ),
                ),
              ),
            ),
          )
      ),
    );
  }
}
