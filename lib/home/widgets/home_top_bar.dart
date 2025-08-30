import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class HomeTopBar extends StatelessWidget {
  const HomeTopBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 353.w,
      height: 48.h,
      padding: EdgeInsets.only(left: 6.w, right: 13.w),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SvgPicture.asset('assets/icons/meal.svg'),
          SizedBox(width: 6.5.w),
          Text(
            '오늘의 급식',
            style: TextStyle(
              fontSize: 24.sp,
              fontWeight: FontWeight.w700,
            ),
          ),
          const Spacer(),
          GestureDetector(
            child: SvgPicture.asset('assets/icons/bell.svg'),
          ),
          SizedBox(width: 26.h),
          GestureDetector(
            child: SvgPicture.asset('assets/icons/share.svg'),
          ),
        ],
      ),
    );
  }
}
