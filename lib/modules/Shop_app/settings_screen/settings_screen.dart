import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:udemy_flutter/layout/Shop_app/Shop_Cubit/ShopCubit.dart';
import 'package:udemy_flutter/layout/Shop_app/Shop_Cubit/states.dart';
import 'package:udemy_flutter/modules/Shop_app/Login/Shop_login_screen.dart';
import 'package:udemy_flutter/shared/components/components.dart';
import 'package:udemy_flutter/shared/network/local/cache_helper.dart';

var formkey = GlobalKey<FormState>();
var namecontroller = TextEditingController();
var emailcontroller = TextEditingController();
var phonecontroller = TextEditingController();

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
       var model = ShopCubit.get(context).userModel;
       if(model != null){
         namecontroller.text = model.data!.name!;
         emailcontroller.text = model.data!.email!;
         phonecontroller.text = model.data!.phone!;
       }
       return SingleChildScrollView(
         scrollDirection: Axis.vertical,
         child: ConditionalBuilder(
            condition: ShopCubit.get(context).userModel != null,
            builder: (context) =>Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: formkey,
                child: Column(
                  children: [
                    if (state is ShopLoadingUpdateUserState)
                      LinearProgressIndicator(),
                    SizedBox(
                      height: 20,
                    ),
                    defaultFormField(
                      controller: namecontroller,
                      type: TextInputType.name,
                      validator: (String? value) {
                        if (value!.isEmpty) {
                          return 'Name must nbe not empty';
                        }
                        return null;
                      },
                      label: 'Name',
                      labelStyle: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                      prefix: Icons.person,
                      border: OutlineInputBorder(),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    defaultFormField(
                      controller: emailcontroller,
                      type: TextInputType.emailAddress,
                      validator: (String? value) {
                        if (value!.isEmpty) {
                          return 'Email must nbe not empty';
                        }
                        return null;
                      },
                      label: 'Email',
                      labelStyle: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                      prefix: Icons.email,
                      border: OutlineInputBorder(),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    defaultFormField(
                      controller: phonecontroller,
                      type: TextInputType.phone,
                      validator: (String? value) {
                        if (value!.isEmpty) {
                          return 'Phone must nbe not empty';
                        }
                        return null;
                      },
                      label: 'Phone',
                      labelStyle: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                      prefix: Icons.phone_iphone,
                      border: OutlineInputBorder(),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        child: Text(
                          'UPDATE',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        onPressed: () {
                          if (formkey.currentState!.validate()) {
                            ShopCubit.get(context).updateUserData(
                              name: namecontroller.text,
                              email: emailcontroller.text,
                              phone: phonecontroller.text,
                            );
                          }
                        },
                      ),
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    Container(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        child: Text(
                          'LOGOUT',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        onPressed: () {
                                CacheHelper.RemoveData(key: 'token').then((value){
                                if(value = true){
                                  navigateToAndDestroy(context, ShopLoginScreen());
                                }
                              });
                          }
                      ),
                    ),
                  ],
                ),
              ),
            ),
            fallback: (context) => Center(child: CircularProgressIndicator()),
          ),
       );
      },
    );
  }
}