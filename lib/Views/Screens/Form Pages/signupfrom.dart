import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../Controls/task_provider.dart';
import '../../../Utils/utilsAppBar.dart';
import '../../../Utils/utilsForm.dart';
import 'loginform.dart';

class SignUp extends StatelessWidget {
  const SignUp({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController _fNameCon=TextEditingController();
    final TextEditingController _lNameCon=TextEditingController();
    final TextEditingController _phNumCon=TextEditingController();
    final TextEditingController _emailCont=TextEditingController();
    final TextEditingController _passCont=TextEditingController();
    final TextEditingController _cpassCont=TextEditingController();

    var obsecureTxt= Provider.of<TaskProvider>(context, listen: true).obsecurePassword;

    return SafeArea(
      child: Scaffold(
          appBar: formAppBar(title: Text("Sign-Up")) ,
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
                      formHeadText("SIGN-UP PLEASE "),
                      SizedBox(height: 30,),
                      formLabelText("First Name"),
                      formTxtFld(false, context,_fNameCon, TextInputType.name, preSufIcon(icon: CupertinoIcons.profile_circled,),),
                      SizedBox(height: 20,),
                      formLabelText("Last Name"),
                      formTxtFld(false, context,_lNameCon, TextInputType.name, preSufIcon(icon: CupertinoIcons.profile_circled,),),
                      SizedBox(height: 20,),
                      formLabelText("Phone Number"),
                      formTxtFld(false, context,_phNumCon, TextInputType.number, preSufIcon(icon: CupertinoIcons.number_circle,),),
                      SizedBox(height: 20,),
                      formLabelText("Enter E-mail"),
                      formTxtFld(false, context,_emailCont, TextInputType.emailAddress, preSufIcon(icon: Icons.mail,),),
                      SizedBox(height: 20,),
                      formLabelText("Enter Password"),
                      formTxtFld(obsecureTxt, context, _passCont, TextInputType.visiblePassword, preSufIcon(icon: Icons.lock),suffixIcon: IconButton(
                        icon: Provider.of<TaskProvider>(context).obsecurePassword? preSufIcon(icon: Icons.visibility): preSufIcon(icon: Icons.visibility_off),
                        onPressed: (){ Provider.of<TaskProvider>(context,listen: false).obsecurepass();},)),
                      SizedBox(height: 20,),
                      formLabelText("Confirm Password"),
                      formTxtFld(obsecureTxt, context, _cpassCont, TextInputType.visiblePassword, preSufIcon(icon: Icons.lock),suffixIcon: IconButton(
                        icon: Provider.of<TaskProvider>(context).obsecurePassword? preSufIcon(icon: Icons.visibility): preSufIcon(icon: Icons.visibility_off),
                        onPressed: (){ Provider.of<TaskProvider>(context,listen: false).obsecurepass();},)),
                      SizedBox(height: 20,),
                      richTextSign(context),
                      SizedBox(height: 20,),
                      formBtn(onPressed: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginUI()));
                      }, data: "SignUp")

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