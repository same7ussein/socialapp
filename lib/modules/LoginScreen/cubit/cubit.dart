import 'package:facebook_clone/models/user_data_model.dart';
import 'package:facebook_clone/modules/LoginScreen/cubit/states.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginCubit extends Cubit<LoginScreenStates> {

  LoginCubit() : super(InitLoginState());

  UserModel ? loginmodel;
  static LoginCubit get(context) => BlocProvider.of(context);
  void userLogin({required String email, required String password}) {
    emit(LoginLoadingState());
    FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password)
        .then((value) {
      print(value.user!.uid.toString());
      emit(LoginSuccessState(value.user!.uid.toString()));
    }).catchError((error) {
      print(error.toString());
      emit(LoginErrorState(error.toString()));
    });
  }

  IconData suffix = Icons.remove_red_eye_outlined;
  bool isPassword = true;
  void changePasswordVisibilty() {
    isPassword = !isPassword;
    suffix = isPassword ? Icons.remove_red_eye_outlined : Icons.remove_red_eye;
    emit(LoginPasswordIconChange());
  }
}
