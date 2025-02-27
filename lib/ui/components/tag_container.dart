import 'dart:math';
import 'package:flutter/material.dart';
import 'package:step_wise/core/constants/constants.dart';

class TagContainer extends StatelessWidget {
  final String tagTitle;
  final bool isInner;

  static final List<Color> _possibleColors = [
    const Color(0xFFFFD1DC),
    const Color(0xFFFFE4B5),
    const Color(0xFFFFFACD),
    const Color(0xFFB0E57C),
    const Color(0xFFB3E5FC),
    const Color(0xFFDABFFF),
    const Color(0xFFF5CBA7),
    const Color(0xFFFADADD),
    const Color(0xFFA7C7E7),
    const Color(0xFFF5DEB3),
  ];

  const TagContainer({Key? key, required this.tagTitle, required this.isInner})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Color bulletColor =
        _possibleColors[Random().nextInt(_possibleColors.length)];

    return Container(
      constraints: const BoxConstraints(
        minWidth: 80,
        maxWidth: 150,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: isInner
          ? innerTagContainerDecoration()
          : outerTagContainerDecoration(),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 10,
            height: 10,
            decoration: BoxDecoration(
              color: bulletColor,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 6),
          Flexible(
            child: Text(
              tagTitle,
              softWrap: true,
              maxLines: 3,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'Sora',
                fontWeight: FontWeight.w600,
                fontSize: 14,
                color: isInner ? Colors.black : Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
 
  }

  BoxDecoration outerTagContainerDecoration() {
    return BoxDecoration(
      color: secondaryColor,
      border: Border.all(color: primaryColor, width: 3),
      borderRadius: BorderRadius.circular(9999),
    );
  }

  BoxDecoration innerTagContainerDecoration() {
    return BoxDecoration(
      color: lightGreyColor,
      borderRadius: BorderRadius.circular(8),
    );
  }
}
