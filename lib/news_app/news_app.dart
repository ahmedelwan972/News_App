import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/news_app/search_screen/search_screen.dart';
import 'package:news_app/shared/components/components.dart';

import 'app_cubit/cubit.dart';
import 'cubit/cubit.dart';
import 'cubit/states.dart';

class NewsScreen extends StatelessWidget {
  const NewsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, NewsStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var list = NewsCubit.get(context).search;
        NewsCubit cubit = NewsCubit.get(context);
        return Scaffold(
          body: cubit.screens[cubit.currentIndex],
          appBar: AppBar(
            title: Text(
              'News App',
            ),
            actions: [
              IconButton(
                icon: Icon(
                  Icons.search,
                ),
                onPressed: ()
                {
                  navigateTo(context, SearchScreen());
                },
              ),
              IconButton(
                icon: Icon(
                  Icons.dark_mode,
                ),
                onPressed: ()
                {
                  AppCubit.get(context).changeMode();
                },
              ),
            ],
          ),
          bottomNavigationBar: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            currentIndex: cubit.currentIndex,
            onTap: (index) {
              cubit.changeIndex(index);
            },
            items: cubit.bottomNav,
          ),
        );
      },
    );
  }
}
