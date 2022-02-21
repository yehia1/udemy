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

