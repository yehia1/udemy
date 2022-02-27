import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:udemy_flutter/layout/Shop_app/Shop_Cubit/ShopCubit.dart';
import 'package:udemy_flutter/layout/Shop_app/Shop_layout.dart';
import 'package:udemy_flutter/modules/Shop_app/Register/Cubit/Cubit.dart';
import 'package:udemy_flutter/modules/Shop_app/Register/Cubit/states.dart';
import 'package:udemy_flutter/shared/components/components.dart';
import 'package:udemy_flutter/shared/network/local/Constants.dart';
import 'package:udemy_flutter/shared/network/local/cache_helper.dart';

class RegisterScreen extends StatelessWidget {

  var FormKey = GlobalKey<FormState>();
  var EmailController = TextEditingController();
  var NameController = TextEditingController();
  var PasswordController = TextEditingController();
  var PhoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) =>ShopRegisterCubit(),
      child: BlocConsumer<ShopRegisterCubit,ShopRegisterStates>(
        listener: (context,state)
        {
          if (state is ShopRegisterSuccess){
            if(state.shopRegisterModel == true){
              print(state.shopRegisterModel.data.token);
              print(state.shopRegisterModel.message);
              CacheHelper.saveData(key: 'token', value: state.shopRegisterModel.data.token).then((value) {
                token = state.shopRegisterModel.data.token;
                ShopCubit.get(context).currentIndex = 0;
                navigateToAndDestroy(context, ShopLayout());
              });
            }else {
              print(state.shopRegisterModel.message);
              ShowToast(msg: state.shopRegisterModel.message.toString(), state: ToastStates.ERROR);
            }
          }
        },
        builder: (context,state){
          return Scaffold(
            appBar: AppBar(),
            body: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Form(
                  key: FormKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Register".toUpperCase(),
                        style: Theme.of(context).textTheme.headline4!.copyWith(color: Colors.black),),
                      Text("Register now to browse our products",style: Theme.of(context).textTheme.bodyText1!.copyWith(
                          color: Colors.grey
                      )),
                      SizedBox(height: 15,),
                      defaultFormField(controller: NameController, type: TextInputType.name, label: "User Name", prefix: Icons.person,
                          validator: (String? value) {
                            if (value!.isEmpty) {
                              return ("please enter your email address");
                            }
                          }
                      ),
                      SizedBox(height: 15,),
                      defaultFormField(controller: EmailController, type: TextInputType.emailAddress, label: "Email address", prefix: Icons.email,
                          validator: (String? value) {
                            if (value!.isEmpty) {
                              return ("please enter your email address");
                            }
                          }
                      ),
                      SizedBox(height: 15,),
                      defaultFormField(controller: PhoneController, type: TextInputType.phone, label: "Phone number", prefix: Icons.phone,
                          validator: (String? value) {
                            if (value!.isEmpty) {
                              return ("please enter your Phone number");
                            }
                          }
                      ),
                      SizedBox(height: 15,),
                      defaultFormField(controller: PasswordController, type: TextInputType.visiblePassword, label: "Password", prefix: Icons.vpn_key,suffix:  ShopRegisterCubit .get(context).suffix,
                          validator: (String? value) {
                            if (value!.isEmpty) {
                              return ("please enter your password");
                            }
                          },
                          onSubmit: (value){
                            if(FormKey.currentState!.validate()){
                              ShopRegisterCubit .get(context).userRegister(
                                  email: EmailController.text,
                                  password: PasswordController.text,name: NameController.text,phone: PhoneController.text
                                  );
                            }
                          },
                          isPassword:  ShopRegisterCubit .get(context).isPasswordShow,
                          suffixPressed: (){
                            ShopRegisterCubit .get(context).suffix;
                          }
                      ),
                      SizedBox(height: 15,),
                      ConditionalBuilder(
                        builder: (context)=> defaultButton(function: (){
                          if(FormKey.currentState!.validate()){
                            ShopRegisterCubit .get(context).userRegister(name: NameController.text,phone: PhoneController.text,
                                email: EmailController.text,password: PasswordController.text);
                          }
                        }, text: "Register"),
                        fallback: (context) =>Center(child: CircularProgressIndicator()),
                        condition: state is! ShopRegisterLoading,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
