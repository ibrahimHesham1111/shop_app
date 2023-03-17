import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:udemy_flutter_project/layout/social_app/cubit/cubit.dart';
import 'package:udemy_flutter_project/layout/social_app/cubit/states.dart';
import 'package:udemy_flutter_project/shared/components/components.dart';
import 'package:udemy_flutter_project/shared/styles/icon_broken.dart';

class NewPostScreen extends StatelessWidget {

var textController=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit,SocialStates>(
      listener: (context,state){},
      builder: (context,state){
        return Scaffold(
          appBar:PreferredSize(
            preferredSize: Size.fromHeight(60.0),
            child: defaultAppBar(
              context: context,
              title: 'Create Post',
              actions: [
                defaultTextButton(
                    function: ()
                    {
                      var now=DateTime.now();
                      if(SocialCubit.get(context).postImage==null)
                      {
                        SocialCubit.get(context).createPost(
                            text: textController.text,
                            dateTime: now.toString()
                        );
                      }else
                      {
                        SocialCubit.get(context).uploadPostImage(
                            text: textController.text,
                            dateTime: now.toString()
                        );
                      }
                    },
                    text: 'post'
                ),
              ],
            ),
          ),
          body:Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                if(state is SocialCreatePostLoadingState)
                  LinearProgressIndicator(),
                if(state is SocialCreatePostLoadingState)
                  SizedBox(
                  height: 10.0,
                ),
                Row(
                  children: [
                    CircleAvatar(
                      radius: 25.0,
                      backgroundImage: NetworkImage('https://img.freepik.com/free-photo/smiley-little-boy-isolated-pink_23-2148984798.jpg?w=1060&t=st=1677620869~exp=1677621469~hmac=0c27ff1f8139b2f24a10ef6fd961e20e779336688937b2263a19b8adea7bcbe3'),
                    ),
                    SizedBox(
                      width: 15.0,
                    ),
                    Expanded(
                      child: Text(
                        'Zein Ibrahim',
                        style: TextStyle(
                          height: 1.4,
                        ),
                      ),
                    ),
                  ],
                ),
                Expanded(
                  child: TextFormField(
                    controller: textController,
                    decoration: InputDecoration(
                        hintText: 'what is on your mind...',
                        border: InputBorder.none
                    ),
                  ),
                ),
                if(SocialCubit.get(context).postImage!=null)
                Container(
                  height: 350.0,
                  child: Stack(
                    alignment: AlignmentDirectional.bottomCenter,
                    children: [
                      Align(
                        alignment: AlignmentDirectional.topCenter,
                        child: Stack(
                          alignment: AlignmentDirectional.topEnd,
                          children: [
                            Container(
                              height: 280.0,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(4.0),
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(4.0),
                                child: Image(
                                  image:FileImage(SocialCubit.get(context).postImage!)as ImageProvider,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            IconButton(
                                onPressed: ()
                                {
                                 SocialCubit.get(context).removePostImage();
                                },
                                icon: CircleAvatar(
                                  radius: 25.0,
                                  child: Icon(
                                    Icons.close,
                                    size: 16.0,
                                  ),
                                )
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: TextButton(
                          onPressed: ()
                          {
                            SocialCubit.get(context).getPostImage();
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                IconBroken.Image,
                              ),
                              SizedBox(
                                width: 5.0,
                              ),
                              Text(
                                'Add Photo',
                              ),
                            ],
                          ),
                      ),
                    ),
                    Expanded(
                      child: TextButton(
                        onPressed: (){},
                        child: Text(
                          '# tags',
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
