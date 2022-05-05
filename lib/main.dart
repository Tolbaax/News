import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news365/shared/cubit/cubit.dart';
import 'package:news365/shared/cubit/states.dart';
import 'package:news365/shared/network/local/cache_helper.dart';
import 'package:news365/shared/network/remote/dio_helper.dart';
import 'package:news365/shared/styles/theme.dart';
import 'layout/home_screen.dart';

void main() async
{
  //make sure that everything in methode is finished, then open the a
  WidgetsFlutterBinding.ensureInitialized();
  DioHelper.init();
  await CacheHelper.init();
  bool isDark = CacheHelper.getBoolean(key: 'isDark');
  BlocOverrides.runZoned(() {
    NewsCubit();
    runApp(MyApp(isDark));
  },
    // blocObserver: MyBlocObserver(),
  );
}

class MyApp extends StatelessWidget {

  final bool isDark;
  MyApp(this.isDark);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => NewsCubit()..getScience()..getSports()..getBusiness()..changeAppMode(
        fromShared: isDark,
      ),
      child: BlocConsumer<NewsCubit,NewsStates>(
        listener: (context, state) {} ,
        builder: (context, state) {
          return  MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: light,
            darkTheme: dark,
            themeMode: NewsCubit.get(context).isDark? ThemeMode.dark : ThemeMode.light,
            home: const HomeScreen(),
          );
        } ,
      ),
    );
  }
}
