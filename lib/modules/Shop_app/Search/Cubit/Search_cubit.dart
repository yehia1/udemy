
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:udemy_flutter/models/Shop_App/Search_model.dart';
import 'package:udemy_flutter/modules/Shop_app/Search/Cubit/states.dart';
import 'package:udemy_flutter/shared/network/EndPoints.dart';
import 'package:udemy_flutter/shared/network/local/Constants.dart';
import 'package:udemy_flutter/shared/network/remote/dio_helper.dart';

class SearchCubit extends Cubit<SearchStates> {
  SearchCubit() : super(InitialSearchState());

  static SearchCubit get(context) => BlocProvider.of(context);

  late SearchsModel searchsModel;
  void getSearch(String text) {
    emit(LoadingSearchState());
    DioHelper.postData(
      url: Search,
      data: {
        'text': text,
      },
      token: token,
    ).then((value) {
      searchsModel = SearchsModel.fromJson(value.data);
      emit(SucessSearchState());
    }).catchError((error) {
      print(error.toString());
      emit(
        ErrorSearchState(
          error.toString(),
        ),
      );
    });
  }
}