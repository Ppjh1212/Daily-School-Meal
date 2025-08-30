import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:neis_school_meal/home/widgets/date_swipe.dart';
import 'package:neis_school_meal/home/widgets/home_top_bar.dart';
import 'package:neis_school_meal/home/widgets/meal_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(
                left: 20.w,
                right: 20.w,
                top: 57.h,
              ),
              child: Column(
                children: [
                  const HomeTopBar(),
                  SizedBox(height: 34.h),
                  const DateSwipe(),
                ],
              ),
            ),
            SizedBox(height: 14.h),
            const MealCard(),
          ],
        ),
      ),
    );
  }
}