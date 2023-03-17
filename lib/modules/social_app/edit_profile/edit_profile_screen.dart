import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:udemy_flutter_project/layout/social_app/cubit/cubit.dart';
import 'package:udemy_flutter_project/layout/social_app/cubit/states.dart';
import 'package:udemy_flutter_project/modules/social_app/settings/settings_screen.dart';
import 'package:udemy_flutter_project/shared/components/components.dart';
import 'package:udemy_flutter_project/shared/styles/icon_broken.dart';

class EditProfileScreen extends StatelessWidget {
  var nameController=TextEditingController();
  var phoneController=TextEditingController();
  var bioController=TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit,SocialStates>(
      listener: (context,state){},
      builder: (context,state){
        var userModel=SocialCubit.get(context).userModel;
        var profileImage=SocialCubit.get(context).profileImage;
        var coverImage=SocialCubit.get(context).coverImage;
        nameController.text=userModel!.name!;
        bioController.text=userModel!.bio!;
        phoneController.text=userModel!.phone!;

        return Scaffold(
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(60.0),
            child: defaultAppBar(
              context: context,
              title: 'Edit Profile',
              actions: [
                defaultTextButton(
                  function: ()
                  {
                    SocialCubit.get(context).updateUser(
                      name: nameController.text,
                      bio: bioController.text,
                      phone: phoneController.text,
                    );
                  },
                  text: 'update',
                ),
                SizedBox(
                  width: 10.0,
                ),
              ],
            ),
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  if(state is SocialUserUpdateLoadingState)
                    LinearProgressIndicator(),
                  if(state is SocialUserUpdateLoadingState)
                  SizedBox(
                    height: 10.0,
                  ),
                  Container(
                    height: 215.0,
                    child: Stack(
                      alignment: AlignmentDirectional.bottomCenter,
                      children: [
                        Align(
                          alignment: AlignmentDirectional.topCenter,
                          child: Stack(
                            alignment: AlignmentDirectional.topEnd,
                            children: [
                              Container(
                                height: 160.0,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(4.0),
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.vertical(top: Radius.circular(4.0)),
                                  child: Image(
                                    image:coverImage==null? NetworkImage(
                                        '${userModel!.cover}'
                                    ):FileImage(coverImage)as ImageProvider,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              IconButton(
                                  onPressed: ()
                                  {
                                    SocialCubit.get(context).getCoverImage();
                                  },
                                  icon: CircleAvatar(
                                    radius: 25.0,
                                    child: Icon(
                                      IconBroken.Camera,
                                      size: 16.0,
                                    ),
                                  )
                              ),
                            ],
                          ),
                        ),
                        Stack(
                          alignment: AlignmentDirectional.bottomEnd,
                          children: [
                            CircleAvatar(
                              radius: 70.0,
                              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                              child: CircleAvatar(
                                radius: 65.0,
                                backgroundImage:profileImage==null? NetworkImage(
                                  '${userModel!.image}',
                                ): FileImage(profileImage) as ImageProvider,
                              ),
                            ),
                            IconButton(
                                onPressed: (){
                                  SocialCubit.get(context).getProfileImage();
                                },
                                icon: CircleAvatar(
                                  radius: 25.0,
                                  child: Icon(
                                    IconBroken.Camera,
                                    size: 16.0,
                                  ),
                                )
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  if(SocialCubit.get(context).profileImage!=null||SocialCubit.get(context).coverImage!=null)
                    Row(
                    children: [
                      if(SocialCubit.get(context).profileImage!=null)
                      Expanded(
                        child: Column(
                          children: [
                            defaultButton(
                                function: (){
                                  SocialCubit.get(context).uploadProfileImage(name: nameController.text,
                                      phone: phoneController.text,
                                      bio: bioController.text
                                  );
                                },
                                text: 'upload profile'
                            ),
                            if(state is SocialUserUpdateLoadingState)
                            SizedBox(
                              height: 5.0,
                            ),
                            if(state is SocialUserUpdateLoadingState)
                            LinearProgressIndicator(),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: 5.0,
                      ),
                      if(SocialCubit.get(context).coverImage!=null)
                      Expanded(
                        child: Column(
                          children: [
                            defaultButton(
                                function: (){
                                  SocialCubit.get(context).uploadCoverImage(
                                      name: nameController.text,
                                    phone: phoneController.text,
                                    bio: bioController.text
                                );
                                  },
                                text: 'upload cover'
                            ),
                            if(state is SocialUserUpdateLoadingState)
                            SizedBox(
                              height: 5.0,
                            ),
                            if(state is SocialUserUpdateLoadingState)
                            LinearProgressIndicator(),
                          ],
                        ),
                      ),
                    ],
                  ),
                  if(SocialCubit.get(context).profileImage!=null||SocialCubit.get(context).coverImage!=null)
                    SizedBox(
                    height: 12.0,
                  ),
                  defaultFormField(
                      controller: nameController,
                      type: TextInputType.name,
                      label: 'Name',
                      prefix: IconBroken.User,
                      validate: (value){
                    if(value!.isEmpty)
                    {
                      return 'Name must not be empty';
                    }
                    return null;
                      }
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  defaultFormField(controller: bioController,
                      type: TextInputType.text,
                      label: 'Bio',
                      prefix: IconBroken.Info_Circle,
                      validate: (value){
                        if(value!.isEmpty)
                        {
                          return 'Bio must not be empty';
                        }
                        return null;
                      }
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  defaultFormField(controller: phoneController,
                      type: TextInputType.phone,
                      label: 'Phone Number',
                      prefix: IconBroken.Call,
                      validate: (value){
                        if(value!.isEmpty)
                        {
                          return 'Phone Number must not be empty';
                        }
                        return null;
                      }
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
