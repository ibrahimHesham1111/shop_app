import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:udemy_flutter_project/layout/social_app/social_layout.dart';
import 'package:udemy_flutter_project/modules/social_app/social_login/cubit/cubit.dart';
import 'package:udemy_flutter_project/modules/social_app/social_login/cubit/states.dart';
import 'package:udemy_flutter_project/modules/social_app/social_register/social_register_screen.dart';
import 'package:udemy_flutter_project/shared/components/components.dart';
import 'package:udemy_flutter_project/shared/networks/local/cache_helper.dart';

class SocialLoginScreen extends StatelessWidget {
  var emailController=TextEditingController();
  var passwordController=TextEditingController();
  var formKey=GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context)=>SocialLoginCubit(),
      child: BlocConsumer<SocialLoginCubit,SocialLoginStates>(
        listener: (context,state){
          if(state is SocialLoginErrorState)
          {
            showToast(text: state.error,
                state: ToastStates.ERROR
            );
          }
          if(state is SocialLoginSuccessState)
          {
            CacheHelper.saveData(
                key: 'uId',
                value: state.uId)
                .then((value){
              navigateAndFinish(context, SocialLayout());
          });
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
                        'LOGIN',
                        style: Theme.of(context).textTheme.headline4?.copyWith(
                            color: Colors.black
                        ),
                      ),
                      Text(
                        'login now to communicate with friends ',
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
                               SocialLoginCubit.get(context).userLogin(
                                email: emailController.text,
                                password: passwordController.text,
                              );
                            }
                          },
                          controller: passwordController,
                          type: TextInputType.visiblePassword,
                          label: 'Password',
                          prefix: Icons.lock_outline,
                          suffix: SocialLoginCubit.get(context).suffix,
                          isPassword:SocialLoginCubit.get(context).isPassword,
                          suffixPressed: (){
                            SocialLoginCubit.get(context).changePasswordVisibility();
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
                        condition: state is! SocialLoginLoadingState,
                        builder: (context) {
                          return  defaultButton(
                              function: (){
                                if(formKey.currentState!.validate()){
                                  SocialLoginCubit.get(context).userLogin(
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
                               navigateTo(context, SocialRegisterScreen());
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
