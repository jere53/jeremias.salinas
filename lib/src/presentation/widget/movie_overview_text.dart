import 'package:flutter/material.dart';

import '../../core/util/ui_constants.dart';

class MovieOverviewText extends StatelessWidget {
  static const double sectionTitleTextSize = 24;
  static const double sectionTitlePadding = 2;
  static const double sectionBodyTextSize = 20;
  static const String overviewSectionTitle = 'Overview';

  const MovieOverviewText({
    super.key,
    required this.movieOverviewTxt,
  });

  final String movieOverviewTxt;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      //FIXME replace with a NestedScrollView
      child: SingleChildScrollView(
        child: IntrinsicHeight(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Expanded(
                child: Container(
                  width: double.infinity,
                  color: Theme.of(context).primaryColorLight,
                  child: const Text(
                    overviewSectionTitle,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: sectionTitleTextSize,
                      color: UIConstants.overviewSectionTextColor,
                    ),
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.all(sectionTitlePadding),
              ),
              Flexible(
                fit: FlexFit.tight,
                child: Text(
                  movieOverviewTxt,
                  style: const TextStyle(
                    fontSize: sectionBodyTextSize,
                    color: UIConstants.overviewSectionTextColor,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
