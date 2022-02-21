
class ShopLoginModel{
  bool? status;
  String? message;
  UserData? data;

  ShopLoginModel.fromJson({required Map<String,dynamic> map}){
    status = map['status'];
    message = map['message'];
    data = map['data']!= null ? UserData.fromJson(map['data']) : null;
  }
}

class UserData {
  int? id;
  String? email;
  String? phone;
  String? Image;
  int? points;
  int? credits;
  String? token;

  UserData.fromJson(Map<String, dynamic> json){
    id = json['id'];
    email = json['email'];
    phone = json['phone'];
    Image = json['Image'];
    points = json['points'];
    credits = json['credits'];
    token = json['token'];
  }
}