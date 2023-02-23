import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:udemy_flutter_project/modules/shop_app/cubit/cubit.dart';
import 'package:udemy_flutter_project/modules/shop_app/cubit/states.dart';
import 'package:udemy_flutter_project/modules/shop_app/register/shop_register_screen.dart';
import 'package:udemy_flutter_project/layout/shop_app/shop_layout.dart';
import 'package:udemy_flutter_project/shared/components/components.dart';
import 'package:http/http.dart';
import 'package:udemy_flutter_project/shared/components/constans.dart';
import 'package:udemy_flutter_project/shared/networks/local/cache_helper.dart';

class ShopLoginscreen extends StatelessWidget {
var emailController=TextEditingController();
var passwordController=TextEditingController();
var formKey=GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ShopLoginCubit(),
      child: BlocConsumer<ShopLoginCubit,ShopLoginStates>(
        listener: (context, state) {
          if(state is ShopLoginSuccessState)
          {
            if(state.loginModel.status){
              print(state.loginModel.message);
              print(state.loginModel.data?.token);

             CacheHelper.saveData(key: 'token', value: state.loginModel.data?.token)
                 .then((value){
                   token=(state.loginModel.data?.token)!;
                   navigateAndFinish(context, ShopLayout());
             });
            }else
            {
              print(state.loginModel.message);
              showToast(
                text: state.loginModel.message!,
                state: ToastStates.ERROR
              );

            }
          }

        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(),
            body: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'LOGIN',
                          style: Theme.of(context).textTheme.headline4?.copyWith(
                              color: Colors.black
                          ),
                        ),
                        Text(
                          'login now to browse our offers',
                          style: Theme.of(context).textTheme.bodyText1?.copyWith(
                            color: Colors.grey,
                          ),
                        ),
                        SizedBox(
                          height: 30.0,
                        ),
                        defaultFormField(
                            controller: emailController,
                            type: TextInputType.emailAddress,
                            label: 'Email',
                            prefix: Icons.email_outlined,
                            validate: (value){
                              if(value!.isEmpty){
                                return 'Please enter your email address';
                              }
                            }
                        ),
                        SizedBox(
                          height: 15.0,
                        ),
                        defaultFormField(
                          onSubmit: (value){
                            if(formKey.currentState!.validate()){
                              ShopLoginCubit.get(context).userLogin(
                                email: emailController.text,
                                password: passwordController.text,
                              );
                            }
                          },
                            controller: passwordController,
                            type: TextInputType.visiblePassword,
                            label: 'Password',
                            prefix: Icons.lock_outline,
                            suffix: ShopLoginCubit.get(context).suffix,
                            isPassword:ShopLoginCubit.get(context).isPassword,
                            suffixPressed: (){
                              ShopLoginCubit.get(context).changePasswordVisibility();
                            },
                            validate: (value){
                              if(value!.isEmpty){
                                return 'Password is too short';
                              }
                            }
                        ),
                        SizedBox(
                          height: 30.0,
                        ),

                        ConditionalBuilder(
                          condition: state is! ShopLoginLoadingState,
                          builder: (context) {
                            return  defaultButton(
                                function: (){
                                  if(formKey.currentState!.validate()){
                                    ShopLoginCubit.get(context).userLogin(
                                      email: emailController.text,
                                      password: passwordController.text,
                                    );
                                  }
                                },
                                text: 'login'
                            );
                          },
                          fallback: (context) =>Center(child: CircularProgressIndicator()),
                        ),

                        Row(mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Don\'t have an account?',
                            ),
                            defaultTextButton(
                              function: (){
                                navigateTo(context, ShopRegisterScreen());
                              },
                              text: 'register',
                            )
                          ],
                        ),
                      ],
                    ),
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
