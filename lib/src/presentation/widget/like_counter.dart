import 'package:flutter/material.dart';

import '../../core/util/ui_constants.dart';

class LikeCounter extends StatefulWidget {
  static const double iconSize = UIConstants.posterSectionIconSize;
  static const String buttonText = 'Likes: ';

  const LikeCounter({super.key});

  @override
  State<StatefulWidget> createState() => LikeCounterState();
}

@visibleForTesting
class LikeCounterState extends State<LikeCounter> {
  static const buttonTextStyle = TextStyle(
    color: Colors.white,
    fontWeight: FontWeight.bold,
    fontSize: 20,
  );
  int likeCount = 0;

  LikeCounterState();

  void _incrementLikes() {
    setState(() {
      likeCount++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.topCenter,
      children: [
        Material(
          color: Theme.of(context).scaffoldBackgroundColor,
          child: InkWell(
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
                      '$likeCount',
                      style: buttonTextStyle,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
