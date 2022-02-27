import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:udemy_flutter/layout/Shop_app/Shop_Cubit/ShopCubit.dart';
import 'package:udemy_flutter/modules/Shop_app/Search/Cubit/states.dart';
import 'package:udemy_flutter/shared/components/components.dart';

import 'Cubit/Search_cubit.dart';

class SearchScreen extends StatelessWidget {
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var searchController = TextEditingController();
    return BlocProvider(
      create: (context) => SearchCubit(),
      child: BlocConsumer<SearchCubit, SearchStates>(
          listener: (context, state) {},
          builder: (context, state) {
            return Scaffold(
              appBar: AppBar(),
              body: Form(
                key: formKey,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      TextFormField(
                        controller: searchController,
                        onFieldSubmitted: (String? text) {
                          SearchCubit.get(context).getSearch(text!);
                        },
                        validator: (String? value) {
                          if (value!.isEmpty) {
                            return 'Please add something to search about';
                          }
                          return null;
                        },
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          labelText: 'Search',
                          prefixIcon: Icon(Icons.search),
                          border: OutlineInputBorder(),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      if (state is LoadingSearchState)
                        LinearProgressIndicator(),
                      SizedBox(
                        height: 10.0,
                      ),
                      if (state is SucessSearchState)
                        Expanded(
                          child: ListView.separated(
                              itemBuilder: (context, index) => buildListProduct(
                                SearchCubit.get(context).searchsModel.data.data[index],
                                context,
                                isOldPrice: false,
                              ),
                              separatorBuilder: (context, index) => myDivider(),
                              itemCount: SearchCubit.get(context).searchsModel.data.data.length),
                        ),
                    ],
                  ),
                ),
              ),
            );
          }),
    );
  }
  Widget buildListProduct(
      model,
      context, {
        bool isOldPrice = true,
      }) =>
      Padding(
        padding: const EdgeInsets.all(20.0),
        child: Container(
          height: 120,
          child: Row(
            children: [
              Stack(
                alignment: AlignmentDirectional.bottomStart,
                children: [
                  Image(
                    image: NetworkImage(model.image),
                    fit: BoxFit.cover,
                    height: 120,
                  ),
                  if (model.discount != 0 && isOldPrice)
                    Container(
                      color: Colors.redAccent,
                      child: Padding(
                        padding: const EdgeInsets.all(3.0),
                        child: Text(
                          'DISCOUNT',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                ],
              ),
              SizedBox(width: 20.0),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      model.name,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14.0,
                        height: 1.1,
                      ),
                    ),
                    Spacer(),
                    Row(
                      children: [
                        Text(
                          model.price.toString(),
                          style: TextStyle(
                            color: Colors.blue,
                            fontWeight: FontWeight.bold,
                            fontSize: 14.0,
                          ),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        if (model.discount != 0 && isOldPrice)
                          Text(
                            model.oldPrice!.toString(),
                            style: TextStyle(
                              color: Colors.grey,
                              fontWeight: FontWeight.bold,
                              fontSize: 12.0,
                              decoration: TextDecoration.lineThrough,
                            ),
                          ),
                        Spacer(),
                        IconButton(
                          onPressed: () {
                            ShopCubit.get(context).changeFavourite(model.id!);
                          },
                          icon: CircleAvatar(
                            backgroundColor:
                            ShopCubit.get(context).favorites[model.id]!
                                ? Colors.deepOrange
                                : Colors.black45,
                            radius: 18,
                            child: Icon(
                              Icons.favorite_border,
                              color: Colors.white,
                              size: 17,
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