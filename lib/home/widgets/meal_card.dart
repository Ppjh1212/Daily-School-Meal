import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_neis/flutter_neis.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:neis_school_meal/home/widgets/meal.dart';

class MealCard extends StatefulWidget {
  const MealCard({super.key});

  @override
  State<MealCard> createState() => _MealCardState();
}

class _MealCardState extends State<MealCard> {
  late final PageController controller;
  late final Neis neis;
  List<MealInfo>? meal;

  @override
  void initState() {
    super.initState();
    final today = DateTime.now();
    loadTodayMealData(today: today);

    final time = int.parse('${today.hour}${today.minute}');
    late final int initialPage;
    final int breakfast = 730;
    final int lunch = 1230;

    if (time > 0 && time < breakfast) initialPage = 0;
    if (time > breakfast && time < lunch) initialPage = 1;
    if (time > lunch) initialPage = 2;

    controller = PageController(initialPage: initialPage);
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  Future<void> loadTodayMealData({required DateTime today}) async {
    neis = Neis(apiKey: dotenv.env['api_key']!);
    await neis.loadSchoolInfo('광주소프트웨어마이스터고등학교');
    String todayToString = today.toString();
    todayToString =
        '${todayToString.substring(0, 4)}${todayToString.substring(5, 7)}${todayToString.substring(8, 10)}';
    meal = await neis.meal.client.fetchMeals(
      officeCode: dotenv.env['office_code']!,
      schoolCode: dotenv.env['school_code']!,
      date: todayToString,
    );
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 562.h,
      child: PageView(
        controller: controller,
        children: [
          Meal.breakFast(dishes: meal?[0].dishes),
          Meal.lunch(dishes: meal?[1].dishes),
          Meal.dinner(dishes: meal?[2].dishes),
        ],
      ),
    );
  }
}
