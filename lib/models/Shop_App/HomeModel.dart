class HomeModel{

  bool? status;
  HomeDataModel? data;

  HomeModel.fromjson(Map<String, dynamic> json){
    status = json['status'];
    data =HomeDataModel.fromjson(json['data']);
  }
}

class HomeDataModel{

  List<BannerModel> banners = [];
  List<ProductsModel> products = [];
  HomeDataModel.fromjson(Map<String, dynamic> json){
    json['banners'].forEach((element){
      banners.add(BannerModel.fromjson(element));
    });

    json['products'].forEach((element){
      products.add(ProductsModel.fromjson(element));
    });
  }
}

class BannerModel {
  int? id;
  String? Image;

  BannerModel.fromjson(Map<String, dynamic> json){
      id = json['id'];
      Image = json['image'];
  }
}

class ProductsModel{
  int? id;
  dynamic oldPrice;
  dynamic Price;
  dynamic discount;
  String? name;
  String? Image;
  bool? inFavourites;
  bool? inCart;

  ProductsModel.fromjson(Map<String, dynamic> json){
      id = json['id'];
      oldPrice = json['old_price'];
      Price = json['price'];
      discount = json['discount'];
      name = json['name'];
      Image = json['image'];
      inFavourites = json['in_favorites'];
      inCart = json['in_cart'];
  }
}