import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news365/modules/business_screen.dart';
import 'package:news365/modules/science_screen.dart';
import 'package:news365/modules/sports_screen.dart';
import 'package:news365/shared/cubit/states.dart';
import 'package:news365/shared/network/local/cache_helper.dart';
import '../network/remote/dio_helper.dart';

class NewsCubit extends Cubit<NewsStates> {
  NewsCubit() : super(NewsInitialState());

  static NewsCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;

  List<Widget> screens = const [
    BusinessScreen(),
    SportsScreen(),
    ScienceScreen(),
  ];

  List<BottomNavigationBarItem> bottomItems = const [
    BottomNavigationBarItem(
      icon: Icon(
        Icons.business,
      ),
      label: 'Business',
    ),
    BottomNavigationBarItem(
      icon: Icon(
        Icons.sports,
      ),
      label: 'Sports',
    ),
    BottomNavigationBarItem(
      icon: Icon(
        Icons.science,
      ),
      label: 'Science',
    ),
  ];

  ///====================================================

  List<dynamic> business = [];

  void getBusiness()
  {
    emit(NewsGetBusinessLoadingState());
    DioHelper.getData(
      url: 'v2/top-headlines',
      query: {
        'country': 'eg',
        'category': 'business',
        'apikey': '5d8255285806419bbfe60e349307e71a',
      },
    ).then((value) {
      business = value.data['articles'];
      emit(NewsGetBusinessSuccessState());
    });
  }

  ///====================================================

  List<dynamic> sports = [];

  void getSports()
  {
    emit(NewsGetSportsLoadingState());
    DioHelper.getData(
      url: 'v2/top-headlines',
      query: {
        'country': 'eg',
        'category': 'sports',
        'apikey': '5d8255285806419bbfe60e349307e71a',
      },
    ).then((value) {
      sports = value.data['articles'];
      emit(NewsGetSportsSuccessState());
    });
  }

  ///====================================================

  List<dynamic> science = [];


  void getScience()
  {
    emit(NewsGetScienceLoadingState());
    DioHelper.getData(
      url: 'v2/top-headlines',
      query: {
        'country': 'eg',
        'category': 'science',
        'apikey': '5d8255285806419bbfe60e349307e71a',
      },
    ).then((value) {
      science = value.data['articles'];
      emit(NewsGetScienceSuccessState());
    });
  }

  ///====================================================

  changeBottomNavBar(int index)
  {
    currentIndex = index;
    emit(NewsBottomNavState());
  }

  bool isDark = false;

  void changeAppMode({bool? fromShared})
  {
    if(fromShared != null)
    {
      isDark = fromShared;
      emit(AppChangeModeState());
    }
    else
      {
        isDark = !isDark;
        CacheHelper.putBoolean(key: 'isDark', value: isDark).then((value) {
          emit(AppChangeModeState());
        });
      }
  }

}
