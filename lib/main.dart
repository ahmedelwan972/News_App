import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/news_app/app_cubit/cubit.dart';
import 'package:news_app/news_app/app_cubit/states.dart';
import 'package:news_app/news_app/cubit/cubit.dart';
import 'package:news_app/news_app/news_app.dart';
import 'package:news_app/shared/components/constants.dart';
import 'package:news_app/shared/network/local/cacheHelper.dart';
import 'package:news_app/shared/network/remote/dio.dart';

import 'shared/bloc_observer.dart';

//كل الي معمول عليه كومنت ده للتبديل بين ال درك مود و الليت مود بس عشان يشتغل لازم تدوس ع الايكون بتاع التبديل وبعد كدا تشيل الومنتات من هنا وهتقدر تتوجل في كل مره ع طول مش غير الكلام ده 

void main() async {

  Bloc.observer = MyBlocObserver();
  WidgetsFlutterBinding.ensureInitialized();
  await CacheHelper.init();
  DioHelper.init1();

  //bool isDarkk = CacheHelper.getData(key: 'isDark');



  runApp(MyApp(
  //  isDarkk ,
  ));
}

class MyApp extends StatelessWidget {
  //final bool isDark;
  MyApp(
    //  this.isDark,
  );
//a
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => AppCubit()),
        // ..changeMode(issDark: isDark)
        BlocProvider(
            create: (BuildContext context) => NewsCubit()
              ..getBusiness()
              ..getSports()
              ..getScience()),
      ],
      child: BlocConsumer<AppCubit, AppStateCubit>(
        listener: (context, state) {},
        builder: (context, state) => MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: lightTheme,
          darkTheme: darkTheme,
          themeMode: ThemeMode.light,
          //AppCubit.get(context).isDark ? ThemeMode.dark : ThemeMode.light,
          home: NewsScreen(),
        ),
      ),
    );
  }
}
