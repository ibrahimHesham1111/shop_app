
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:udemy_flutter_project/models/shop_app/login_model.dart';
import 'package:udemy_flutter_project/models/social_app/social_user_model.dart';
import 'package:udemy_flutter_project/modules/shop_app/cubit/states.dart';
import 'package:udemy_flutter_project/modules/shop_app/register/cubit/states.dart';
import 'package:udemy_flutter_project/modules/social_app/social_register/cubit/states.dart';
import 'package:udemy_flutter_project/shared/networks/end_point.dart';
import 'package:udemy_flutter_project/shared/networks/remote/dio_helper.dart';




class SocialRegisterCubit extends Cubit<SocialRegisterStates>
{
  SocialRegisterCubit():super(SocialRegisterInitialState());

  static SocialRegisterCubit get(context)=>BlocProvider.of(context);
  void userRegister({
    required String email,
    required String password,
    required String name,
    required String phone,
})
  {
  emit(SocialRegisterLoadingState());
 FirebaseAuth.instance
     .createUserWithEmailAndPassword(
     email: email,
     password: password
 ).then((value) {
   print(value.user!.email);
   print(value.user!.uid);
   createUsers(
     uId: value.user!.uid,
     name: name,
     phone:phone,
     email:email,
   );
emit(SocialRegisterSuccessState());
 }).catchError((error){
   emit(SocialRegisterErrorState(error.toString()));
 });
  }
  void createUsers({
    required String email,
    required String name,
    required String phone,
    required String uId,

  }){
    SocialUserModel model=SocialUserModel(
      name: name,
      email: email,
      phone: phone,
      uId: uId,
      cover: 'https://img.freepik.com/premium-photo/acai-bowl-brazilian-cuisine-popular-dish_168892-1861.jpg?size=626&ext=jpg',
      image: 'https://img.freepik.com/free-photo/waist-up-portrait-handsome-serious-unshaven-male-keeps-hands-together-dressed-dark-blue-shirt-has-talk-with-interlocutor-stands-against-white-wall-self-confident-man-freelancer_273609-16320.jpg?w=1060&t=st=1677852092~exp=1677852692~hmac=60de5c77e5f39d6bad74a3b060f398f8ee59f542446834a3da869a2eee28623b',
        bio: 'write your bio...',
        isEmailVerified:false,
    );
    FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .set(model.toMap())
        .then((value){
          emit(SocialCreateUserSuccessState());
    }).catchError((error){
      emit(SocialCreateUserErrorState(error.toString()));
    });
  }

  IconData suffix=Icons.visibility_outlined;
  bool isPassword=true;
  void changePasswordVisibility(){
    isPassword=!isPassword;
    suffix=isPassword?Icons.visibility_outlined:Icons.visibility_off_outlined;
    emit(SocialRegisterChangePasswordVisibility());
  }

}