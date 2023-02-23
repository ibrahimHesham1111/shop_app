

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:udemy_flutter_project/layout/news_app/cubit/states.dart';


import '../../../modules/news_app/business/business_screen.dart';
import '../../../modules/news_app/science/science_screen.dart';
import '../../../modules/news_app/sports/sports_screen.dart';
import '../../../shared/networks/remote/dio_helper.dart';

class NewsCubit extends Cubit<NewsStates>
{
  NewsCubit():super(NewsInitialStates());
  static NewsCubit get(context)=>BlocProvider.of(context);

  int currentIndex=0;
List<BottomNavigationBarItem>BottomItems=[
  BottomNavigationBarItem(
    icon: Icon(
      Icons.business,
    ),
    label: 'Business',
  ),
  BottomNavigationBarItem(
    icon: Icon(
      Icons.sports,
    ),
    label: 'Sports',
  ),
  BottomNavigationBarItem(
    icon: Icon(
      Icons.science,
    ),
    label: 'Science',
  ),
];

void changeBottomNavBar(int index){
  currentIndex=index;
  if(index==1)
    getSports();
  if(index==2)
    getScience();
  emit(NewsBottomNavStates());
}

List<Widget>screen=[
  BusinessScreen(),
  SportsScreen(),
  ScienceScreen(),

];
List<dynamic>business=[];

void getBusiness(){
  emit(NewsGetBusinessLoadingStates());
  DioHelper.getData(url: 'v2/top-headlines', query: {
    'country':'eg',
    'category':'business',
    'apiKey':'3017419961774b65aa9fb26a9bb6e368',
  }).then((value) {
    business=value.data['articles'];
    print(business[0]['title']);
    emit(NewsGetBusinessSuccessState());
  }).catchError((error){
    print(error.toString());
    emit(NewsGetBusinessErrorState(error.toString()));
  });
}

  List<dynamic>sports=[];

  void getSports(){
    emit(NewsGetSportsLoadingStates());
    if(sports.length==0){
      DioHelper.getData(url: 'v2/top-headlines', query: {
        'country':'eg',
        'category':'sports',
        'apiKey':'3017419961774b65aa9fb26a9bb6e368',
      }).then((value) {
        sports=value.data['articles'];
        print(sports[0]['title']);
        emit(NewsGetSportsSuccessState());
      }).catchError((error){
        print(error.toString());
        emit(NewsGetSportsErrorState(error.toString()));
      });
    }else{
      emit(NewsGetSportsSuccessState());
    }

  }

  List<dynamic>science=[];

  void getScience(){
    emit(NewsGetScienceLoadingStates());
    if(science.length==0){
      DioHelper.getData(url: 'v2/top-headlines', query: {
        'country':'eg',
        'category':'science',
        'apiKey':'3017419961774b65aa9fb26a9bb6e368',
      }).then((value) {
        science=value.data['articles'];
        print(science[0]['title']);
        emit(NewsGetScienceSuccessState());
      }).catchError((error){
        print(error.toString());
        emit(NewsGetScienceErrorState(error.toString()));
      });
    }else{
      emit(NewsGetScienceSuccessState());
    }

  }



  List<dynamic>search=[];

  void getSearch(value){
    emit(NewsGetSearchLoadingStates());
    DioHelper.getData(
        url: 'v2/everything',
        query: {
          'q':'$value',
      'apiKey':'3017419961774b65aa9fb26a9bb6e368',
    }).then((value) {
      search=value.data['articles'];
      print(search[0]['title']);
      emit(NewsGetSearchSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(NewsGetSearchErrorState(error.toString()));
      });

}
}