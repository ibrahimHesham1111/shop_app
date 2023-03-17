//https://newsapi.org/v2/top-headlines?country=eg&category=business&apiKey=3017419961774b65aa9fb26a9bb6e368

//https://newsapi.org/v2/everything?q=tesla&apiKey=3017419961774b65aa9fb26a9bb6e368
import 'package:udemy_flutter_project/modules/shop_app/login/shop_login_screen.dart';
import 'package:udemy_flutter_project/shared/components/components.dart';
import 'package:udemy_flutter_project/shared/networks/local/cache_helper.dart';

void signOut(context){
  CacheHelper.removeData(key: 'token').then((value){
    if(value)
    {
      navigateAndFinish(context, ShopLoginscreen());
    }
  });
}

void printFullText(String text)
{
  final pattern=RegExp('.{1,800}');
  pattern.allMatches(text).forEach((match)=>print(match.group(0)));
}

String token='';

String uId='';