
import 'package:cached_network_image/cached_network_image.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:udemy_flutter_project/layout/shop_app/cubit/cubit.dart';

import 'package:udemy_flutter_project/shared/cubit/cubit.dart';
import 'package:udemy_flutter_project/shared/styles/colors.dart';
import 'package:udemy_flutter_project/shared/styles/icon_broken.dart';

import '../../modules/news_app/web_view/web_view_screen.dart';

Widget defaultButton({
  double width=double.infinity,
  Color background=Colors.blue,
  double radius=10.0,
  bool isUppercase=true,
  required VoidCallback function,
  required String text,
})=>Container(
  width: width,
  height: 40.0,
  decoration: BoxDecoration(
    color: background,
    borderRadius: BorderRadius.circular(
        radius,
    ),
  ),

  child: MaterialButton(
    onPressed:function ,
    child: Text(
      isUppercase ?   text.toUpperCase() :text,
      style: TextStyle(
        color: Colors.white,
      ),
    ),
  ),
);

Widget defaultAppBar({
  required BuildContext context,
  String? title,
  List<Widget>? actions,
}) => AppBar(
  leading: IconButton(
    onPressed: ()
    {
      Navigator.pop(context);
    },
    icon: Icon(
      IconBroken.Arrow___Left_2,
    ),
  ),
  titleSpacing: 0.0,
  title: Text(
    title!,
  ),
  actions: actions,
);

Widget defaultTextButton({
  required VoidCallback function,
  required String text,
})=>TextButton(
  onPressed: function,
  child: Text(
      text.toUpperCase()
  ),);

Widget defaultFormField({
  required TextEditingController controller,
  required TextInputType type,
  ValueChanged<String>? onSubmit,
  ValueChanged<String>? onChange,
  GestureTapCallback? onTap,
bool isClickable=true,
  required String label,
  required IconData prefix,
   required FormFieldValidator<String>? validate,
  bool isPassword=false,
   IconData? suffix,
  VoidCallback? suffixPressed,


})=>TextFormField(
    obscureText: isPassword,
controller: controller,
keyboardType: type,
onFieldSubmitted:onSubmit ,
onChanged:onChange ,
onTap:onTap ,
enabled: isClickable,
decoration: InputDecoration(
labelText: label,
prefixIcon: Icon(
    prefix
),
  suffixIcon:suffix!= null? IconButton(
    onPressed: suffixPressed,
    icon: Icon(
        suffix,
    ),
  ):null,
border: OutlineInputBorder(),
),
validator:validate
);

Widget buildTaskItem(Map model,context)=>Dismissible(
  key: Key(model['id'].toString()),
  child:   Padding(

    padding: const EdgeInsets.all(20.0),

    child: Row(

      children: [

        CircleAvatar(
          radius: 40.0,
          child: Text(
              '${model['time']}',

          ),

        ),

        SizedBox(

          width: 20.0,

        ),

        Expanded(

          child: Column(mainAxisSize: MainAxisSize.min,

            children: [

              Text(

                '${model['title']}',

                style: TextStyle(

                  fontSize: 18.0,

                  fontWeight: FontWeight.bold,

                ),

              ),

              Text(

                '${model['date']}',

                style: TextStyle(

                    color: Colors.grey

                ),

              ),

            ],

          ),

        ),

        SizedBox(

          width: 20.0,

        ),

        IconButton(

            onPressed: (){

              AppCubit.get(context).updateData(status: 'done', id: model['id']);

            },

            icon: Icon(

              Icons.check_box,

              color: Colors.green,

            )),

        IconButton(

            onPressed: (){

              AppCubit.get(context).updateData(status: 'archived', id: model['id']);

            },

            icon: Icon(

              Icons.archive_outlined,

              color: Colors.black45,

            )),

      ],

    ),

  ),
  onDismissed: (direction){
    AppCubit.get(context).deleteData(id: model['id'],);
  },
);

Widget tasksBuilder({
  required List<Map>tasks
})=> ConditionalBuilder(
  condition: tasks.length>0,
  builder:(context)=> ListView.separated(itemBuilder: (context,index)=> buildTaskItem(tasks[index],context),
      separatorBuilder: (context,index)=>myDivider(),
      itemCount: tasks.length),
  fallback: (context) => Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          Icons.menu,
          size: 100.0,
          color: Colors.grey,
        ),
        Text(
          'No Tasks yet, please Add some tasks',
          style: TextStyle(
            color: Colors.grey,
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    ),
  ),
);


Widget buildArticlesItems(article,context)=>InkWell(
  onTap: (){
    navigateTo(context, WebViewScreen());
  },
  child:   Padding(

    padding: const EdgeInsets.all(20.0),

    child: Row(

      children: [

        Container(

          width: 120.0,

          height: 120.0,

             child: CachedNetworkImage(

                imageUrl:('${article['urlToImage']}'),

                errorWidget: (context, url, error) => Icon(Icons.error),

                imageBuilder: (context, imageProvider) => Container(

                  decoration: BoxDecoration(

                    borderRadius: BorderRadius.circular(20.0,),

                    image: DecorationImage(

                      image: imageProvider,

                      fit: BoxFit.cover,

                    )

                    ,

                  )

                  ,

                )

              ),



        ),

        SizedBox(

          width: 10.0,

        ),

        Expanded(

          child: Container(

            height: 120.0,

            child: Column(

              mainAxisSize: MainAxisSize.min,

              crossAxisAlignment:CrossAxisAlignment.start,

              children: [

                Expanded(

                  child: Text(

                    '${article['title']}',

                    style:Theme.of(context).textTheme.bodyText1,

                    maxLines:3,

                    overflow: TextOverflow.ellipsis,

                  ),

                ),

                Text(

                  '${article['publishedAt']}',

                  style: TextStyle(

                    color: Colors.grey,

                  ),

                ),

              ],

            ),

          ),

        ),

      ],

    ),

  ),
);


Widget myDivider()=>Padding(
  padding: const EdgeInsetsDirectional.only(
    start: 20.0,
  ),
  child: Container(
    color: Colors.grey[300],
    width: double.infinity,
    height: 1.0,
  ),
);

Widget articleBuilder(list,context,{isSearch=false})=>ConditionalBuilder(
    condition:list.length>0 ,
    builder: (context)=>ListView.separated(
      physics: BouncingScrollPhysics(),
      itemBuilder: (context, index) => buildArticlesItems(list[index], context),
      separatorBuilder: (context, index) => myDivider(),
      itemCount: list.length,
    ),
    fallback: (context)=>isSearch?Container():Center(child: CircularProgressIndicator()));

void navigateTo(context,Widget)=>Navigator.push(
  context,
  MaterialPageRoute(
    builder: (context) => Widget,
  ),
);

void navigateAndFinish(context,Widget)=>Navigator.pushAndRemoveUntil(
  context,
  MaterialPageRoute(
    builder: (context) => Widget,
  ),
    (Route<dynamic>route)=>false,
);

void showToast({
  required String text,
  required ToastStates state,
})=>Fluttertoast.showToast(
    msg: text,
    toastLength: Toast.LENGTH_LONG,
    gravity: ToastGravity.BOTTOM,
    timeInSecForIosWeb: 5,
    backgroundColor:chooseToastColor(state),
    textColor: Colors.white,
    fontSize: 16.0
);
enum ToastStates{SUCCESS,ERROR,WARNING}

Color chooseToastColor(ToastStates state)
{
  Color color;
  switch(state)
  {
    case ToastStates.SUCCESS:
      color=Colors.green;
      break;
    case ToastStates.ERROR:
      color=Colors.red;
      break;
    case ToastStates.WARNING:
      color=Colors.amber;
      break;
  }
  return color;
}


Widget buildListProducts( model,context,{bool isOldPrice=true})=>Padding(
  padding: const EdgeInsets.all(20.0),
  child: Container(
    height: 120.0,
    child: Row(
      children: [
        Stack(
          children: [
            Image(
              image:NetworkImage(model.image!),
              width: 120.0,
              height: 120.0,

            ),
            if(model.discount!=0&& isOldPrice)
              Container(
                padding: EdgeInsets.symmetric(horizontal: 5.0,),
                color: Colors.red,
                child: Text(
                  'DISCOUNT',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 10.0,
                  ),

                ),
              ),
          ],
          alignment: AlignmentDirectional.bottomStart,
        ),
        Expanded(
          child: Column(
            children: [
              Text(
                model.name!,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    fontSize: 20.0,
                    height: 1.3
                ),
              ),
              Spacer(),
              Row(
                children: [
                  Text(
                    model.price!.toString(),
                    style: TextStyle(
                      fontSize: 12.0,
                      color: defaultColor,
                    ),
                  ),
                  SizedBox(
                    width: 5.0,
                  ),
                  if( model.discount!=0&&isOldPrice)
                    Text(
                      model.oldPrice!.toString(),
                      style: TextStyle(
                        fontSize: 10.0,
                        color: Colors.grey,
                        decoration: TextDecoration.lineThrough,
                      ),
                    ),
                  Spacer(),
                  IconButton(
                      onPressed: (){
                        ShopCubit.get(context).changeFavorites(model.id!);
                      },
                      icon: CircleAvatar(
                        radius: 15.0,
                        backgroundColor:Colors.grey[300],
                        child: Icon(
                          Icons.favorite,
                          size: 14.0,
                          color: ShopCubit.get(context).favorites[model.id]!
                              ? Colors.red
                              :Colors.white,
                        ),
                      ))
                ],

              ),
            ],
          ),
        ),
      ],
    ),
  ),
);





