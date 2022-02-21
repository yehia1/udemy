
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:udemy_flutter/layout/Shop_app/Shop_Cubit/ShopCubit.dart';
import 'package:udemy_flutter/layout/Shop_app/Shop_Cubit/states.dart';
import 'package:udemy_flutter/models/Shop_App/CategoriesModel.dart';
import 'package:udemy_flutter/shared/components/components.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ShopStates>(
      listener: (context,state){},
      builder: (context,state){
        CategoriesModel? categoriesModel = ShopCubit.get(context).categoriesModel;
        return ListView.separated(
            itemBuilder: (context,index) => BuildCatItem(categoriesModel!.categoriesDataModel!.data[index]),
            separatorBuilder: (context,index) =>myDivider(),
            itemCount: categoriesModel!.categoriesDataModel!.data.length);
      },
    );
  }

  Widget BuildCatItem(DataModel model){
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Row(
        children: [
          Image(
            image: NetworkImage('${model.Image}'),
            width: 88,
            height: 88,
            fit: BoxFit.cover,
          ),
          SizedBox(width: 20,),
          Text('${model.name}',style: TextStyle(fontSize:20,fontWeight: FontWeight.bold),),
          Spacer(),
          Icon(Icons.arrow_forward_ios),
        ],
      ),
    );
  }
}
