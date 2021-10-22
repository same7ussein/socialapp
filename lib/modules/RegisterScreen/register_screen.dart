import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:facebook_clone/layout/socialLayout.dart';
import 'package:facebook_clone/modules/LoginScreen/login_screen.dart';
import 'package:facebook_clone/shared/Network/local/sharedPreferences.dart';
import 'package:facebook_clone/shared/components/components.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'cubit/cubit.dart';
import 'cubit/states.dart';
class SignUpScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var formKey=GlobalKey<FormState>();
    final emailController=TextEditingController();
    final passwordController=TextEditingController();
    final GoogleSignIn _googleSignIn=GoogleSignIn(scopes:['email'] );
    return BlocProvider(
      create: (context) => RegisterCubit(),
      child: BlocConsumer<RegisterCubit,RegisterScreenStates>(
        listener: (context, state) {
          if (state is RegisterSuccessState) {
            CacheHelper.saveData(key: 'uId', value: state.uId);
            navigateAndFinish(context, HomeScreen());
          }
        },
        builder: (context,state){
          var cubit=RegisterCubit.get(context);
          return Scaffold(
            body: Container(
              constraints: BoxConstraints(
                maxHeight: MediaQuery.of(context).size.height,
                maxWidth: MediaQuery.of(context).size.width,
              ),
              color: Colors.cyan,
              child: Form(
                key: formKey,
                child: SingleChildScrollView(

                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                          height:80
                      ),
                      Text('Welcome',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize:30.0,
                            color: Colors.white
                        ),),
                      SizedBox(
                        height: 20.0,
                      ),
                      Text('Create Account to Communicate with Friends',
                        style: TextStyle(color: Colors.white,
                            fontSize: 20
                        ),),
                      SizedBox(
                        height: 40,
                      ),
                      Container(
                        constraints: BoxConstraints(
                          maxHeight: MediaQuery.of(context).size.height,
                          maxWidth: MediaQuery.of(context).size.width,
                        ),
                        decoration: BoxDecoration(
                            color: Colors.white70,
                            borderRadius: BorderRadius.only(
                                topLeft:Radius.circular(50),
                                topRight:Radius.circular(50)
                            )
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              defaultFormField(
                                controller: emailController,
                                type: TextInputType.emailAddress,
                                validate: (String ?value) {
                                  if (value!.isEmpty) {
                                    return 'Email Address must not be empty';
                                  }
                                },
                                label:'Email Address',
                                prefix:Icons.email_outlined,
                              ),
                              SizedBox(height: 15,),
                              defaultFormField(
                                  controller: passwordController,
                                  type: TextInputType.visiblePassword,
                                  validate: (String ? value) {
                                    if (value!.isEmpty) {
                                      return 'Password is to short';
                                    }
                                  },
                                  label:'Password',
                                  prefix:Icons.lock,
                                  suffix:cubit.suffix,
                                  isPassword:cubit.isPassword,
                                  suffixpressed: (){
                                    cubit.changePasswordVisibilty();
                                  }
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              ConditionalBuilder(
                                condition:state is! RegisterLoadingState,
                                builder:(context)=> defaultButton(function:(){
                                  if(formKey.currentState!.validate())
                                  {
                                    cubit.postRegister(
                                        email: emailController.text,
                                        password: passwordController.text,);
                                  }

                                }, text:'SignUp'),
                                fallback:(context)=>Center(child: CircularProgressIndicator()) ,
                              ),
                              SizedBox(
                                height:30,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                      'Already have an account'
                                  ),
                                  TextButton(onPressed: (){
                                    navigateAndFinish(context,LoginScreen());
                                  }, child:Text('Sign In'))
                                ],
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    child: Container(
                                      height: 1,
                                      width: double.infinity,
                                      color: Colors.grey,
                                    ),
                                  ),
                                  Text('OR'),
                                  Expanded(

                                    child: Container(
                                      height: 1,
                                      width: double.infinity,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Container(
                                  alignment: Alignment.center,
                                  child: Text(' Login Using Social Media')),
                              SizedBox(
                                height: 20,
                              ),

                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  IconButton(icon:
                                  Icon(FontAwesomeIcons.facebookF,
                                    color: Colors.orangeAccent[700],),
                                      onPressed: () { }),
                                  IconButton(icon:
                                  Icon(FontAwesomeIcons.twitter,
                                    color: Colors.orangeAccent[700],),
                                    onPressed: () {  },),
                                  IconButton(icon:
                                  Icon(FontAwesomeIcons.google,
                                    color: Colors.orangeAccent[700],),
                                    onPressed: () async{
                                      await _googleSignIn.signIn();
                                      Navigator.pushReplacement(
                                          context, MaterialPageRoute(builder: (context) => HomeScreen()));
                                    },),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

}
