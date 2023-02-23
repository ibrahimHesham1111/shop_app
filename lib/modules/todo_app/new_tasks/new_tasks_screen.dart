import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:udemy_flutter_project/shared/cubit/cubit.dart';
import 'package:udemy_flutter_project/shared/cubit/states.dart';

import '../../../shared/components/components.dart';



class NewTasksScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit,AppStates>(
     listener: (context,state){},
      builder: (context,state){
       var tasks=AppCubit.get(context).newTasks;
       return  tasksBuilder(tasks: tasks
       );
      },
    );
  }
}
