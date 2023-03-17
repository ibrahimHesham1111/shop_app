import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:udemy_flutter_project/layout/social_app/cubit/cubit.dart';
import 'package:udemy_flutter_project/layout/social_app/cubit/states.dart';
import 'package:udemy_flutter_project/modules/social_app/new_post/new_post_screen.dart';
import 'package:udemy_flutter_project/shared/components/components.dart';
import 'package:udemy_flutter_project/shared/components/constans.dart';
import 'package:udemy_flutter_project/shared/styles/icon_broken.dart';

class SocialLayout extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit,SocialStates>(
      listener: (context,state){
        if(state is SocialNewPostState)
          {
            navigateTo(context, NewPostScreen());
          }
      },
      builder: (context,state){
        var cubit=SocialCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: Text(
              cubit.titles[cubit.currentIndex],
            ),
            actions: [
              IconButton(
                  onPressed: (){},
                  icon: Icon(
                    IconBroken.Notification,
                  )
              ),
              IconButton(
                  onPressed: (){},
                  icon: Icon(
                    IconBroken.Search,
                  )
              ),
              IconButton(
                  onPressed: ()
                  {
                    signOut(context);
                  },
                  icon: Icon(
                    IconBroken.Close_Square,
                  )
              ),


            ],
          ),
          body:cubit.screens[cubit.currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: cubit.currentIndex,
            onTap: (index)
            {
              cubit.ChangeBottomNav(index);
            },
            items: [
              BottomNavigationBarItem(
                icon: Icon(
                  IconBroken.Home,
                ),
                label: 'Home'
              ),
              BottomNavigationBarItem(
                  icon: Icon(
                    IconBroken.Chat,
                  ),
                  label: 'Chats'
              ),
              BottomNavigationBarItem(
                  icon: Icon(
                    IconBroken.Paper_Upload,
                  ),
                  label: 'Post'
              ),
              BottomNavigationBarItem(
                  icon: Icon(
                    IconBroken.Location,
                  ),
                  label: 'Users'
              ),
              BottomNavigationBarItem(
                  icon: Icon(
                    IconBroken.Setting,
                  ),
                  label: 'Settings'
              ),

            ],
          ),
        );
      },

    );
  }
}
