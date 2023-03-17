abstract class SocialStates{}

class SocialInitialState extends SocialStates{}
class SocialGetUserLoadingState extends SocialStates{}
class SocialGetUserSuccessState extends SocialStates{}

class SocialGetUserErrorState extends SocialStates{
  final String error;

  SocialGetUserErrorState(this.error);
}


class SocialGetAllUserLoadingState extends SocialStates{}
class SocialGetAllUserSuccessState extends SocialStates{}

class SocialGetAllUserErrorState extends SocialStates{

}



class SocialGetPostsLoadingState extends SocialStates{}
class SocialGetPostsSuccessState extends SocialStates{}

class SocialGetPostsErrorState extends SocialStates{
  final String error;

  SocialGetPostsErrorState(this.error);
}


class SocialChangeBottomNavState extends SocialStates{}

class SocialNewPostState extends SocialStates{}

class SocialProfileImagePickerSuccessState extends SocialStates{}

class SocialProfileImagePickerErrorState extends SocialStates{}

class SocialCoverPickerSuccessState extends SocialStates{}

class SocialCoverPickerErrorState extends SocialStates{}

class SocialUploadProfileImageSuccessState extends SocialStates{}

class SocialUploadProfileImageErrorState extends SocialStates{}

class SocialUploadCoverImageSuccessState extends SocialStates{}

class SocialUploadCoverImageErrorState extends SocialStates{}

class SocialUserUpdateLoadingState extends SocialStates{}

class SocialUserUpdateErrorState extends SocialStates{}

//create Post
class SocialCreatePostLoadingState extends SocialStates{}

class SocialCreatePostSuccessState extends SocialStates{}

class SocialCreatePostErrorState extends SocialStates{}

class SocialPostImagePickerSuccessState extends SocialStates{}

class SocialPostImagePickerErrorState extends SocialStates{}

class SocialRemovePostImageState extends SocialStates{}


class SocialLikePostSuccessState extends SocialStates{}
class SocialLikePostErrorState extends SocialStates{
  final String error;

  SocialLikePostErrorState(this.error);
}
class SocialCommentPostLoadingState extends SocialStates{}
class SocialCommentPostSuccessState extends SocialStates{}
class SocialCommentPostErrorState extends SocialStates{
  final String error;

  SocialCommentPostErrorState(this.error);
}

class SocialSendMessageSuccessState extends SocialStates{}
class SocialSendMessageErrorState extends SocialStates{}

class SocialGetMessagesSuccessState extends SocialStates{}
class SocialGetMessagesErrorState extends SocialStates{}




// class SocialGetCommentPostLoadingState extends SocialStates{}
// class SocialGetCommentPostSuccessState extends SocialStates{}
// class SocialGetCommentPostErrorState extends SocialStates{
//   final String error;
//
//   SocialGetCommentPostErrorState(this.error);
// }
//
// class SocialGetLikePostLoadingState extends SocialStates{}
// class SocialGetLikePostSuccessState extends SocialStates{}
// class SocialGetLikePostErrorState extends SocialStates {
//   final String error;
//
//   SocialGetLikePostErrorState(this.error);
// }


