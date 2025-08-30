import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_neis/flutter_neis.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:neis_school_meal/home/widgets/dislike_button.dart';
import 'package:neis_school_meal/home/widgets/like_button.dart';
import 'package:neis_school_meal/home/widgets/star_button.dart';

class Meal extends StatefulWidget {
  const Meal({
    super.key,
    required this.timeZone,
    required this.mealTime,
    required this.index,
  });
  final String timeZone;
  final String mealTime;
  final int index;

  factory Meal.breakFast() {
    return Meal(
      timeZone: '아침',
      mealTime: '07:30',
      index: 0,
    );
  }

  factory Meal.lunch() {
    return Meal(
      timeZone: '점심',
      mealTime: '12:30',
      index: 1,
    );
  }

  factory Meal.dinner() {
    return Meal(
      timeZone: '저녘',
      mealTime: '18:30',
      index: 2,
    );
  }

  @override
  State<Meal> createState() => _MealState();
}

class _MealState extends State<Meal> with AutomaticKeepAliveClientMixin{
  late final Neis neis;
  List<MealInfo> meal = [];

  @override
  void initState() {
    super.initState();
    neis = Neis(apiKey: dotenv.env['api_key']!);
    loadTodayMealData();
  }


  Future<void> loadTodayMealData() async {
    await neis.loadSchoolInfo('광주소프트웨어마이스터고등학교');
    meal = await neis.meal.client.fetchMeals(
      officeCode: dotenv.env['office_code']!,
      schoolCode: dotenv.env['school_code']!,
      date: '20250828',
    );
    setState(() {});
  }

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 20,
      ),
      width: double.infinity,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Color(0x19000000),
              blurRadius: 13,
              offset: Offset(0, 0),
              spreadRadius: 0,
            ),
          ],
        ),
        width: 353.w,
        height: 460.h,
        child: Column(
          children: [
            SizedBox(
              width: 306.w,
              height: 59.h,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      Text(
                        widget.timeZone,
                        style: TextStyle(
                          fontSize: 20.sp,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      SizedBox(height: 8.h),
                      Text(
                        widget.mealTime,
                        style: TextStyle(
                          color: Color(0xFF6B7280),
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      const LikeButton(),
                      SizedBox(width: 12.w),
                      const DislikeButton(),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 10.h),
            Expanded(
              child: ListView.separated(
                physics: const NeverScrollableScrollPhysics(),
                itemCount: meal.isEmpty ? 7 : meal[widget.index].dishes.length,
                separatorBuilder: (context, index) => SizedBox(height: 12.h),
                itemBuilder: (context, index) => Container(
                  padding: EdgeInsets.symmetric(horizontal: 12.w),
                  width: 306.w,
                  height: 48.h,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: meal.isEmpty ? Color(0xFFF9FAFB) : null,
                  ),
                  child: meal.isEmpty
                      ? const SizedBox.shrink()
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              meal[widget.index].dishes[index],
                              style: TextStyle(
                                color: Color(0xFF374151),
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            const StarButton(),
                          ],
                        ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
