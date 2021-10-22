import 'package:facebook_clone/modules/LoginScreen/login_screen.dart';
import 'package:facebook_clone/modules/resetpassword/show_reset_message.dart';
import 'package:facebook_clone/shared/components/components.dart';
import 'package:facebook_clone/shared/styles/icon_broken.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ResetPassword extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final emailController=TextEditingController();
    final formKey=GlobalKey<FormState>();
    return Scaffold(
      appBar:AppBar(
        leading: IconButton(
          onPressed: (){
            navigateAndFinish(context,LoginScreen());
          },
          icon: Icon(Icons.arrow_back_ios_outlined),
        ),
      ) ,
      body: Container(
        color: Colors.white,
        child: Form(
          key: formKey,
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  alignment: AlignmentDirectional.center,
                  child: Text('Reset Password',style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold
                  ),),
                ),
                SizedBox(
                  height: 50,
                ),
                defaultFormField(
                    controller: emailController,
                    type: TextInputType.emailAddress,
                    validate:(String ? value){
                      if(value!.isEmpty)
                        {
                          return 'email address must not be empty';
                        }
                       }
                    ,
                    label: 'Email Address',
                    prefix: Icons.email_outlined
                ),
                SizedBox(
                  height: 30,
                ),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.pink,
                    borderRadius: BorderRadius.circular(30)
                  ),
                  child: MaterialButton(onPressed:(){
                    if(formKey.currentState!.validate())
                      {
                         FirebaseAuth.instance.sendPasswordResetEmail(email: emailController.text);
                         navigateAndFinish(context,ShowMessage());

                      }
                  },
                    child:Text('Reset Password',style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 30,
                    ),) ,),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
