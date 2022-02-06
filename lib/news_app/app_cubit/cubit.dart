import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/news_app/app_cubit/states.dart';
import 'package:news_app/shared/network/local/cacheHelper.dart';

class AppCubit extends Cubit<AppStateCubit> {
  AppCubit() : super(AppInitState());
//a//aa//a
  static AppCubit get(context) => BlocProvider.of<AppCubit>(context);



  bool isDark = false;

  void changeMode({bool? issDark}) {
    if (issDark != null) {
      isDark = issDark;
      emit(NewsChangeModeState());
    } else {
      isDark = !isDark;
      CacheHelper.putBool(key: 'isDark', value: isDark).then(
            (value) => emit(
          NewsChangeModeState(),
        ),
      );
    }
  }
}
