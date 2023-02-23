import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:udemy_flutter_project/layout/shop_app/cubit/cubit.dart';
import 'package:udemy_flutter_project/layout/shop_app/cubit/states.dart';
import 'package:udemy_flutter_project/models/shop_app/favorites_model.dart';
import 'package:udemy_flutter_project/shared/components/components.dart';
import 'package:udemy_flutter_project/shared/styles/colors.dart';

class favoritesScreen extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return  BlocConsumer<ShopCubit,ShopStates>(
      listener: (context,state){},
      builder: (context,state){
        return ConditionalBuilder(
          condition: state is ! ShopLoadingGetFavoritesState,
          builder:(context)=> ListView.separated(
              physics: BouncingScrollPhysics(),
              itemBuilder: (context,index)=>buildFavItem(ShopCubit.get(context).favoritesModel!.data!.data![index],context),
              separatorBuilder: (context,index)=>myDivider(),
              itemCount: ShopCubit.get(context).favoritesModel!.data!.data!.length),
          fallback: (context)=>Center(child: CircularProgressIndicator()),
        );
      },
    );
  }

  Widget buildFavItem(FavoritesData model,context)=>Padding(
    padding: const EdgeInsets.all(20.0),
    child: Container(
      height: 120.0,
      child: Row(
        children: [
          Stack(
            children: [
              Image(
                image:NetworkImage(model.product!.image!),
                width: 120.0,
                height: 120.0,

              ),
              if(model.product!.discount!=0)
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
                  model.product!.name!,
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
                      model.product!.price!.toString(),
                      style: TextStyle(
                        fontSize: 12.0,
                        color: defaultColor,
                      ),
                    ),
                    SizedBox(
                      width: 5.0,
                    ),
                    if( model.product!.discount!!=0)
                      Text(
                      model.product!.oldPrice!.toString(),
                        style: TextStyle(
                          fontSize: 10.0,
                          color: Colors.grey,
                          decoration: TextDecoration.lineThrough,
                        ),
                      ),
                    Spacer(),
                    IconButton(
                        onPressed: (){
                          ShopCubit.get(context).changeFavorites(model.product!.id!);
                        },
                        icon: CircleAvatar(
                          radius: 15.0,
                          backgroundColor:Colors.grey[300],
                          child: Icon(
                            Icons.favorite,
                            size: 14.0,
                            color: ShopCubit.get(context).favorites[model.product!.id]!
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
}