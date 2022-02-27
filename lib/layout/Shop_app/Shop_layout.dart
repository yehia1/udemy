import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:udemy_flutter/layout/Shop_app/Shop_Cubit/ShopCubit.dart';
import 'package:udemy_flutter/layout/Shop_app/Shop_Cubit/states.dart';
import 'package:udemy_flutter/modules/Shop_app/Login/Shop_login_screen.dart';
import 'package:udemy_flutter/modules/Shop_app/Search/SearchScreen.dart';
import 'package:udemy_flutter/shared/components/components.dart';
import 'package:udemy_flutter/shared/network/local/cache_helper.dart';

class ShopLayout extends StatelessWidget {
  const ShopLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ShopStates>(
      listener: (context,state){},
      builder: (context,state) {
        var cubit = ShopCubit.get(context);
        return  Scaffold(
          appBar: AppBar(
            title: Text('Big Shop'),
            actions: [
              IconButton(icon :Icon(Icons.search),onPressed: (){navigateTo(context, SearchScreen());},),
            ],
          ),
          body: cubit.BottomScreen[cubit.currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: cubit.currentIndex,
            onTap: (index){cubit.ChangeBottom(index);},
            items: [
              BottomNavigationBarItem(icon: Icon(Icons.home),label: 'Home'),
              BottomNavigationBarItem(icon: Icon(Icons.apps),label: 'Categories'),
              BottomNavigationBarItem(icon: Icon(Icons.favorite),label: 'Favorites'),
              BottomNavigationBarItem(icon: Icon(Icons.settings),label: 'Settings'),
            ],
          ),
        );
      },
    );
  }

  Widget Signout(BuildContext context){
    return defaultTextButton(text: 'Sign out', function: (){
      CacheHelper.RemoveData(key: 'token').then((value){
        if(value = true){
          navigateToAndDestroy(context, ShopLoginScreen());
        }
      });
    });
  }
}
