import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:udemy_flutter/layout/Shop_app/Shop_Cubit/states.dart';
import 'package:udemy_flutter/models/Shop_App/CategoriesModel.dart';
import 'package:udemy_flutter/models/Shop_App/HomeModel.dart';
import 'package:udemy_flutter/models/Shop_App/Login_Model.dart';
import 'package:udemy_flutter/models/Shop_App/change_favorites_model.dart';
import 'package:udemy_flutter/models/Shop_App/favoritesModel.dart';
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

  FavoritesModel? favoritesModel;

  ChangeFaboritesModel? ChangefavoritesModel;

  ShopLoginModel? userModel;

  Map<int,bool> favorites = {};

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

      homeModel!.data.products.forEach((element) {
          favorites.addAll({
              element.id: element.inFavourites,
          });
      });
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

  void changeFavourite(int productId){
    favorites[productId] = !favorites[productId]!;
    emit(ShopFavoritesChangeStatus());

    DioHelper.postData(
        url: Favorites,
        data: {'product_id': productId},
        token: token,
    ).then((value){
      ChangefavoritesModel = ChangeFaboritesModel.fromjson(value.data);
      if (!ChangefavoritesModel!.status!) {
        favorites[productId] = !favorites[productId]!;
      }
      else{
        Getfavorites();
      }
      emit(ShopFavoritesChangeSuccessStatus(ChangefavoritesModel!));
    }).catchError((onError){
      favorites[productId] = !favorites[productId]!;
      emit(ShopFavoritesChangeErrorStatus(onError.toString()));
    });
  }

  void Getfavorites(){
    emit(ShopfavoritesLoadingDataStatus());

    DioHelper.getData(url: Favorites,token: token).then((value){

      favoritesModel = FavoritesModel.fromJson(value.data);

      emit(ShopfavoritesSuccessDataStatus());

    }).catchError((onError){
      print(onError.toString());
      emit(ShopfavoritesErrorDataStatus(onError.toString()));
    });
  }

  void GetUserData(){
    emit(ShopUserDataLoadingDataStatus());

    DioHelper.getData(url: Profile,token: token).then((value){

      userModel = ShopLoginModel.fromJson(value.data);

      emit(ShopUserDataSuccessDataStatus());

    }).catchError((onError){
      print(onError.toString());
      emit(ShopUserDataErrorDataStatus(onError.toString()));
    });
  }

  void updateUserData({
    required String name,
    required String email,
    required String phone,
  }) {
    emit(ShopLoadingUpdateUserState());
    DioHelper.updateData(
      url: Update_Profile,
      data: {
        'name': name,
        'email': email,
        'phone': phone,
      },
      token: token,
    ).then((value) {
      userModel = ShopLoginModel.fromJson(value.data);
      emit(ShopSucessUpdateUserState());
    }).catchError((error) {
      print(error.toString());
      emit(ShopErrorUpdateUserState(error.toString()));
    });
  }
}