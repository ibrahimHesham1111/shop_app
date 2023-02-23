import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:udemy_flutter_project/layout/news_app/cubit/cubit.dart';
import 'package:udemy_flutter_project/layout/news_app/cubit/states.dart';
import 'package:udemy_flutter_project/shared/components/components.dart';

class SearchScreen extends StatelessWidget {

var SearchController=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit,NewsStates>(
      listener: (context,state){},
      builder: (context,state){
        var list=NewsCubit.get(context).search;
        return Scaffold(
          appBar: AppBar(),
          body: Column(
              children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: defaultFormField(
                  onChange: (value){
                    NewsCubit.get(context).getSearch(value);
                  },
                controller: SearchController,
                type: TextInputType.text,
                label: 'search',
                prefix: Icons.search,
                validate: ( value)
                {
                  if(value!.isEmpty){
                    return 'search must not be empty';
                  }
                  return null;
                }
          ),
              ),
          Expanded(
              child: articleBuilder(list,context,isSearch: true)),
          ],
        ),
        );
      },

      );

  }
}
