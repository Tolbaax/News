import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news365/shared/cubit/cubit.dart';
import 'package:news365/shared/cubit/states.dart';
import '../shared/components/components.dart';

class SearchScreen extends StatelessWidget {

  TextEditingController searchController  =TextEditingController();

  @override
  Widget build(BuildContext context) {
    return  BlocConsumer<NewsCubit,NewsStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var list = NewsCubit.get(context).search;
        return Scaffold(
          appBar: AppBar(),
          body: Column(
            children: [
              Padding(
                padding: const EdgeInsetsDirectional.all(20.0),
                child: defaultFormField(
                    validate:  (value) {
                      if (value!.isEmpty) {
                        return 'search must not be empty';
                      }
                      return null;
                    },
                    onChange: (value)
                    {
                      NewsCubit.get(context).getSearch(value!);
                    },
                    controller: searchController,
                    type: TextInputType.text,
                    prefix: Icons.search,
                    label: 'Search'
                ),
              ),
              Expanded(child: articleBuilder(list)),
            ],
          ),
        );
      },
    );
  }
}
