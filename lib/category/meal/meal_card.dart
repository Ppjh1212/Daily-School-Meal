import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_neis/flutter_neis.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:neis_school_meal/category/meal/meal.dart';

class MealCard extends StatefulWidget {
  const MealCard({super.key});

  @override
  State<MealCard> createState() => _MealCardState();
}

class _MealCardState extends State<MealCard> {
  late final PageController _controller;
  List<MealInfo>? meal;
  late double height;
  DateType? dateType;

  @override
  void initState() {
    super.initState();
    final today = DateTime.now();
    loadTodayMealData(today: today);
    _controller = PageController(initialPage: initialPage(today: today));
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  int initialPage({required DateTime today}) {
    final time = int.parse('${today.hour}${today.minute}');
    late final int initialPage;
    final int breakfast = 730;
    final int lunch = 1230;

    if (time > lunch) {
      initialPage = 2;
    } else if (time > breakfast) {
      initialPage = 1;
    } else {
      initialPage = 0;
    }
    return initialPage;
  }

  Future<void> loadTodayMealData({required DateTime today}) async {
    late final Neis neis = Neis(apiKey: dotenv.env['api_key']!);
    await neis.loadSchoolInfo('광주소프트웨어마이스터고등학교');
    String todayToString = today.toString();
    todayToString =
        '${todayToString.substring(0, 4)}${todayToString.substring(5, 7)}${todayToString.substring(8, 10)}';
    meal = await neis.meal.client.fetchMeals(
        officeCode: dotenv.env['office_code']!,
        schoolCode: dotenv.env['school_code']!,
        // date: todayToString,
        date: '20250922');
    setState(() {});
  }

  void checkHeight() {
    try {
      final List<int?> meals = [
        meal?[0].dishes.length,
        meal?[1].dishes.length,
        meal?[2].dishes.length,
      ];
      if (meal != null) {
        meals.sort();
      }

      switch (meals.last) {
        case 6:
          setState(() {
            height = 502.h;
          });
          break;
        case 7:
          setState(() {
            height = 562.h;
          });
          break;
        case 8:
          setState(() {
            height = 622.h;
          });
          break;
        default:
          setState(() {
            height = 502.h;
          });
          break;
      }
    } on RangeError catch (_) {
      height = 500.h;
    }
  }

  checkDateType() {
    try {
      meal?[0];
      meal?[1];
      meal?[2];
      dateType = DateType.weekdays;
    } on RangeError catch (e) {
      switch (e.invalidValue!.toInt()) {
        case 0:
          dateType = DateType.publicHolidays;
          break;
        case 2:
          dateType = DateType.friday;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    checkDateType();
    checkHeight();
    return SizedBox(
      width: double.infinity,
      height: height,
      child: PageView(
        controller: _controller,
        children: [
          Meal.breakFast(dishes: meal?[0].dishes),
          Meal.lunch(dishes: meal?[1].dishes),
          Meal.dinner(dishes: meal?[2].dishes),
        ],
      ),
    );
  }
}

enum DateType {
  weekdays,
  friday,
  publicHolidays,
}
