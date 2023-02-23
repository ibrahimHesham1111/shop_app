import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:udemy_flutter_project/layout/news_app/cubit/cubit.dart';
import 'package:udemy_flutter_project/layout/news_app/cubit/states.dart';
import 'package:udemy_flutter_project/shared/components/components.dart';
import 'package:udemy_flutter_project/shared/cubit/cubit.dart';
import 'package:udemy_flutter_project/shared/networks/remote/dio_helper.dart';

import '../../modules/news_app/search/search_screen.dart';

class NewsLayout extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit,NewsStates>(
      listener: (context,state){},
      builder: (context,state){
        var cubit= NewsCubit.get(context);
        return  Scaffold(
          appBar: AppBar(
            title: Text(
                'News App'
            ),
             actions: [
               IconButton(
                 icon: Icon(
                   Icons.search,
                 ),
                 onPressed: (){
                   navigateTo(context,SearchScreen());
                 },
               ),
               IconButton(
                 icon: Icon(
                   Icons.brightness_4_outlined,
                 ),
                 onPressed: (){
           AppCubit.get(context).changeAppMode();
                 },
               ),
             ],


          ),
          body: cubit.screen[cubit.currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            items:cubit.BottomItems,
            currentIndex: cubit.currentIndex,
            onTap: (index){
              cubit.changeBottomNavBar(index);
            },
          ),
        );
      },

    );
  }
}
