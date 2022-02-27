import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:udemy_flutter/layout/Shop_app/Shop_layout.dart';
import 'package:udemy_flutter/layout/news_app/cubit/cubit.dart';
import 'package:udemy_flutter/modules/Shop_app/Login/Shop_login_screen.dart';
import 'package:udemy_flutter/modules/Shop_app/On_boarding_screen/on_boarding_screen.dart';
import 'package:udemy_flutter/shared/bloc_observer.dart';
import 'package:udemy_flutter/shared/cubit/cubit.dart';
import 'package:udemy_flutter/shared/cubit/states.dart';
import 'package:udemy_flutter/shared/network/local/Constants.dart';
import 'package:udemy_flutter/shared/network/local/cache_helper.dart';
import 'package:udemy_flutter/shared/network/remote/dio_helper.dart';
import 'package:udemy_flutter/shared/styles/Themes.dart';

import 'layout/Shop_app/Shop_Cubit/ShopCubit.dart';

void main() async {
  // بيتأكد ان كل حاجه هنا في الميثود خلصت و بعدين يتفح الابلكيشن
  WidgetsFlutterBinding.ensureInitialized();

  HttpOverrides.global = MyHttpOverrides();
  Bloc.observer = MyBlocObserver();
  DioHelper.init();
  await CacheHelper.init();

  late bool? isDark = CacheHelper.getData(key: 'isDark');

  Widget widget;
  
  late bool? onBoarding = CacheHelper.getData(key:'onBoarding');


  token = CacheHelper.getData(key: 'token');
  print(token);

  if(onBoarding != null){
    if(token!= null){
      widget = ShopLayout();
    }
    else{
      widget = ShopLoginScreen();
    }
  }else{
    widget = OnBoardingScreen();
  }

  runApp(MyApp(isDark :isDark,StartWidget: widget,));
}

// Stateless
// Stateful

// class MyApps

class MyApp extends StatelessWidget {
  // constructor
  // build
   bool? isDark;
   Widget? StartWidget;

  MyApp({this.isDark, this.StartWidget});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers:
      [
        BlocProvider(
          create: (context) => NewsCubit()
            ..getBusiness()
            ..getSports()
            ..getScience(),
        ),
        BlocProvider(
          create: (BuildContext context) => AppCubit()
            ..changeAppMode(
              fromShared: isDark,
            ),
        ),
        BlocProvider(
            create : (BuildContext context) => ShopCubit()..GetHomeData()..GetCategories()..Getfavorites()..GetUserData())
      ],
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: lightTheme,
            darkTheme: darkTheme,
            themeMode:ThemeMode.light,
                // AppCubit.get(context).isDark ? ThemeMode.dark : ThemeMode.light,
            home: StartWidget,
          );
        },
      ),
    );
  }
}


//to handle dio post error
class MyHttpOverrides extends HttpOverrides{
  @override
  HttpClient createHttpClient(SecurityContext? context){
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port)=> true;
  }
}
