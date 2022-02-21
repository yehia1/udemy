class CategoriesModel{
  bool? status;
  CategoriesDataModel? categoriesDataModel;

  CategoriesModel.fromjson(Map<String, dynamic> json){
    status = json['status'];
    categoriesDataModel =CategoriesDataModel.fromjson(json['data']);
  }

}

class CategoriesDataModel{

  int? currentPage;
  List<DataModel> data = [];

  CategoriesDataModel.fromjson(Map<String, dynamic> json){
    currentPage = json['current_page'];
    json['data'].forEach((element){
      data.add(DataModel.fromjson(element));
    });
  }
}

class DataModel{
  int? id;
  String? name;
  String? Image;

  DataModel.fromjson(Map<String, dynamic> json){
    id = json['id'];
    name = json['name'];
    Image = json['image'];
  }
}

