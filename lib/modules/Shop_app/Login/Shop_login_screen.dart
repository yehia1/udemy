
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:udemy_flutter/layout/Shop_app/Shop_layout.dart';
import 'package:udemy_flutter/modules/Shop_app/Login/Cubit/Cubit.dart';
import 'package:udemy_flutter/modules/Shop_app/Login/Cubit/states.dart';
import 'package:udemy_flutter/modules/Shop_app/Register/Shop_register_screen.dart';
import 'package:udemy_flutter/shared/components/components.dart';
import 'package:udemy_flutter/shared/network/local/cache_helper.dart';

class ShopLoginScreen extends StatelessWidget {

  var FormKey = GlobalKey<FormState>();
  var EmailController = TextEditingController();
  var PasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) =>ShopLoginCubit(),
      child: BlocConsumer<ShopLoginCubit,ShopLoginStates>(
        listener: (context,state){
          if (state is ShopLoginSuccess){
            if(state.shopLoginModel.status == true){
              print(state.shopLoginModel.data!.token);
              print(state.shopLoginModel.message);
              CacheHelper.saveData(key: 'token', value: state.shopLoginModel.data!.token).then((value) =>
                  navigateToStart(context, ShopLayout()));
            }else {
              print(state.shopLoginModel.message);
              ShowToast(msg: state.shopLoginModel.message.toString(), state: ToastStates.ERROR);
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
                      Text("Login".toUpperCase(),
                        style: Theme.of(context).textTheme.headline4!.copyWith(color: Colors.black),),
                      Text("Login now to browse our products",style: Theme.of(context).textTheme.bodyText1!.copyWith(
                          color: Colors.grey
                      )),
                      SizedBox(height: 10,),
                      defaultFormField(controller: EmailController, type: TextInputType.emailAddress, label: "Email address", prefix: Icons.email,
                          validator: (String? value) {
                            if (value!.isEmpty) {
                              return ("please enter your email address");
                            }
                          }
                      ),
                      SizedBox(height: 15,),
                      defaultFormField(controller: PasswordController, type: TextInputType.visiblePassword, label: "Password", prefix: Icons.vpn_key,suffix:  ShopLoginCubit.get(context).suffix,
                          validator: (String? value) {
                            if (value!.isEmpty) {
                              return ("please enter your password");
                            }
                          },
                          onSubmit: (value){
                            if(FormKey.currentState!.validate()){
                              ShopLoginCubit.get(context).UserLogin(email: EmailController.text,Password: PasswordController.text);
                            }
                          },
                          isPassword:  ShopLoginCubit.get(context).isPasswordShown,
                          suffixPressed: (){
                            ShopLoginCubit.get(context).changePasswordIcon();
                          }
                      ),
                      SizedBox(height: 15,),
                      ConditionalBuilder(
                          builder: (context)=> defaultButton(function: (){
                            if(FormKey.currentState!.validate()){
                              ShopLoginCubit.get(context).UserLogin(email: EmailController.text,Password: PasswordController.text);
                            }
                          }, text: "Login"),
                          fallback: (context) =>Center(child: CircularProgressIndicator()),
                          condition: state is! ShopLoginLoading,
                      ),
                      SizedBox(height: 5,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'don\'t have an account',
                          ),
                          defaultTextButton(text: "Register now", function: (){
                            navigateTo(context, RegisterScreen());
                          })
                        ],
                      )
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
