
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:facebook_clone/layout/socialLayout.dart';
import 'package:facebook_clone/modules/RegisterScreen/register_screen.dart';
import 'package:facebook_clone/modules/resetpassword/reset_password.dart';
import 'package:facebook_clone/provider/auth_provider.dart';
import 'package:facebook_clone/shared/Network/local/sharedPreferences.dart';
import 'package:facebook_clone/shared/components/components.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'cubit/cubit.dart';
import 'cubit/states.dart';
class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var formKey=GlobalKey<FormState>();
    final emailController=TextEditingController();
    final passwordController=TextEditingController();
    return BlocProvider(
      create: (BuildContext context)=>LoginCubit(),
      child: BlocConsumer<LoginCubit,LoginScreenStates>(
        listener: (BuildContext context, state) {
          if (state is LoginErrorState) {
            showToast(
              text: state.error,
              state: ToastStates.ERROR,
            );
          }
          if (state is LoginSuccessState) {
            CacheHelper.saveData(
                key: 'uId',
                value: state.uId
            );
            print( state.uId);
            navigateAndFinish(context, HomeScreen());

          }

        },
        builder: ( context, state)
        {
          var cubit = LoginCubit.get(context);
          return Scaffold(
            body: Container(
              constraints: BoxConstraints(
                maxHeight: MediaQuery.of(context).size.height,
                maxWidth: MediaQuery.of(context).size.width,
              ),
              color: Colors.cyan,
              child: Form(
                key: formKey,
                child:SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                          height:80
                      ),
                      Text('Login',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize:30.0,
                            color: Colors.white
                        ),),
                      SizedBox(
                        height: 20.0,
                      ),
                      Text('Please Login to Your Account',
                        style: TextStyle(color: Colors.white,
                            fontSize: 20
                        ),),
                      SizedBox(
                        height: 30,
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
                                validate: (String ? value) {
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
                              TextButton(onPressed:(){
                                navigateTo(context,ResetPassword());
                              } , child:Text('Forget Password ?'),),
                              ConditionalBuilder(
                                condition: state is! LoginLoadingState,
                                builder: (context)=>defaultButton(function:(){
                                  if(formKey.currentState!.validate())
                                  {
                                    cubit.userLogin(
                                        email: emailController.text,
                                        password: passwordController.text);
                                  }}, text:'Login',isUpperCase: true,),
                                fallback: (context)=>Center(child: CircularProgressIndicator()),
                              ),
                              SizedBox(
                                height:30,
                              ),
                              Container(
                                  alignment: Alignment.center,
                                  child: Text('OR Login Using Social Media')),
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
                                  Icon(FontAwesomeIcons.google,
                                    color: Colors.orangeAccent[700],),
                                    onPressed: () {
                                      AuthClass()
                                          .signWithGoogle()
                                          .then((UserCredential value) {
                                        final displayName = value.user!
                                            .displayName;

                                        print(displayName);

                                        Navigator.pushAndRemoveUntil(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    HomeScreen()),
                                                (route) => false);
                                      },);
                                    }
                                  )
                                ],
                              ),
                              SizedBox(
                                height: 30,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                      'Don\'t have an account'
                                  ),
                                  TextButton(onPressed: (){
                                    navigateTo(context,SignUpScreen());
                                  }, child:Text('Sign Up'))
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
