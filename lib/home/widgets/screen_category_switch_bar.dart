import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:neis_school_meal/provider/screen_category_provider.dart';
import 'package:provider/provider.dart';

class ScreenCategorySwitchBar extends StatefulWidget {
  const ScreenCategorySwitchBar({super.key});

  @override
  State<ScreenCategorySwitchBar> createState() =>
      _ScreenCategorySwitchBarState();
}

class _ScreenCategorySwitchBarState extends State<ScreenCategorySwitchBar> {
  Widget categorys(ScreenCategory screenCategory) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
      width: 353.w,
      height: 58.h,
      decoration: BoxDecoration(
        color: Color(0xFFF9FAFB),
        borderRadius: BorderRadius.circular(32),
      ),
      child: Stack(
        children: [
          AnimatedAlign(
            alignment: screenCategory == ScreenCategory.meal
                ? Alignment.centerLeft
                : screenCategory == ScreenCategory.allergy
                    ? Alignment.center
                    : Alignment.centerRight,
            duration: const Duration(milliseconds: 500),
            curve: Curves.easeInOut,
            child: Container(
              width: 105.w,
              height: 50.h,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(32),
              ),
            ),
          ),
          Row(
            children: [
              category(screenCategory, ScreenCategory.meal),
              SizedBox(width: 10.w),
              category(screenCategory, ScreenCategory.allergy),
              SizedBox(width: 10.w),
              category(screenCategory, ScreenCategory.etc),
            ],
          ),
        ],
      ),
    );
  }

  Widget category(
      ScreenCategory currentScreenCategory, ScreenCategory screenCategory) {
    String name;
    switch (screenCategory) {
      case ScreenCategory.meal:
        name = "급식";
      case ScreenCategory.allergy:
        name = "알레르기";
      case ScreenCategory.etc:
        name = "기타";
    }
    return GestureDetector(
      onTap: () =>
          context.read<ScreenCategoryProvider>().switchCategory(screenCategory),
      child: Container(
        width: 105.w,
        height: 50.h,
        decoration: ShapeDecoration(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(32),
          ),
          color: currentScreenCategory == screenCategory
              ? Colors.white
              : Color(0xFFF9FAFB),
          shadows: currentScreenCategory == screenCategory
              ? [
                  BoxShadow(
                    color: Color(0x19000000),
                    blurRadius: 13.3,
                    offset: Offset(0, 0),
                    spreadRadius: 0,
                  )
                ]
              : null,
        ),
        alignment: Alignment.center,
        child: Text(
          name,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ScreenCategoryProvider>(
      builder: (context, value, child) {
        final screenCategory = context.watch<ScreenCategoryProvider>().category;
        return categorys(screenCategory);
      },
    );
  }
}
