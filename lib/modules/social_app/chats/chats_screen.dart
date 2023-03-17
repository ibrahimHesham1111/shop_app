


import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:udemy_flutter_project/layout/social_app/cubit/cubit.dart';
import 'package:udemy_flutter_project/layout/social_app/cubit/states.dart';
import 'package:udemy_flutter_project/models/social_app/social_user_model.dart';
import 'package:udemy_flutter_project/modules/social_app/chat_details/chat_details_screen.dart';
import 'package:udemy_flutter_project/shared/components/components.dart';
import 'package:udemy_flutter_project/shared/styles/colors.dart';

class ChatsScreen extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit,SocialStates>(
      listener: (context,state){},
      builder: (context,state){
        return ConditionalBuilder(
          condition: SocialCubit.get(context).users.length>0,
          builder:(context)=> ListView.separated(
            physics: BouncingScrollPhysics(),
              itemBuilder: (context,index)=>buildChatItem(SocialCubit.get(context).users[index],context),
              separatorBuilder: (context,index)=>myDivider(),
              itemCount: SocialCubit.get(context).users.length
          ),
          fallback: (context)=>Center(child: CircularProgressIndicator()),
        );
      },

    );
  }

  Widget buildChatItem(SocialUserModel model,context)=>InkWell(
    onTap: ()
    {
      navigateTo(context, ChatDetailsScreen(userModel: model));
    },
    child: Padding(
      padding: const EdgeInsets.all(20.0),
      child: Row(
        children: [
          SizedBox(
            width: 3.0,
          ),
          CircleAvatar(
            radius: 25.0,
            backgroundImage: NetworkImage(
                '${model.image}'
            ),
          ),
          SizedBox(
            width: 10.0,
          ),

          Text(
            '${model.name}',
            style: TextStyle(
              height: 1.4,
            ),
          ),

        ],
      ),
    ),
  );
}
