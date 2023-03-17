import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:udemy_flutter_project/layout/social_app/social_layout.dart';

import 'package:udemy_flutter_project/modules/shop_app/register/cubit/cubit.dart';
import 'package:udemy_flutter_project/modules/shop_app/register/cubit/states.dart';
import 'package:udemy_flutter_project/modules/social_app/social_register/cubit/cubit.dart';
import 'package:udemy_flutter_project/modules/social_app/social_register/cubit/states.dart';
import 'package:udemy_flutter_project/shared/components/components.dart';


class SocialRegisterScreen extends StatelessWidget {
  var formKey=GlobalKey<FormState>();
  var emailController=TextEditingController();
  var nameController=TextEditingController();
  var phoneController=TextEditingController();
  var passwordController=TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => SocialRegisterCubit(),
      child: BlocConsumer<SocialRegisterCubit,SocialRegisterStates>(
        listener: (context,state) {
          if(state is SocialCreateUserSuccessState)
          {
            navigateAndFinish(context, SocialLayout());
          }

        },
        builder:(context,state){
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
                          'Register',
                          style: Theme.of(context).textTheme.headline4?.copyWith(
                              color: Colors.black
                          ),
                        ),
                        Text(
                          'register now to communicate with friends',
                          style: Theme.of(context).textTheme.bodyText1?.copyWith(
                            color: Colors.grey,
                          ),
                        ),
                        SizedBox(
                          height: 30.0,
                        ),
                        defaultFormField(
                            controller: nameController,
                            type: TextInputType.name,
                            label: 'Name',
                            prefix: Icons.person,
                            validate: (value){
                              if(value!.isEmpty){
                                return 'Please enter your User name';
                              }
                            }
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

                            },
                            controller: passwordController,
                            type: TextInputType.visiblePassword,
                            label: 'Password',
                            prefix: Icons.lock_outline,
                            suffix: SocialRegisterCubit.get(context).suffix,
                            isPassword:SocialRegisterCubit.get(context).isPassword,
                            suffixPressed: (){
                              SocialRegisterCubit.get(context).changePasswordVisibility();
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
                        defaultFormField(
                            controller: phoneController,
                            type: TextInputType.phone,
                            label: 'phone',
                            prefix: Icons.phone,
                            validate: (value){
                              if(value!.isEmpty){
                                return 'Please enter your phone number';
                              }
                            }
                        ),
                        SizedBox(
                          height: 30.0,
                        ),

                        ConditionalBuilder(
                          condition: state is! ShopRegisterLoadingState,
                          builder: (context) {
                            return  defaultButton(
                              function: (){
                                if(formKey.currentState!.validate()){
                                  SocialRegisterCubit.get(context).userRegister(
                                  name: nameController.text,
                                    email: emailController.text,
                                    password: passwordController.text,
                                    phone: phoneController.text,
                                  );
                                }
                              },
                              text: 'register',
                              isUppercase: true,


                            );
                          },
                          fallback: (context) =>Center(child: CircularProgressIndicator()),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        } ,
      ),
    );
  }
}
