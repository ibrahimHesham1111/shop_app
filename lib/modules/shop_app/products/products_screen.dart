

import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:udemy_flutter_project/layout/shop_app/cubit/cubit.dart';
import 'package:udemy_flutter_project/layout/shop_app/cubit/states.dart';
import 'package:udemy_flutter_project/models/shop_app/categories_model.dart';
import 'package:udemy_flutter_project/models/shop_app/home_model.dart';
import 'package:udemy_flutter_project/shared/components/components.dart';
import 'package:udemy_flutter_project/shared/styles/colors.dart';

class ProductsScreen extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ShopStates>(
      listener: (context,state){
        if(state is ShopSuccessChangeFavoritesState){
          if(!state.model.status!){
            showToast(text: state.model!.message!, state: ToastStates.ERROR);
          }
        }
      },
      builder: (context,state){
        return ConditionalBuilder(
            condition: ShopCubit.get(context).homeModel!=null && ShopCubit.get(context).categoriesModel!=null,
            builder: (context)=>productsBuilder( ShopCubit.get(context).homeModel!,ShopCubit.get(context).categoriesModel!,context),
            fallback: (context)=>Center(child: CircularProgressIndicator()),);
      },

    );
  }
  Widget productsBuilder(HomeModel model,CategoriesModel categoriesModel,context)=>SingleChildScrollView(
    physics: BouncingScrollPhysics(),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CarouselSlider(
            items:model.data?.banners.map((e) => Image(
                image:NetworkImage('${e.image}')
            ), ).toList(),
            options: CarouselOptions(
              height: 180.0,
              initialPage: 0,
              enableInfiniteScroll: true,
              reverse: false,
              autoPlay: true,
              autoPlayInterval: Duration(seconds: 3),
              autoPlayAnimationDuration: Duration(seconds: 1),
              autoPlayCurve: Curves.fastOutSlowIn,
              scrollDirection: Axis.horizontal,
              viewportFraction: 1.0,
            )),
        SizedBox(
          height: 10.0,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 10.0,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Categories',
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.w800
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              Container(
                height: 100.0,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                    physics: BouncingScrollPhysics(),
                    itemBuilder: (context,index)=>buildCategoryItem(categoriesModel.data!.data[index]),
                    separatorBuilder: (context,index)=>SizedBox(
                      width: 10.0,
                    ),
                    itemCount: categoriesModel.data!.data.length
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              Text(
                'New Products',
                style: TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.w800
                ),
              ),
            ],
          ),
        ),
        Container(
          color: Colors.grey[300],
          child: GridView.count(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
            mainAxisSpacing: 1.0,
            crossAxisSpacing: 1.0,
            childAspectRatio: 1 / 1.51,
            children:List.generate(model.data!.products.length,
                    (index) =>buildGridProduct(model.data!.products[index],context)),
          ),
        ),
      ],
    ),
  );
  Widget buildCategoryItem(DataModel model)=>Stack(
  alignment: AlignmentDirectional.bottomCenter,
  children: [
  Image(
  image:NetworkImage(model.image!),
  height: 100.0,
  width: 100.0,
  fit: BoxFit.cover,
  ),
  Container(
  width: 100.0,
  color: Colors.black.withOpacity(.8,),
  child: Text(
  model.name!,
  style: TextStyle(
  color: Colors.white,
  ),
  maxLines: 1,
  overflow: TextOverflow.ellipsis,
  textAlign: TextAlign.center,
  ),
  ),
  ],
  );

  Widget buildGridProduct(ProductsModel model,context)=> Container(
    color: Colors.white,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  Image(
                      image:NetworkImage(model.image!),
                    width: double.infinity,
                    height: 200.0,
                  ),
                  if(model.discount !=0)
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
              Column(
                children: [
                  Text(
                    model.name!,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 14.0,
                      height: 1.3
                    ),
                  ),
                  Row(
                    children: [
                      Text(
                        '${model.price.round()}',
                        style: TextStyle(
                          fontSize: 12.0,
                          color: defaultColor,
                        ),
                      ),
                      SizedBox(
                        width: 5.0,
                      ),
                      if(model.discount !=0)
                      Text(
                        '${model.oldPrice.round()}',
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
                            backgroundColor: Colors.grey[300],
                            child: Icon(
                              Icons.favorite,
                              size: 14.0,
                              color: ShopCubit.get(context).favorites[model.id!]!?Colors.red:Colors.white,
                            ),
                          ))
                    ],

                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    ),
  );
}


