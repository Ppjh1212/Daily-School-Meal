import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_neis/flutter_neis.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:neis_school_meal/home/screen/home_screen.dart';

void main() async {
  await dotenv.load();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  Future<void> loadTodayMealData() async {
    final neis = Neis(apiKey: 'f24e6fd436574b9484f47266ee09da38');
    await neis.loadSchoolInfo('광주소프트웨어마이스터고등학교');
    await neis.meal.client
        .fetchMeals(
          // officeCode: dotenv.env['office_code']!,
          // schoolCode: dotenv.env['school_code']!,
          officeCode: 'F10',
          schoolCode: '7380292',
          date: '20250828',
        )
        .then(
          (value) => log('result = ${value[0].dishes[0]}'),
        );
  }

  @override
  Widget build(BuildContext context) {
    // loadTodayMealData();
    return ScreenUtilInit(
      designSize: const Size(393, 852),
      child: MaterialApp(
        title: 'Neis School Meal',
        home: HomeScreen(),
      ),
    );
  }
}
