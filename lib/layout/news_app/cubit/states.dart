abstract class NewsStates{}
class NewsInitialStates extends NewsStates{}
class NewsBottomNavStates extends NewsStates{}
class NewsGetBusinessLoadingStates extends NewsStates{}
class NewsGetBusinessSuccessState extends NewsStates {}
class NewsGetBusinessErrorState extends NewsStates {
   final String error;

  NewsGetBusinessErrorState(this.error);
}

class NewsGetSportsLoadingStates extends NewsStates{}
class NewsGetSportsSuccessState extends NewsStates {}
class NewsGetSportsErrorState extends NewsStates {
  final String error;

  NewsGetSportsErrorState(this.error);
}

class NewsGetScienceLoadingStates extends NewsStates{}
class NewsGetScienceSuccessState extends NewsStates {}
class NewsGetScienceErrorState extends NewsStates {
  final String error;

  NewsGetScienceErrorState(this.error);
}


class NewsGetSearchLoadingStates extends NewsStates{}
class NewsGetSearchSuccessState extends NewsStates {}
class NewsGetSearchErrorState extends NewsStates {
  final String error;

  NewsGetSearchErrorState(this.error);
}