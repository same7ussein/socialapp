import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:facebook_clone/layout/cubit/states.dart';
import 'package:facebook_clone/models/user_data_model.dart';
import 'package:facebook_clone/shared/Network/local/sharedPreferences.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SocialCubit extends Cubit<SocialStates>{
  SocialCubit(): super(SocialInitialState());
static SocialCubit get(context)=>BlocProvider.of(context);

 late UserModel model;
 void getUserData(){
   emit(SocialGetUserLoadingState());
   FirebaseFirestore.instance
       .collection('users')
       .doc(CacheHelper.getData(key: 'uId'))
       .get()
       .then((value){
         print(value.data());
         model=UserModel.fromJson(value.data());
         emit(SocialGetUserSuccessState());
   })
       .catchError((error){
         print(error.toString());
    emit(SocialGetUserErrorState(error.toString()));
   });
 }

}

