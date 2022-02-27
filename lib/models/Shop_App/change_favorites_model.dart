class ChangeFaboritesModel{
  bool? status;
  String? message;

  ChangeFaboritesModel.fromjson(Map<String,dynamic> json){
    status = json['status'];
    message =json['message'];
  }
}