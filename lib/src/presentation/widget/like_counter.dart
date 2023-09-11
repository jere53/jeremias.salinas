import 'package:flutter/material.dart';

import '../../core/util/ui_constants.dart';

class LikeCounter extends StatefulWidget {
  static const double iconSize = UIConstants.posterSectionIconSize;
  static const String buttonText = 'Likes: ';

  const LikeCounter({super.key});

  @override
  State<StatefulWidget> createState() => _LikeCounterState();
}

class _LikeCounterState extends State<LikeCounter> {
  static const buttonTextStyle = TextStyle(
    color: Colors.white,
    fontWeight: FontWeight.bold,
    fontSize: 20,
  );
  int _likeCount = 0;

  _LikeCounterState();

  void _incrementLikes() {
    setState(() {
      _likeCount++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.topCenter,
      children: [
        InkWell(
          onTap: _incrementLikes,
          customBorder: const CircleBorder(),
          child: Ink(
            decoration: const BoxDecoration(
              color: Colors.redAccent,
              shape: BoxShape.circle,
            ),
            height: LikeCounter.iconSize,
            width: LikeCounter.iconSize,
            child: Align(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    textAlign: TextAlign.center,
                    LikeCounter.buttonText,
                    style: buttonTextStyle,
                  ),
                  Text(
                    textAlign: TextAlign.center,
                    '$_likeCount',
                    style: buttonTextStyle,
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
