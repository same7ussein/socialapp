import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
const defaultColor = Colors.cyan;

Widget defaultButton(
    {
      double width = double.infinity,
      Color background = Colors.blue,
      required  String text,
      required Function function,
      double radius=30.0,
      bool isUpperCase = true,
    }
    ) =>Container(
  width:width,
  height: 50.0,
  child: MaterialButton(
    onPressed:(){
      function();
    },
    child:Text(
      isUpperCase ? text.toUpperCase() : text,
      style: TextStyle(
        color: Colors.white,
      ),
    ),
  ),
  decoration: BoxDecoration(
    borderRadius: BorderRadius.circular(
      radius,
    ),
    color:defaultColor ,
  ),
);
Widget defaultTextButton(
    {
      required Function function,
      required String text,
    }
    )=>TextButton(onPressed:(){
  function();
},
    child:Text(text.toUpperCase())
);
Widget defaultFormField(
    {
      required  TextEditingController controller,
      required  TextInputType type,
      onSubmitt,
      onChange,
      onTap,
      bool isclickable= true,
      bool isPassword=false,
      required validate,
      required label,
      required prefix,
      suffix,
      suffixpressed,

    }
    )=>TextFormField(
  keyboardType:type,
  controller: controller,
  onFieldSubmitted: onSubmitt,
  obscureText: isPassword,
  onChanged: onChange
  ,validator:validate,
  onTap: onTap,
  enabled: isclickable,
  decoration: InputDecoration(
    labelText:label,
    prefixIcon: Icon(
      prefix,
    ),
    suffixIcon: suffix!=null?IconButton(
        onPressed: suffixpressed ,
        icon: Icon(suffix)):null,
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(50)
    ),
  ),
);
void navigateAndFinish(context,widget)=> Navigator.pushAndRemoveUntil(
    context,
    MaterialPageRoute(
      builder: (context) => widget,
    ),
        (Route<dynamic> route)=>false
);
void navigateTo(context,widget)=> Navigator.push(
  context,
  MaterialPageRoute(
    builder: (context) => widget,
  ),
);
void showToast({
   required String text,
   required ToastStates state,
}) {
  Fluttertoast.showToast(
      msg: text,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 5,
      backgroundColor: chooseToastColor(state),
      textColor: Colors.white,
      fontSize: 16.0);
}

enum ToastStates { SUCCESS, ERROR, WARNING }

Color chooseToastColor(ToastStates state) {
  Color color;

  switch (state)
  {
    case ToastStates.SUCCESS:
      color = Colors.green;
      break;
    case ToastStates.WARNING:
      color = Colors.amber;
      break;
    case ToastStates.ERROR:
      color = Colors.red;
      break;
  }
  return color;
}
