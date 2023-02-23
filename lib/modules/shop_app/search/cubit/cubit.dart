import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:udemy_flutter_project/models/shop_app/search_model.dart';
import 'package:udemy_flutter_project/modules/shop_app/search/cubit/states.dart';
import 'package:udemy_flutter_project/shared/components/constans.dart';
import 'package:udemy_flutter_project/shared/networks/end_point.dart';
import 'package:udemy_flutter_project/shared/networks/remote/dio_helper.dart';

class SearchCubit extends Cubit<SearchStates>
{
  SearchCubit(): super(SearchLoadingState());
  static SearchCubit get(context)=>BlocProvider.of(context);

  SearchModel? model;

  void Search(String text)
  {
    emit(SearchLoadingState());
  DioHelper.postData(
      url: SEARCH,
      data: {
        'text':text,
      }).then((value)
  {
    model=SearchModel.fromJson(value.data);
    emit(SearchSuccessState());

  }).catchError((error)
  {
    print(error.toString());
    emit(SearchErrorState());
  });
  }


}