
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:udemy_flutter/modules/Shop_app/Login/Shop_login_screen.dart';
import 'package:udemy_flutter/shared/components/components.dart';
import 'package:udemy_flutter/shared/network/local/cache_helper.dart';
import 'package:udemy_flutter/shared/styles/colors.dart';

class OnBoardingScreen extends StatefulWidget {

  @override
  _OnBoardingScreenState createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  var BoardController = PageController();

  List<BoardingModel> boarding = [
    BoardingModel(title: 'onBoard1', image: 'assets/images/onboard_1.jpg', body: 'onBoard1 body'),
    BoardingModel(title: 'onBoard2', image: 'assets/images/onboard_1.jpg', body: 'onBoard2 body' ),
    BoardingModel(title: 'onboard3', image: "assets/images/onboard_1.jpg", body: 'onBoard3 body')
  ];

  bool islast = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          defaultTextButton(text: "Skip", function: submit),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: PageView.builder(
                physics: BouncingScrollPhysics(),
                onPageChanged: (int index){
                  if(index == boarding.length - 1 ){
                    setState(() {
                      islast = true;
                    });
                  }else
                    {islast = false;}
                },
                controller: BoardController,
                itemBuilder: (context,index)=>buildPageViewItem(boarding[index]),
              itemCount: boarding.length,),
            ),
            SizedBox(height: 40,),
            Row(
              children: [
                SmoothPageIndicator(controller: BoardController,count: boarding.length,effect: ExpandingDotsEffect(
                  dotHeight: 10,
                  activeDotColor: default_color,
                  dotColor: Colors.grey,
                  expansionFactor: 4,
                  spacing: 5,
                )),
                Spacer(),
                FloatingActionButton(onPressed: (){
                  if (islast){
                    submit();
                  }
                  else {
                    BoardController.nextPage(duration: Duration(milliseconds: 750), curve: Curves.fastOutSlowIn);
                  }
                },child: Icon(Icons.arrow_forward),)
              ],
            )
          ],
        ),
      )
    );
  }

  Widget buildPageViewItem(BoardingModel boardingModel) =>Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Expanded(child: Image(image: AssetImage(boardingModel.image))),
      Text(boardingModel.title,style: TextStyle(fontSize: 30),),
      SizedBox(height: 15,),
      Text(boardingModel.body,style: TextStyle(fontSize: 14,)),
    ],
  );

  void submit(){
    CacheHelper.saveData(key: 'onBoarding', value: true).then((value){
      if(value){
        navigateToStart(context, ShopLoginScreen());
      }
    });
  }
}
class BoardingModel {
  final String title;
  final String image;
  final String body;

  BoardingModel({required this.title,required this.image,required this.body});
}

