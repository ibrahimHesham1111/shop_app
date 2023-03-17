import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:udemy_flutter_project/layout/social_app/cubit/states.dart';
import 'package:udemy_flutter_project/models/social_app/message_model.dart';
import 'package:udemy_flutter_project/models/social_app/post_model.dart';
import 'package:udemy_flutter_project/models/social_app/social_user_model.dart';
import 'package:udemy_flutter_project/models/user/user.dart';
import 'package:udemy_flutter_project/modules/social_app/chats/chats_screen.dart';
import 'package:udemy_flutter_project/modules/social_app/feeds/feeds_screen.dart';
import 'package:udemy_flutter_project/modules/social_app/new_post/new_post_screen.dart';
import 'package:udemy_flutter_project/modules/social_app/settings/settings_screen.dart';
import 'package:udemy_flutter_project/modules/social_app/users/users_screen.dart';
import 'package:udemy_flutter_project/shared/components/constans.dart';
import 'package:firebase_storage/firebase_storage.dart'as firebase_storage;

class SocialCubit extends Cubit<SocialStates>
{
  SocialCubit():super(SocialInitialState());
 static SocialCubit get(context)=>BlocProvider.of(context);


 SocialUserModel? userModel;


 void getUserData()
 {
  emit(SocialGetUserLoadingState());
  FirebaseFirestore.instance
      .collection('users')
      .doc(uId)
      .get()
      .then((value){
   print(value.data());
   userModel=SocialUserModel.fromJson(value.data());
   emit(SocialGetUserSuccessState());
  }).catchError((error){
   print(error.toString());
   emit(SocialGetUserErrorState(error.toString()));
  });

 }


 int currentIndex=0;
 List<Widget>screens=[
  FeedsScreen(),
  ChatsScreen(),
  NewPostScreen(),
  UsersScreen(),
  SettingsScreen(),
 ];

  List<String>titles=[
   'Home',
   'Chats',
   'Post',
   'users',
   'Settings',
  ];

 void ChangeBottomNav(int index)
 {
   if(index==1)
     getUsers();
  if(index==2)
      emit(SocialNewPostState());
     else{
  currentIndex=index;
  emit(SocialChangeBottomNavState());
  }
 }

  File? profileImage;
 var picker =ImagePicker();
 Future<void>getProfileImage()async
 {
  final pickerFile=await picker.getImage(
      source: ImageSource.gallery,
  );
  if(pickerFile != null){
   profileImage=File(pickerFile.path);
   emit(SocialProfileImagePickerSuccessState());
  }else
  {
   print('No Image Selected');
   emit(SocialProfileImagePickerErrorState());
  }
 }

  File? coverImage;
  Future<void>getCoverImage()async
  {
   final pickerFile=await picker.getImage(
    source: ImageSource.gallery,
   );
   if(pickerFile != null){
    coverImage=File(pickerFile.path);
    emit(SocialCoverPickerSuccessState());
   }else
   {
    print('No Image Selected');
    emit(SocialCoverPickerErrorState());
   }
  }

  void uploadProfileImage({
   required String name,
   required String phone,
   required String bio,
}) {
   emit(SocialUserUpdateLoadingState());
   firebase_storage.FirebaseStorage.instance
       .ref()
       .child('users/${Uri.file(profileImage!.path).pathSegments.last}')
       .putFile(profileImage!)
       .then((value) {
    value.ref.getDownloadURL().then((value) {
     print(value);
     updateUser(
      name: name,
      bio: bio,
      phone: phone,
       image: value
     );
    }).catchError((error) {
     emit(SocialUploadProfileImageErrorState());
    });
   }).catchError((error) {
    emit(SocialUploadProfileImageErrorState());

   });
  }


  void uploadCoverImage({
   required String name,
   required String phone,
   required String bio,
}) {
emit(SocialUserUpdateLoadingState());
   firebase_storage.FirebaseStorage.instance
       .ref()
       .child('users/${Uri.file(coverImage!.path).pathSegments.last}')
       .putFile(coverImage!)
       .then((value) {
    value.ref.getDownloadURL().then((value) {
     print(value);
     updateUser(name: name,
         phone: phone,
         bio: bio,
      cover: value,
     );

    }).catchError((error) {
     emit(SocialUploadCoverImageErrorState());
    });
   }).catchError((error) {
    emit(SocialUploadCoverImageErrorState());

   });
  }





  File? postImage;
  Future<void>getPostImage()async
  {
   final pickerFile=await picker.getImage(
    source: ImageSource.gallery,
   );
   if(pickerFile != null){
    postImage=File(pickerFile.path);
    emit(SocialCreatePostSuccessState());
   }else
   {
    print('No Image Selected');
    emit(SocialCreatePostErrorState());
   }
  }

  void removePostImage()
  {
   postImage=null;
   emit(SocialRemovePostImageState());
}


  void uploadPostImage({
   required String text,
   required String dateTime,

  }) {
   emit(SocialCreatePostLoadingState());
   firebase_storage.FirebaseStorage.instance
       .ref()
       .child('posts/${Uri.file(postImage!.path).pathSegments.last}')
       .putFile(postImage!)
       .then((value) {
    value.ref.getDownloadURL().then((value) {
     print(value);
     createPost(
      text: text,
      dateTime: dateTime,
      postImage: value
     );


    }).catchError((error) {
     emit(SocialCreatePostErrorState());
    });
   }).catchError((error) {
    emit(SocialCreatePostErrorState());

   });
  }


  void createPost({
   required String text,
   required String dateTime,
   String? postImage,

  }){
   emit(SocialCreatePostLoadingState());
   PostModel model=PostModel(
    name:userModel!.name,
    image: userModel!.image,
    uId: userModel!.uId,
     dateTime: dateTime,
    text: text,
    postImage: postImage??'',
   );
   FirebaseFirestore.instance.collection('posts')
       .add(model.toMap())
       .then((value)
   {
    emit(SocialCreatePostSuccessState());
   })
       .catchError((error){
    emit(SocialUserUpdateErrorState());
   });
  }


//   void updateUserImage({
//    required String name,
//    required String phone,
//    required String bio,
//
// })
//   {
//    emit(SocialUserUpdateLoadingState());
//    if(coverImage !=null)
//    {
//     uploadCoverImage();
//    }else if(profileImage !=null)
//    {
//     uploadProfileImage();
//    }else if(coverImage !=null && profileImage !=null)
//    {
//
//    }
//    else{
//     updateUser(
//      name: name,
//      phone: phone,
//      bio: bio,
//     );
//    }
//
//   }
  void updateUser({
   required String name,
   required String phone,
   required String bio,
   String? cover,
   String? image,

  }){
   SocialUserModel model=SocialUserModel(
    name: name,
    phone: phone,
    bio: bio,
    image:image?? userModel!.image,
    uId: userModel!.uId,
    cover:cover?? userModel!.cover,
    email: userModel!.email,
    isEmailVerified:false,
   );
   FirebaseFirestore.instance.collection('users')
       .doc(userModel!.uId)
       .update(model.toMap())
       .then((value)
   {
    getUserData();
   })
       .catchError((error){
    emit(SocialUserUpdateErrorState());
   });
  }

  List<PostModel>posts=[];
  List<String>postId=[];
  List<int>likes=[];
  List<int>comments=[];

  void getPosts()
  {
   emit(SocialGetPostsLoadingState());
   FirebaseFirestore.instance
       .collection('posts')
       .get()
       .then((value){
        value.docs.forEach((element) {

          // element.reference.collection('comments').get()
          //     .then((value)
          // {
          //   comments.add(value.docs.length);
          //   postId.add(element.id);
          //   posts.add(PostModel.fromJson(element.data()));
          // }).catchError(onError);

          // element.reference
          // .collection('likes')
          // .get()
          // .then((value) {
          //   likes.add(value.docs.length);
          //   postId.add(element.id);
          //   posts.add(PostModel.fromJson(element.data()));
          // }).catchError(onError);
          // postId.add(element.id);
          posts.add(PostModel.fromJson(element.data()));
        });
        emit(SocialGetPostsSuccessState());
   })
       .catchError((error){
        emit(SocialGetPostsErrorState(error.toString()));
   });
  }



 late List<SocialUserModel>users;
  void getUsers()
  {
    emit(SocialGetAllUserLoadingState());
    users=[];
      FirebaseFirestore.instance
          .collection('users')
          .snapshots()
      .listen((event) {
        event.docs.forEach((element) {
          if(element.data()['uId']!=userModel!.uId)
            users.add(SocialUserModel.fromJson(element.data()));
        });
        emit(SocialGetAllUserSuccessState());
      });



      emit(SocialGetAllUserErrorState());

  }




  void likePost(String postId)
  {
   FirebaseFirestore.instance
       .collection('posts')
       .doc(postId)
       .collection('likes')
       .doc(userModel!.uId)
       .set({
    'like':true
   }).then((value) {
     emit(SocialLikePostSuccessState());

   }).catchError((error){
emit(SocialLikePostErrorState(error.toString()));
   });
  }


  void commentPost(String postId)
  {
    FirebaseFirestore.instance
        .collection('posts')
        .doc(postId)
        .collection('comments')
        .doc(userModel!.uId)
        .set({
      'comment':true
    }).then((value) {
      emit(SocialCommentPostSuccessState());

    }).catchError((error){
      emit(SocialCommentPostErrorState(error.toString()));
    });
  }



  void sendMessage({
    required String receiverId,
    required String dateTime,
    required String text,
}){
    MessageModel model=MessageModel(
      senderId: userModel!.uId,
      receiverId:receiverId,
      dateTime:dateTime,
      text: text
    );
    FirebaseFirestore.instance
    .collection('users')
    .doc( userModel!.uId)
    .collection('chats')
    .doc(receiverId)
    .collection('messages')
    .add(model.toMap())
        .then((value)
    {
      emit(SocialSendMessageSuccessState());
    })
        .catchError((error)
    {
      emit(SocialSendMessageErrorState());
    }
    );

    FirebaseFirestore.instance
        .collection('users')
        .doc( receiverId)
        .collection('chats')
        .doc(userModel!.uId)
        .collection('messages')
        .add(model.toMap())
        .then((value)
    {
      emit(SocialSendMessageSuccessState());
    })
        .catchError((error)
    {
      emit(SocialSendMessageErrorState());
    }
    );

  }


  List<MessageModel>messages=[];

  void getMessages({
    required String receiverId
})
{
  FirebaseFirestore.instance
      .collection('users')
      .doc(userModel!.uId)
      .collection('chats')
      .doc(receiverId)
      .collection('messages')
      .orderBy('dateTime')
      .snapshots()
      .listen((event) {
        messages=[];
        event.docs.forEach((element) {
          messages.add(MessageModel.fromJson(element.data()));
        });
        emit(SocialGetMessagesSuccessState());
  });

}


}