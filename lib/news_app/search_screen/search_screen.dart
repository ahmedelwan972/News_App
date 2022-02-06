import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/news_app/cubit/cubit.dart';
import 'package:news_app/news_app/cubit/states.dart';
import 'package:news_app/shared/components/components.dart';

class SearchScreen extends StatelessWidget {
  @override
  Widget build(context) {
    var searchController = TextEditingController();
    var formKey =GlobalKey<FormState>();

    return BlocConsumer<NewsCubit, NewsStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var list = NewsCubit.get(context).search;
        return Scaffold(
          appBar: AppBar(),
          body: Form(
            key: formKey,
            child: Column(
              children: [
                  SizedBox(height: 20,),
                  Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: defaultTextField(
                    label: 'search',
                    radius: 15,
                    type: TextInputType.text,
                    controller: searchController,
                    onSubmitted: (value){
                      if(formKey.currentState!.validate())
                      {
                        NewsCubit.get(context).getSearch(value);
                      }
                    },
                    prefix: Icons.search,
                    validate: (value) {
                      if (value.isEmpty) {
                        return 'search must not be empty';
                      }
                    },
                  ),
                ),
                if(state is NewsGetSearchLoadingState)
                  LinearProgressIndicator(),
                if(state is NewsGetSearchSuccessState)
                  Expanded(
                  child: ListView.separated(
                    physics: BouncingScrollPhysics(),
                    itemBuilder: (context, index) => list.length == 0
                        ? Center(child: CircularProgressIndicator())
                        : buildArticalItem(list[index], context),
                    separatorBuilder: (context, index) => Container(
                      width: double.infinity,
                      height: 1,
                      color: Colors.grey,
                    ),
                    itemCount: list.length,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
