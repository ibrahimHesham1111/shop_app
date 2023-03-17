import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:udemy_flutter_project/layout/social_app/cubit/cubit.dart';
import 'package:udemy_flutter_project/layout/social_app/cubit/states.dart';
import 'package:udemy_flutter_project/models/social_app/post_model.dart';
import 'package:udemy_flutter_project/shared/styles/colors.dart';
import 'package:udemy_flutter_project/shared/styles/icon_broken.dart';

class FeedsScreen extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit,SocialStates>(
      listener: (context,state){},
      builder: (context,state){
        return SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            children: [
              Card(
                clipBehavior: Clip.antiAliasWithSaveLayer,
                margin: EdgeInsets.all(8.0,),
                elevation: 10.0,
                child: Stack(
                  alignment: AlignmentDirectional.bottomStart,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.vertical(top: Radius.circular(4.0)),
                      child: Image(
                        image: NetworkImage('https://img.freepik.com/free-photo/smiley-little-boy-isolated-yellow_23-2148984804.jpg?t=st=1677618340~exp=1677618940~hmac=2bd0381ed8d2361ebb541500dfc7f1f4bf867e4e0cdd6066d1e1fe1acafdebb2'),
                        fit: BoxFit.cover,
                        height: 200.0,
                        width: double.infinity,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Cummunicate with friends',
                        style:Theme.of(context).textTheme.subtitle1!,
                      ),
                    ),
                  ],
                ),
              ),
              ListView.separated(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder:(context, index) => buildPostItem(SocialCubit.get(context).posts[index],context, index),
                separatorBuilder: (context,index)=>SizedBox(
                  height: 10.0,
                ),
                itemCount: SocialCubit.get(context).posts.length,
              ),


              SizedBox(
                height: 20.0,
              ),



            ],
          ),
        );
      },
    );
  }


  Widget buildPostItem(PostModel model,context,index)=>Card(
    clipBehavior: Clip.antiAliasWithSaveLayer,
    elevation: 10.0,
    margin: EdgeInsets.symmetric(
        horizontal: 8.0
    ),
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              SizedBox(
                width: 3.0,
              ),
              CircleAvatar(
                radius: 25.0,
                backgroundImage: NetworkImage(
                    '${model.image}'),
              ),
              SizedBox(
                width: 15.0,
              ),
              Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            '${model.name}',
                            style: TextStyle(
                              height: 1.4,
                            ),
                          ),
                          SizedBox(
                            width: 5.0,
                          ),
                          Icon(
                            Icons.check_circle,
                            color: defaultColor,
                            size: 16.0,
                          ),
                        ],
                      ),
                      Text(
                          '${model.dateTime}',
                          style: Theme.of(context).textTheme.caption!.copyWith(
                            height: 1.4,
                          )
                      ),

                    ],
                  )
              ),
              SizedBox(
                width: 15.0,
              ),
              IconButton(onPressed: (){},
                  icon: Icon(
                    Icons.more_horiz,
                    size: 16.0,
                  ))
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
                vertical: 15.0
            ),
            child: Container(
              width: double.infinity,
              height: 1.0,
              color: Colors.grey[300],
            ),
          ),
          Text(
            '${model.text}',
            style: Theme.of(context).textTheme.subtitle1,
            maxLines: 5,
            overflow: TextOverflow.ellipsis,

          ),
          // Padding(
          //   padding: const EdgeInsets.only(
          //       bottom: 10.0,
          //       top: 5.0
          //   ),
          //   child: Container(
          //     width: double.infinity,
          //     child: Wrap(
          //       children: [
          //         Padding(
          //           padding: const EdgeInsetsDirectional.only(
          //               end: 6.0
          //           ),
          //           child: Container(
          //             height: 25.0,
          //             child: MaterialButton(
          //               onPressed: (){},
          //               minWidth: 1.0,
          //               padding: EdgeInsets.zero,
          //               child:Text(
          //                   '#software',
          //                   style: Theme.of(context).textTheme.caption!.copyWith(
          //                       color: defaultColor
          //                   )
          //               ),
          //
          //             ),
          //           ),
          //         ),
          //         Padding(
          //           padding: const EdgeInsetsDirectional.only(
          //               end: 6.0
          //           ),
          //           child: Container(
          //             height: 25.0,
          //             child: MaterialButton(
          //               onPressed: (){},
          //               minWidth: 1.0,
          //               padding: EdgeInsets.zero,
          //               child:Text(
          //                   '#flutter',
          //                   style: Theme.of(context).textTheme.caption!.copyWith(
          //                       color: defaultColor
          //                   )
          //               ),
          //
          //             ),
          //           ),
          //         ),
          //       ],
          //     ),
          //   ),
          // ),
          if(model.postImage !='')
          Padding(
            padding: const EdgeInsetsDirectional.only(
              top: 15.0
            ),
            child: Container(
              height: 350.0,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5.0),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.vertical(top: Radius.circular(4.0),bottom: Radius.circular(4.0)),
                child: Image(
                  image: NetworkImage(
                      '${model.postImage}'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
                vertical: 5.0
            ),
            child: Row(
              children: [
                Expanded(
                  child: InkWell(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 5.0
                      ),
                      child: Row(
                        children: [
                          Icon(
                            IconBroken.Heart,
                            size: 16.0,
                            color: Colors.red,
                          ),
                          Text(
                            '0',
                            style: Theme.of(context).textTheme.caption,
                          ),
                        ],
                      ),
                    ),
                    onTap: (){},
                  ),
                ),
                Expanded(
                  child: InkWell(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 5.0
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Icon(
                            IconBroken.Chat,
                            size: 16.0,
                            color: Colors.amber,
                          ),
                          Text(
                            '0 Comment',
                            style: Theme.of(context).textTheme.caption,
                          ),
                        ],
                      ),
                    ),
                    onTap: (){},
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              bottom: 10.0,
            ),
            child: Container(
              width: double.infinity,
              height: 1.0,
              color: Colors.grey[300],
            ),
          ),
          Row(
            children: [
              Expanded(
                child: InkWell(
                  child: Row(
                    children: [
                      SizedBox(
                        width: 3.0,
                      ),
                      CircleAvatar(
                        radius: 18.0,
                        backgroundImage: NetworkImage(
                            '${SocialCubit.get(context).userModel!.image}'),
                      ),
                      SizedBox(
                        width: 15.0,
                      ),
                      Text(
                          'write a comment...',
                          style: Theme.of(context).textTheme.caption!.copyWith(
                          )
                      ),
                    ],
                  ),
                  onTap: (){
                    //SocialCubit.get(context).commentPost(SocialCubit.get(context).postId[index]);
                  },
                ),
              ),
              InkWell(
                child: Row(
                  children: [
                    Icon(
                      IconBroken.Heart,
                      size: 16.0,
                      color: Colors.red,
                    ),
                    Text(
                      'Like',
                      style: Theme.of(context).textTheme.caption,
                    ),
                  ],
                ),
                onTap: ()
                {
                 // SocialCubit.get(context).likePost(SocialCubit.get(context).postId[index]);
                },
              ),
            ],
          )

        ],
      ),
    ),

  );
}
