import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:udemy_flutter_project/models/shop_app/search_model.dart';
import 'package:udemy_flutter_project/models/shop_app/search_model.dart';
import 'package:udemy_flutter_project/modules/shop_app/search/cubit/cubit.dart';
import 'package:udemy_flutter_project/modules/shop_app/search/cubit/states.dart';
import 'package:udemy_flutter_project/shared/components/components.dart';

import '../../../models/shop_app/search_model.dart';
import '../../../models/shop_app/search_model.dart';
import '../../../models/shop_app/search_model.dart';

class SearchScreen extends StatelessWidget {

var formKey=GlobalKey<FormState>();
var searchController=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => SearchCubit(),
      child: BlocConsumer<SearchCubit,SearchStates>(
        listener:(context,state){} ,
        builder:(context,state){
          return Scaffold(
            appBar: AppBar(),
            body:Form(
              key: formKey,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    defaultFormField(
                        controller: searchController,
                        type: TextInputType.text,
                        label: 'search',
                        prefix: Icons.search,
                        validate: (value){
                          if(value!.isEmpty){
                            return ' enter text to search';
                          }
                          return null;
                        },
                        onSubmit: (String text){
                          SearchCubit.get(context).Search(text);
                        }
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    if(state is SearchLoadingState)
                    LinearProgressIndicator(),
                    SizedBox(
                        height: 10.0
                    ),
                    if(state is SearchSuccessState)
                      Expanded(
                        child: ListView.separated(
                            physics: BouncingScrollPhysics(),
                            itemBuilder: (context,index)=>buildListProducts(SearchCubit.get(context).model!.data!.data![index],context,isOldPrice: false),
                            separatorBuilder: (context,index)=>myDivider(),
                            itemCount: SearchCubit.get(context).model!.data!.data!.length),
                      )
                  ],
                ),
              ),
            ),
          );
        } ,

      ),
    );
  }
}