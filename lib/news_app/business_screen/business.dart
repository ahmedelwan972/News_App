import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/news_app/cubit/cubit.dart';
import 'package:news_app/news_app/cubit/states.dart';
import 'package:news_app/shared/components/components.dart';

class BusinessScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, NewsStates>(
        listener: (context, state)
        {

        },
        builder: (context, state) {
          var list = NewsCubit.get(context).business;

          return ListView.separated(
            physics: BouncingScrollPhysics(),
            itemBuilder: (context, index) => list.length == 0 ? Center(child: CircularProgressIndicator()) : buildArticalItem(list[index],context),
            separatorBuilder: (context, index) => Container(
              width: double.infinity,
              height: 1,
              color: Colors.grey,
            ),
            itemCount: list.length,
          );
        });
  }
}
