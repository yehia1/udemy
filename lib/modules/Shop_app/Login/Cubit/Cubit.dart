import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:udemy_flutter/models/Shop_App/Login_Model.dart';
import 'package:udemy_flutter/modules/Shop_app/Login/Cubit/states.dart';
import 'package:udemy_flutter/shared/network/EndPoints.dart';
import 'package:udemy_flutter/shared/network/remote/dio_helper.dart';

class ShopLoginCubit extends Cubit<ShopLoginStates> {
  ShopLoginCubit() : super(ShopLoginInitital());

  ShopLoginModel? LoginModel;


  static ShopLoginCubit get(context) => BlocProvider.of(context);

  void UserLogin({required String email, required String Password}) {
    emit(ShopLoginLoading());

    DioHelper.postData(url: Login, data: {
      'email': email,
      'password': Password
      }).then((value){
        print(value.data);
        LoginModel = ShopLoginModel.fromJson(value.data);
        emit(ShopLoginSuccess(LoginModel!));
      }).catchError((onError){
        print(onError.toString());
        emit(ShopLoginFailed(onError.toString()));
     });
    }

  IconData suffix = Icons.remove_red_eye;
  bool isPasswordShown = true;

  void changePasswordIcon(){
    isPasswordShown = !isPasswordShown;
    suffix = isPasswordShown ? Icons.remove_red_eye :Icons.visibility_off;
    emit(ShopLoginChangePasswordVisibility());
  }
}

