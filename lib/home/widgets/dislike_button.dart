import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class DislikeButton extends StatefulWidget {
  const DislikeButton({super.key});

  @override
  State<DislikeButton> createState() => _DislikeButtonState();
}

class _DislikeButtonState extends State<DislikeButton> {
  bool isDislike = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          isDislike = !isDislike;
        });
      },
      child: Container(
        width: 36.r,
        height: 36.r,
        decoration: BoxDecoration(
          color: isDislike ? Color(0xFFFEE2E2) : Color(0x199CA3AF),
          shape: BoxShape.circle,
        ),
        child: SvgPicture.asset(
          isDislike
              ? 'assets/icons/selected_dislike.svg'
              : 'assets/icons/dislike.svg',
          fit: BoxFit.none,
        ),
      ),
    );
  }
}
