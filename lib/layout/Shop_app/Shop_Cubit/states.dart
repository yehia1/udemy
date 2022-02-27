import 'package:udemy_flutter/models/Shop_App/change_favorites_model.dart';

abstract class ShopStates {}

class ShopInitialState extends ShopStates{}

class ShopChangeBottomNavState extends ShopStates{}

class ShopHomeLoadingDataStatus extends ShopStates{}

class ShopHomeSuccessDataStatus extends ShopStates{}

class ShopHomeErrorDataStatus extends ShopStates{
  final String Error;

  ShopHomeErrorDataStatus(this.Error);
}

class ShopCategoriesSuccessDataStatus extends ShopStates{}

class ShopCategoriesErrorDataStatus extends ShopStates {
  final String Error;

  ShopCategoriesErrorDataStatus(this.Error);
}

class ShopFavoritesChangeSuccessStatus extends ShopStates{
  final ChangeFaboritesModel changeFaboritesModel;

  ShopFavoritesChangeSuccessStatus(this.changeFaboritesModel);
}

class ShopFavoritesChangeStatus extends ShopStates {
}

class ShopFavoritesChangeErrorStatus extends ShopStates{

  final String Error;

  ShopFavoritesChangeErrorStatus(this.Error);
}

class ShopfavoritesLoadingDataStatus extends ShopStates{}

class ShopfavoritesSuccessDataStatus extends ShopStates{}

class ShopfavoritesErrorDataStatus extends ShopStates {
  final String Error;

  ShopfavoritesErrorDataStatus(this.Error);

}

class ShopUserDataLoadingDataStatus extends ShopStates{}

class ShopUserDataSuccessDataStatus extends ShopStates{}

class ShopUserDataErrorDataStatus extends ShopStates {
  final String Error;

  ShopUserDataErrorDataStatus(this.Error);
}

class ShopLoadingUpdateUserState extends ShopStates{}

class ShopSucessUpdateUserState extends ShopStates{}

class ShopErrorUpdateUserState extends ShopStates{
  final String Error;

  ShopErrorUpdateUserState(this.Error);
}

