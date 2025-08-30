import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class LikeButton extends StatefulWidget {
  const LikeButton({super.key});

  @override
  State<LikeButton> createState() => _LikeButtonState();
}

class _LikeButtonState extends State<LikeButton> {
  bool isLike = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          isLike = !isLike;
        });
      },
      child: Container(
        width: 36.r,
        height: 36.r,
        decoration: BoxDecoration(
          color: isLike ? Color(0x1919A551) : Color(0x199CA3AF),
          shape: BoxShape.circle,
        ),
        child: SvgPicture.asset(
          isLike ? 'assets/icons/selected_like.svg' : 'assets/icons/like.svg',
          fit: BoxFit.none,
        ),
      ),
    );
  }
}
