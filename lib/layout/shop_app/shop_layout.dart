import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:udemy_flutter_project/layout/shop_app/cubit/cubit.dart';
import 'package:udemy_flutter_project/layout/shop_app/cubit/states.dart';
import 'package:udemy_flutter_project/modules/shop_app/login/shop_login_screen.dart';
import 'package:udemy_flutter_project/modules/shop_app/search/search_screen.dart';
import 'package:udemy_flutter_project/shared/components/components.dart';

import '../../shared/networks/local/cache_helper.dart';

class ShopLayout extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ShopStates>(
      listener: (context,state){},
      builder: (context,state){
        var cubit=ShopCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: Text(
                'salla'
            ),
            actions: [
              IconButton(
                  onPressed: (){
                    navigateTo(context, SearchScreen());
                  }, icon: Icon(
                Icons.search,
              ))
            ],
          ),
          body: cubit.bottomScreens[cubit.currentIndex],
          bottomNavigationBar:BottomNavigationBar(
            onTap:(index){
              cubit.changeBottomNav(index);
            },
            currentIndex:cubit.currentIndex,
            items: [
              BottomNavigationBarItem(
                icon:Icon(
              Icons.home,
          ),
                label: 'Home',
                ),
              BottomNavigationBarItem(
                icon:Icon(
                  Icons.apps,
                ),
                label: 'Categories',
              ),
              BottomNavigationBarItem(
                icon:Icon(
                  Icons.favorite,
                ),
                label: 'Favorites',
              ),
              BottomNavigationBarItem(
                icon:Icon(
                  Icons.settings,
                ),
                label: 'Settings',
              ),

            ],
          ),

        );
      },
    );
  }
}
