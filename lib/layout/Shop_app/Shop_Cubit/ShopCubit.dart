import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:udemy_flutter/layout/Shop_app/Shop_Cubit/states.dart';
import 'package:udemy_flutter/models/Shop_App/CategoriesModel.dart';
import 'package:udemy_flutter/models/Shop_App/HomeModel.dart';
import 'package:udemy_flutter/modules/Shop_app/Categories/CategoriesScreen.dart';
import 'package:udemy_flutter/modules/Shop_app/Favourites/FavouritesScreen.dart';
import 'package:udemy_flutter/modules/Shop_app/Products/ProductsScreen.dart';
import 'package:udemy_flutter/modules/Shop_app/settings_screen/settings_screen.dart';
import 'package:udemy_flutter/shared/network/EndPoints.dart';
import 'package:udemy_flutter/shared/network/local/Constants.dart';
import 'package:udemy_flutter/shared/network/remote/dio_helper.dart';

class ShopCubit extends Cubit<ShopStates>{

  ShopCubit() : super(ShopInitialState());

  static ShopCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0 ;

  HomeModel? homeModel;

  CategoriesModel? categoriesModel;

  List<Widget> BottomScreen = [
    ProductScreen(),
    CategoriesScreen(),
    FavouriteScreen(),
    SettingsScreen(),
  ];

  void ChangeBottom(int index){
    currentIndex = index;
    emit(ShopChangeBottomNavState());
  }

  void GetHomeData(){
    emit(ShopHomeLoadingDataStatus());

    DioHelper.getData(url: Home,token: token).then((value){
      homeModel = HomeModel.fromjson(value.data);

      emit(ShopHomeSuccessDataStatus());

    }).catchError((onError){
      print(onError.toString());
      emit(ShopHomeErrorDataStatus(onError));
    });
  }

  void GetCategories(){
    emit(ShopHomeLoadingDataStatus());

    DioHelper.getData(url: Get_categories,token: token).then((value){

      categoriesModel = CategoriesModel.fromjson(value.data);

      emit(ShopCategoriesSuccessDataStatus());

    }).catchError((onError){
      print(onError.toString());
      emit(ShopCategoriesErrorDataStatus(onError.toString()));
    });
  }

}