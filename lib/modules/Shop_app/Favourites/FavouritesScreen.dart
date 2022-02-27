
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:udemy_flutter/layout/Shop_app/Shop_Cubit/ShopCubit.dart';
import 'package:udemy_flutter/layout/Shop_app/Shop_Cubit/states.dart';
import 'package:udemy_flutter/models/Shop_App/favoritesModel.dart';
import 'package:udemy_flutter/shared/components/components.dart';
import 'package:udemy_flutter/shared/styles/colors.dart';

class FavouriteScreen extends StatelessWidget {
  const FavouriteScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ShopStates>(
      listener: (context,state){},
      builder: (context,state){
        FavoritesModel? favoritesModel = ShopCubit.get(context).favoritesModel;
        return ConditionalBuilder(
          builder:(context) => ListView.separated(
              itemBuilder: (context,index) => buildFavItem(favoritesModel!.data.data[index],context),
              separatorBuilder: (context,index) =>myDivider(),
              itemCount: favoritesModel!.data.data.length),
          condition: state is! ShopfavoritesLoadingDataStatus,
          fallback: (context)=> Center(child: CircularProgressIndicator(),),
        );
      },
    );
  }

  Widget buildFavItem(FavoritesData favoritesData,context){
    return Padding(
        padding: EdgeInsets.all(20),
        child:Container(
          height: 120,
          child: Row(
            children: [
            Stack(
            children: [
              Image(
                image: NetworkImage(favoritesData.product.image),
                height: 120,
                width: 120,
              ),
              if (favoritesData.product.discount != 0)
                Container(
                  color: Colors.redAccent,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5.0),
                    child: Text(
                      'On sale',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 8,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
              SizedBox(width: 10.0),
              Expanded(
                child:  Column(
                  textDirection: TextDirection.rtl,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('${favoritesData.product.name}',
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          height: 1.2
                      ),
                    ),
                    Spacer(),
                    Row(
                      textDirection: TextDirection.rtl,
                      children: [
                        Text('${favoritesData.product.price}ج ',
                          softWrap: false,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 11.8,
                            height: 1.2,
                            color: default_color,
                          ),
                        ),
                        Spacer(),
                        if(favoritesData.product.discount != 0 )
                          Text('${favoritesData.product.oldPrice} ',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 12,
                              height: 1.2,
                              color: Colors.grey,
                              decoration: TextDecoration.lineThrough,
                            ),
                          ),
                        Spacer(),
                        IconButton(
                          onPressed: (){
                            ShopCubit.get(context).changeFavourite(favoritesData.product.id!);
                          },
                          icon: CircleAvatar(radius: 15,
                            backgroundColor: ShopCubit.get(context).favorites[favoritesData.product.id]! ? default_color : Colors.grey,
                            child: Icon(
                              Icons.favorite_border,
                              size: 14,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
    ),
    );
  }
}
