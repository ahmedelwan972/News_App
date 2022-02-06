import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/news_app/business_screen/business.dart';
import 'package:news_app/news_app/cubit/states.dart';
import 'package:news_app/news_app/science/science.dart';
import 'package:news_app/news_app/sports_screen/sports.dart';
import 'package:news_app/shared/network/remote/dio.dart';

class NewsCubit extends Cubit<NewsStates> {
  NewsCubit() : super(NewsInitialState());

  static NewsCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;

  List<BottomNavigationBarItem> bottomNav = [
    BottomNavigationBarItem(icon: Icon(Icons.business), label: 'Business'),
    BottomNavigationBarItem(icon: Icon(Icons.sports), label: 'Sports'),
    BottomNavigationBarItem(
        icon: Icon(Icons.science_outlined), label: 'Science'),
  ];

  List<Widget> screens = [
    BusinessScreen(),
    SportsScreen(),
    ScienceScreen(),
  ];

  void changeIndex(int index) {
    currentIndex = index;
    emit(NewsBottomNavState());
  }

  List<dynamic> business = [];

  List<dynamic> sports = [];

  List<dynamic> science = [];

  List<dynamic> search = [];



  void getBusiness() {
  DioHelper.getData(url: 'v2/top-headlines', query: {
      'country': 'eg',
      'category': 'business',
      'apiKey': '28e14b16b0ab42e78eea88a040672beb',
    }).then((value) {
      business = value.data['articles'];
      emit(NewsGetBusinessSuccessState());
    }).catchError((e) {
      emit(NewsGetBusinessErrorState(e.toString()));
      print(e.toString());
    });
  }

  // void getBusiness() {
  //   DioHelper.getData(url: 'v2/top-headlines', query: {
  //     'country': 'eg',
  //     'category': 'business',
  //     'apiKey': '28e14b16b0ab42e78eea88a040672beb',
  //   }).then((value) {
  //     business = value.data['articles'];
  //     emit(NewsGetBusinessSuccessState());
  //   }).catchError((e) {
  //     emit(NewsGetBusinessErrorState(e));
  //     print(e.toString());
  //   });
  // }

  void getSports() {
    DioHelper.getData(url: 'v2/top-headlines', query: {
      'country': 'eg',
      'category': 'sports',
      'apiKey': '28e14b16b0ab42e78eea88a040672beb',
    }).then((value) {
      sports = value.data['articles'];
      emit(NewsGetSportsSuccessState());
      print(value.data.toString());
    }).catchError((e) {
      emit(NewsGetSportsErrorState(e.toString()));
      print(e.toString());
    });
  }

  void getScience() {
    DioHelper.getData(url: 'v2/top-headlines', query: {
      'country': 'eg',
      'category': 'science',
      'apiKey': '28e14b16b0ab42e78eea88a040672beb',
    }).then((value) {
      science = value.data['articles'];
      emit(NewsGetScienceSuccessState());
    }).catchError((e) {
      emit(NewsGetScienceErrorState(e.toString()));
      print(e.toString());
    });
  }

  void getSearch(String value) {
    emit(NewsGetSearchLoadingState());
    search = [];
    DioHelper.getData(url: 'v2/top-headlines', query: {
      'q': value,
      'apiKey': '28e14b16b0ab42e78eea88a040672beb',
    }).then((value) {
      search = value.data['articles'];
      emit(NewsGetSearchSuccessState());
    }).catchError((e) {
      emit(NewsGetSearchErrorState(e.toString()));
      print(e.toString());
    });
  }

}
