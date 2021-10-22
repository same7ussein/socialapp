import 'package:facebook_clone/modules/LoginScreen/login_screen.dart';
import 'package:facebook_clone/shared/components/components.dart';
import 'package:flutter/material.dart';

class ShowMessage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Text('Check Your Mail '),
      actions: [
        TextButton(onPressed: (){
          navigateAndFinish(context,LoginScreen());
        }, child: Text('OK')),

      ],
    );
  }
}
