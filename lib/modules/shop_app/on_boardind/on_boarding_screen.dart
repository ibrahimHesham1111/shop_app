import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:udemy_flutter_project/modules/shop_app/login/shop_login_screen.dart';
import 'package:udemy_flutter_project/shared/components/components.dart';
import 'package:udemy_flutter_project/shared/styles/colors.dart';

import '../../../shared/networks/local/cache_helper.dart';
class BoardingModel{
  final String image;
  final String title;
  final String body;

  BoardingModel({required this.image,
    required this.title,
    required this.body});
}
class OnBoardingScreen extends StatefulWidget {
  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  var boardController=PageController();
  bool isLast=false;

  List<BoardingModel>boarding=[
    BoardingModel(
      image: 'assets/images/onboarding_1.png',
      title: 'On Boarding 1 title',
      body: 'On Boarding 1 body',
    ),
    BoardingModel(
      image: 'assets/images/onboarding_2.png',
      title: 'On Boarding 2 title',
      body: 'On Boarding 2 body',
    ),
    BoardingModel(
      image: 'assets/images/onboarding_3.png',
      title: 'On Boarding 3 title',
      body: 'On Boarding 3 body',
    ),
  ];
  void submit(){

  CacheHelper.saveData(key: 'onBoarding', value: true).then((value) {
    if(value)
    {
      navigateAndFinish(context, ShopLoginscreen());
    }
  });
}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          defaultTextButton(
            function: submit,
            text: 'skip',
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                onPageChanged: (int index){
                  if(index==boarding.length-1){
                    print('isLast');
                    setState(() {
                      isLast=true;
                    });
                  }else{
                    setState(() {
                      print('not last');
                      isLast=false;
                    });
                  }
                },
                physics: BouncingScrollPhysics(),
                controller: boardController,
                  itemBuilder:(context,index)=> buildBoardingItem(boarding[index],),
                itemCount: 3,
              ),
            ),
            SizedBox(
              height: 40.0,
            ),
            Row(
              children: [
                SmoothPageIndicator(
                    controller: boardController,
                    count: boarding.length,
                  effect: ExpandingDotsEffect(
                    dotColor: Colors.grey,
                    dotHeight: 10.0,
                    dotWidth: 10.0,
                    expansionFactor: 4,
                    activeDotColor: defaultColor,
                    spacing: 5.0,
                  ),
                ),

                Spacer(),
                FloatingActionButton(
                    onPressed: (){
                      if(isLast){
                        submit();
                      }else{
                        boardController.nextPage(
                            duration: Duration(
                              milliseconds: 750,
                            ),
                            curve:Curves.fastLinearToSlowEaseIn );
                      }

                    },
                  child: Icon(
                    Icons.arrow_forward_ios,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget buildBoardingItem(BoardingModel model)=>Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Expanded(
        child: Image(
          image:AssetImage('${model.image}'),
        ),
      ),
      SizedBox(
        height: 30.0,
      ),
      Text(
        '${model.title}',
        style: TextStyle(
          fontSize: 24.0,
          fontWeight: FontWeight.bold,
        ),
      ),
      SizedBox(
        height: 15.0,
      ),
      Text(
        '${model.body}',
        style: TextStyle(
          fontSize: 14.0,
          fontWeight: FontWeight.bold,
        ),
      ),
      SizedBox(
        height: 15.0,
      ),
    ],
  );
}
