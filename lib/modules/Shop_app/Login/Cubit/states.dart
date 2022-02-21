import 'package:udemy_flutter/models/Shop_App/Login_Model.dart';

abstract class ShopLoginStates{}

class ShopLoginInitital extends ShopLoginStates{}

class ShopLoginLoading extends ShopLoginStates{}

class ShopLoginSuccess extends ShopLoginStates
{
  final ShopLoginModel shopLoginModel;

  ShopLoginSuccess(this.shopLoginModel);
}

class ShopLoginFailed extends ShopLoginStates{
  final String error;
  ShopLoginFailed(this.error);
}

class ShopLoginChangePasswordVisibility extends ShopLoginStates{}
