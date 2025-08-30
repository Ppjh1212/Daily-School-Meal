import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class StarButton extends StatefulWidget {
  const StarButton({super.key});

  @override
  State<StarButton> createState() => _StarButtonState();
}

class _StarButtonState extends State<StarButton> {
  bool isCheck = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          isCheck = !isCheck;
        });
      },
      child: SvgPicture.asset(
        isCheck ? 'assets/icons/selected_star.svg' : 'assets/icons/star.svg',
      ),
    );
  }
}
