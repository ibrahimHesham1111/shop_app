
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:udemy_flutter_project/layout/news_app/cubit/cubit.dart';
import 'package:udemy_flutter_project/layout/shop_app/cubit/cubit.dart';
import 'package:udemy_flutter_project/layout/todo_app/todo_layout.dart';
import 'package:udemy_flutter_project/modules/shop_app/login/shop_login_screen.dart';
import 'package:udemy_flutter_project/modules/shop_app/on_boardind/on_boarding_screen.dart';
import 'package:udemy_flutter_project/layout/shop_app/shop_layout.dart';
import 'package:udemy_flutter_project/shared/bloc_observer.dart';
import 'package:udemy_flutter_project/shared/components/constans.dart';
import 'package:udemy_flutter_project/shared/cubit/cubit.dart';
import 'package:udemy_flutter_project/shared/cubit/states.dart';
import 'package:udemy_flutter_project/shared/networks/local/cache_helper.dart';
import 'package:udemy_flutter_project/shared/networks/remote/dio_helper.dart';
import 'package:udemy_flutter_project/shared/styles/colors.dart';
import 'package:udemy_flutter_project/shared/styles/themes.dart';

import 'layout/news_app/news_layout.dart';


void main()async
{
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  DioHelper.init();
  await CacheHelper.init();
bool? isDark=CacheHelper.getData(key: 'isDark',);
Widget widget;
  bool? onBoarding=CacheHelper.getData(key: 'onBoarding',);
  token=CacheHelper.getData(key: 'token',);
  print(token);

  if(onBoarding !=null)
  {
    if(token !=null) widget=ShopLayout();
    else widget=ShopLoginscreen();
  }else{
    widget=OnBoardingScreen();
  }

  print(onBoarding);
  runApp(MyApp(
    isDark: isDark!,
    startWidget: widget,
  ));
}

class MyApp extends StatelessWidget
{
    bool isDark;
  final Widget startWidget;
  MyApp({
    required this.isDark,
    required this.startWidget
  });




  // constructor
  // build

  @override
  Widget build(BuildContext context)
  {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (BuildContext context) => ShopCubit()..getHomeData()..getCategories()..getFavorites()..getUserData(),),
        BlocProvider(
          create: (BuildContext context) => NewsCubit()..getBusiness()..getSports()..getScience(), ),
        BlocProvider(
          create: (BuildContext context) => AppCubit()
            ..changeAppMode(
              fromShared: isDark! ,
            ),
        ),
      ],
        child: BlocConsumer<AppCubit, AppStates>(
          listener: (context, state) {},
          builder: (context, state) {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              theme: lightTheme,
              darkTheme: darkTheme,
              themeMode:
              AppCubit.get(context).isDark ? ThemeMode.dark : ThemeMode.light,
              home:startWidget,
            );
          },
        ),
      );
  }
}