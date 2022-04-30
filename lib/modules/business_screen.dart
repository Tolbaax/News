import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news365/shared/components/components.dart';
import 'package:news365/shared/cubit/cubit.dart';
import 'package:news365/shared/cubit/states.dart';

class BusinessScreen extends StatelessWidget {
  const BusinessScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit,NewsStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var list = NewsCubit.get(context).business;
        return ConditionalBuilder(
            condition: list.isNotEmpty,
            builder: (context)=> ListView.separated(
              physics: const BouncingScrollPhysics(),
                itemBuilder: (context,index)=> buildArticleItem(list[index]),
                separatorBuilder: (context,index)=> myDivider(),
                itemCount: 10
            ),
            fallback: (context)=> const Center(
                child: CircularProgressIndicator(),),
        );
      },
    );
  }
}
