import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:udemy_flutter/models/Shop_App/RegisterModel.dart';
import 'package:udemy_flutter/modules/Shop_app/Register/Cubit/states.dart';
import 'package:udemy_flutter/shared/network/EndPoints.dart';
import 'package:udemy_flutter/shared/network/remote/dio_helper.dart';

class ShopRegisterCubit extends Cubit<ShopRegisterStates> {
  ShopRegisterCubit() : super(ShopRegisterInitital());

  static ShopRegisterCubit get(context) => BlocProvider.of(context);

  IconData suffix = Icons.visibility_outlined;
  bool isPasswordShow = true;

  late ShopRegisterModel registerModel;

  void changePasswordVisibility() {
    isPasswordShow = !isPasswordShow;
    suffix = isPasswordShow
        ? Icons.visibility_outlined
        : Icons.visibility_off_outlined;

    emit(ShopRegisterChangePasswordVisibility());
  }

  void userRegister({
    required String name,
    required String email,
    required String phone,
    required String password,
  }) {
    emit(ShopRegisterLoading());
    DioHelper.postData(
      url: Register,
      data: {
        'name': name,
        'email': email,
        'phone': phone,
        'password': password,
      },
    ).then((value) {
      print(value.data);
      registerModel = ShopRegisterModel.fromJson(value.data);
      emit(ShopRegisterSuccess(registerModel));
    }).catchError(
          (error) {
        print(error.toString());
        emit(
          ShopRegisterFailed(
            error.toString(),
          ),
        );
      },
    );
  }
}

