import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news365/shared/cubit/cubit.dart';
import 'package:news365/shared/cubit/states.dart';
import 'package:news365/shared/network/remote/dio_helper.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context,)=> NewsCubit(),
      child: BlocConsumer<NewsCubit, NewsStates>(
        listener: (context, state) {},
        builder: (context, state) {
          NewsCubit cubit = NewsCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              title: const Text(
                  'News App'
              ),
              actions: [
                IconButton(onPressed: () {}, icon: const Icon(Icons.search)),
              ],
            ),
            bottomNavigationBar: BottomNavigationBar(
              currentIndex: cubit.currentIndex,
              items: cubit.bottomItems,
              onTap: (int index) {
                cubit.changeBottomNavBar(index);
              },
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                DioHelper.getData(
                  url: 'v2/top-headlines',
                  query: {
                    'country': 'eg',
                    'category': 'business',
                    'apikey': '5d8255285806419bbfe60e349307e71a',
                  },
                ).then((value) {
                  print(value.data['articles'][0]['title']);
                });
              },
              child: const Icon(
                Icons.add
              ),
            ),
            body: cubit.screens[cubit.currentIndex],
          );
        },
      ),
    );
  }
}
