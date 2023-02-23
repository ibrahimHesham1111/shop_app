import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:udemy_flutter_project/models/shop_app/login_model.dart';
import 'package:udemy_flutter_project/modules/shop_app/cubit/states.dart';
import 'package:udemy_flutter_project/modules/shop_app/register/cubit/states.dart';
import 'package:udemy_flutter_project/shared/networks/end_point.dart';
import 'package:udemy_flutter_project/shared/networks/remote/dio_helper.dart';




class ShopRegisterCubit extends Cubit<ShopRegisterStates>
{
  ShopRegisterCubit():super(ShopRegisterInitialState());

  static ShopRegisterCubit get(context)=>BlocProvider.of(context);
 late ShopLoginModel loginModel;
  void userRegister({
    required String email,
    required String password,
    required String name,
    required String phone,
})
  {
  emit(ShopRegisterLoadingState());
  DioHelper.postData(
      url: REGISTER,
      data:{
        'name':name,
        'email':email,
        'password':password,
        'phone':phone,
      }
  ).then((value){
    print(value.data);
    loginModel=  ShopLoginModel.fromJson(value.data);
    print(loginModel.status);
    print(loginModel.message);
    print(loginModel.data?.token);

    emit(ShopRegisterSuccessState(loginModel));
  }).catchError((error){
    print(error.toString());
    emit(ShopRegisterErrorState(error.toString()));
  });
  }

  IconData suffix=Icons.visibility_outlined;
  bool isPassword=true;
  void changePasswordVisibility(){
    isPassword=!isPassword;
    suffix=isPassword?Icons.visibility_outlined:Icons.visibility_off_outlined;
    emit(ShopRegisterChangePasswordVisibility());
  }

}