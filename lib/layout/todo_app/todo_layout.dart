
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:sqflite/sqflite.dart';

import 'package:udemy_flutter_project/shared/components/components.dart';
import 'package:udemy_flutter_project/shared/cubit/cubit.dart';
import 'package:udemy_flutter_project/shared/cubit/states.dart';

import '../../shared/components/constans.dart';

class HomeLayout extends StatelessWidget {



  var scaffoldKey=GlobalKey<ScaffoldState>();
  var formKey=GlobalKey<FormState>();
  var titleController =TextEditingController();
  var timeController =TextEditingController();
  var dateController =TextEditingController();


  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) =>AppCubit()..createDatabase(),
      child: BlocConsumer<AppCubit,AppStates>(
        listener: (BuildContext context, AppStates state){
          if(state is AppInsertDatabaseState){
            Navigator.pop(context);
          }
        },
        builder: (BuildContext context, AppStates state){
          AppCubit cubit=AppCubit.get(context);
          return Scaffold(
            key: scaffoldKey,
            appBar: AppBar(
              title: Text(
                cubit.title[cubit.currentIndex],
              ),
            ),
            body:ConditionalBuilder(
              condition: state is!AppGetDatabaseLoadingState,
              builder: (context)=>cubit.screens[cubit.currentIndex],
              fallback:(context)=>Center(child: CircularProgressIndicator()) ,
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: ()
              {
                if(cubit.isBottomSheetShown){
                  if(formKey.currentState!.validate()){
                    cubit.insertToDatabase(title: titleController.text, time: timeController.text, date: dateController.text);
                    // insertToDatabase(title: titleController.text,
                    //     time: timeController.text,
                    //     date: dateController.text
                    // ).then((value)  {
                    //   getDataFromDatabase(database).then((value) {
                    //     Navigator.pop(context);
                    //     // setState(() {
                    //     //   tasks=value;
                    //     //   isBottomSheetShow=false;
                    //     //   setState(() {
                    //     //     fabIcon=Icons.edit;
                    //     //   });
                    //     //
                    //     // });
                    //
                    //
                    //   });
                    // });


                  }

                }else{
                  scaffoldKey.currentState?.showBottomSheet((context) =>
                      Container(
                        color: Colors.white,
                        padding: EdgeInsets.all(20.0),
                        child: Form(
                          key: formKey,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              defaultFormField(
                                  controller: titleController,
                                  type: TextInputType.text,
                                  label: 'Task Title',
                                  prefix: Icons.title,
                                  validate: ( value){
                                    if(value!.isEmpty){
                                      return'title must not be empty';
                                    }
                                    return null;
                                  }
                              ),
                              SizedBox(
                                height: 15.0,
                              ),
                              defaultFormField(
                                  controller: timeController,
                                  type: TextInputType.datetime,
                                  label: 'Task Time',
                                  onTap: (){
                                    showTimePicker(
                                      context: context,
                                      initialTime: TimeOfDay.now(),
                                    ).then((value) {
                                      timeController.text=value!.format(context).toString() ;

                                      print(value!.format(context));
                                    });
                                  },
                                  prefix: Icons.watch_later,
                                  validate: ( value){
                                    if(value!.isEmpty){
                                      return'time must not be empty';
                                    }
                                    return null;
                                  }
                              ),
                              SizedBox(
                                height: 15.0,
                              ),
                              defaultFormField(
                                  controller: dateController,
                                  type: TextInputType.datetime,
                                  label: 'Task Date',
                                  onTap: (){
                                    showDatePicker(
                                        context: context,
                                        initialDate: DateTime.now(),
                                        firstDate: DateTime.now(),
                                        lastDate: DateTime.parse('2023-05-03')).
                                    then((value)  {
                                      print(DateFormat.yMMMd().format(value!));
                                      dateController.text=DateFormat.yMMMd().format(value!);
                                    });

                                  },
                                  prefix: Icons.calendar_today_outlined,
                                  validate: ( value){
                                    if(value!.isEmpty){
                                      return'date must not be empty';
                                    }
                                    return null;
                                  }
                              )
                            ],
                          ),
                        ),
                      ),
                    elevation: 20.0,
                  ).closed.then((value) {
                      cubit.changeBottomSheetState(isShow: false, icon: Icons.edit);

                  });
                  cubit.changeBottomSheetState(isShow: true, icon: Icons.add);
                }

              },
              child: Icon(
               cubit.fabIcon,
              ),
            ),
            bottomNavigationBar: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              currentIndex: cubit.currentIndex,
              onTap: (index){
                cubit.changeIndex(index);
              },
              items: [
                BottomNavigationBarItem(
                    icon: Icon(
                      Icons.menu,
                    ),
                    label: 'Tasks'
                ),
                BottomNavigationBarItem(
                    icon: Icon(
                      Icons.check_circle_outline,
                    ),
                    label: 'Done'
                ),
                BottomNavigationBarItem(
                    icon: Icon(
                      Icons.archive_outlined,
                    ),
                    label: 'archived'
                ),
              ],
            ),
          );
        },

      ),
    );
  }
  Future<String> getName() async {
    return'Ibrahim Hesham';
  }


}


