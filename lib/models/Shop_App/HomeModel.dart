class HomeModel{

  late bool status;
  late HomeDataModel data;

  HomeModel.fromjson(Map<String, dynamic> json){
    status = json['status'];
    data =HomeDataModel.fromjson(json['data']);
  }
}

class HomeDataModel{

  late List<BannerModel> banners ;
  late List<ProductsModel> products;
  HomeDataModel.fromjson(Map<String, dynamic> json){
    // json['banners'].forEach((element){
    //   banners.add(BannerModel.fromjson(element));
    // });

    banners = List.from(json['banners']).map((e) => BannerModel.fromjson(e)).toList();

    // json['products'].forEach((element){
    //   products.add(ProductsModel.fromjson(element));
    // });
    products = List.from(json['products']).map((e) => ProductsModel.fromjson(e)).toList();
  }
}

class BannerModel {
  late int id;
  late String Image;

  BannerModel.fromjson(Map<String, dynamic> json){
      id = json['id'];
      Image = json['image'];
  }
}

class ProductsModel{
  late int id;
  late dynamic oldPrice;
  late dynamic Price;
  late dynamic discount;
  late String name;
  late String Image;
  late bool inFavourites;
  late bool inCart;

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