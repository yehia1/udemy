
import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:udemy_flutter/layout/Shop_app/Shop_Cubit/ShopCubit.dart';
import 'package:udemy_flutter/layout/Shop_app/Shop_Cubit/states.dart';
import 'package:udemy_flutter/models/Shop_App/CategoriesModel.dart';
import 'package:udemy_flutter/models/Shop_App/HomeModel.dart';
import 'package:udemy_flutter/shared/components/components.dart';
import 'package:udemy_flutter/shared/styles/colors.dart';

class ProductScreen extends StatelessWidget {
  const ProductScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ShopStates>(
        listener: (context,state){
          if(state is ShopFavoritesChangeSuccessStatus){
            if(!state.changeFaboritesModel.status!){
                ShowToast(msg: state.changeFaboritesModel.message.toString(), state: ToastStates.ERROR);
            }
          }
        },
        builder:(context,state) {
          return ConditionalBuilder(
              condition: ShopCubit.get(context).homeModel != null && ShopCubit.get(context).categoriesModel !=null,
              builder: (context)=>ProductsBuilder(ShopCubit.get(context).homeModel,ShopCubit.get(context).categoriesModel,context),
              fallback: (context)=> Center(child: CircularProgressIndicator()));
        }

        );
  }

  Widget ProductsBuilder(HomeModel? homeModel,CategoriesModel? categoriesModel,context){
      return SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        scrollDirection: Axis.vertical,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CarouselSlider(
                items: homeModel!.data.banners.map((e) =>
                    Image(
                      image: NetworkImage('${e.Image}'),
                      width: double.infinity,
                      fit: BoxFit.cover,
                    )
                ).toList(),
                options: CarouselOptions(
                    height:250,
                    initialPage: 0,
                    viewportFraction: 1.0,
                    enableInfiniteScroll: true,
                    reverse: false,
                    autoPlay: true,
                    autoPlayInterval: Duration(seconds: 3),
                    autoPlayAnimationDuration: Duration(seconds: 1),
                    autoPlayCurve: Curves.fastOutSlowIn,
                    scrollDirection: Axis.horizontal,
                )),
            SizedBox(height: 15,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Categories',style: TextStyle(fontWeight: FontWeight.w800,fontSize: 24),),
                  Container(
                    height: 100,
                    child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context,index) =>BuildCategoryItem(categoriesModel!.categoriesDataModel!.data[index]),
                        separatorBuilder: (context,index) => SizedBox(width: 15),
                        itemCount: categoriesModel!.categoriesDataModel!.data.length),
                  ),
                  SizedBox(height: 20,),
                  Text('New Products',style: TextStyle(fontWeight: FontWeight.w800,fontSize: 24),),
                ],
              ),
            ),
            Container(
              child: GridView.count(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                children: List.generate(
                    homeModel.data.products.length,
                    (index) => builGridProduct(homeModel.data.products[index],context),
              ),
                crossAxisSpacing: 5,
                mainAxisSpacing: 2,
                childAspectRatio: 1/ 1.74,
              ),
            ),
          ],
        ),
      );
  }

  Widget builGridProduct(ProductsModel productsModel,context){
      return Container(
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Image(
                  image: NetworkImage(productsModel.Image.toString()),
                  width: double.infinity,
                  height: 200,
                ),
                if(productsModel.discount != 0 )
                Container(
                  color: Colors.red,
                  padding: EdgeInsets.symmetric(horizontal: 5),
                  child: Text(
                    'onSale',
                    style: TextStyle(
                      fontSize: 10,
                      color: Colors.white
                    ),
                  ),
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                textDirection: TextDirection.rtl,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('${productsModel.name}',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      height: 1.2
                    ),
                  ),
                  Row(
                    textDirection: TextDirection.rtl,
                    children: [
                      Text('${productsModel.Price}ج ',
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
                      if(productsModel.discount != 0 )
                        Text('${productsModel.oldPrice} ',
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
                            ShopCubit.get(context).changeFavourite(productsModel.id);
                          },
                          icon: CircleAvatar(radius: 15,
                              backgroundColor: ShopCubit.get(context).favorites[productsModel.id]! ? default_color : Colors.grey,
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
            )
          ],
        ),
      );
  }

  Widget BuildCategoryItem(DataModel model){
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        Image(image: NetworkImage(model.Image.toString()),
          width: 100,
          height: 100,
        ),
        Container(
          color: Colors.black.withOpacity(0.7),
          width: 100,
          child: Text('${model.name}',style: TextStyle(color: Colors.white),textAlign: TextAlign.center,maxLines: 1,overflow: TextOverflow.ellipsis,),
        )
      ],
    );
  }
}
