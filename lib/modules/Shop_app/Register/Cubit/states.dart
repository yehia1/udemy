import 'package:udemy_flutter/models/Shop_App/RegisterModel.dart';

abstract class ShopRegisterStates{}

class ShopRegisterInitital extends ShopRegisterStates{}

class ShopRegisterLoading extends ShopRegisterStates{}

class ShopRegisterSuccess extends ShopRegisterStates
{
  final ShopRegisterModel shopRegisterModel;

  ShopRegisterSuccess(this.shopRegisterModel);
}

class ShopRegisterFailed extends ShopRegisterStates{
  final String error;
  ShopRegisterFailed(this.error);
}

class ShopRegisterChangePasswordVisibility extends ShopRegisterStates{}
