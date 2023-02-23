import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:udemy_flutter_project/layout/shop_app/cubit/cubit.dart';
import 'package:udemy_flutter_project/layout/shop_app/cubit/states.dart';
import 'package:udemy_flutter_project/shared/components/components.dart';
import 'package:udemy_flutter_project/shared/components/constans.dart';

class SettingsScreen extends StatelessWidget {

var nameController=TextEditingController();

var emailController=TextEditingController();

var phoneController=TextEditingController();
var formKey=GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ShopStates>(
      listener: (context,state){
        if(state is ShopSuccessUserDataState){
          nameController.text=state.loginModel.data!.name!;
          emailController.text=state.loginModel.data!.email!;
          phoneController.text=state.loginModel.data!.phone!;
        }
      },
        builder: (context,state)
        {
          var model=ShopCubit.get(context).userModel;
          nameController.text=model.data!.name!;
          emailController.text=model.data!.email!;
          phoneController.text=model.data!.phone!;

          return SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: ConditionalBuilder(
              condition: ShopCubit.get(context).userModel != null,
              builder: (context) => Padding(
                padding: const EdgeInsets.all(20.0),
                child: Form(
                  key: formKey,
                  child: Column(
                    children: [
                      if(state is ShopLoadingUpdateUserState)
                        LinearProgressIndicator(),
                      SizedBox(
                        height: 20.0,
                      ),
                      defaultFormField(
                          controller: nameController,
                          type: TextInputType.name,
                          label: 'Name',
                          prefix: Icons.person,
                          validate: (value) {
                            if (value!.isEmpty) {
                              return 'Name must not be empty';
                            }
                            return null;
                          }),
                      SizedBox(
                        height: 20.0,
                      ),
                      defaultFormField(
                          controller: emailController,
                          type: TextInputType.emailAddress,
                          label: 'Email',
                          prefix: Icons.email,
                          validate: (value) {
                            if (value!.isEmpty) {
                              return 'Email must not be empty';
                            }
                            return null;
                          }),
                      SizedBox(
                        height: 20.0,
                      ),
                      defaultFormField(
                          controller: phoneController,
                          type: TextInputType.phone,
                          label: 'Phone',
                          prefix: Icons.phone,
                          validate: (value) {
                            if (value!.isEmpty) {
                              return 'Phone must not be empty';
                            }
                            return null;
                          }),
                      SizedBox(
                        height: 20.0,
                      ),
                      defaultButton(
                          function: (){
                            if(formKey.currentState!.validate()){
                              ShopCubit.get(context).updateUserData(
                                  name: nameController.text,
                                  email: emailController.text,
                                  phone: phoneController.text
                              );
                            }
                          },
                          text: 'update'),
                      SizedBox(
                        height: 20.0,
                      ),
                      defaultButton(
                          function: (){
                            signOut(context);
                          },
                          text: 'logout')
                    ],
                  ),
                ),
              ),
              fallback: (context) => Center(child: CircularProgressIndicator()),
            ),
          );
      },
    );
  }

}