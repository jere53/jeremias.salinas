import 'package:flutter/material.dart';

import '../../core/util/constants.dart' as constants;
import '../../core/util/data_state.dart';
import '../../domain/entity/genre.dart';

class GenreDrawer extends StatelessWidget {
  const GenreDrawer({
    super.key,
    required this.futureValidGenreList,
  });

  final Future<DataState<List<Genre>>> futureValidGenreList;
  static const double drawerTitleFontSize = 40;
  static const double listPadding = 2;

  List<Widget> _buildDrawerItems(
    BuildContext context,
    List<Genre> validGenres,
  ) {
    return validGenres
        .map(
          (genre) => Material(
            child: InkWell(
              onTap: () {
                Navigator.pushNamed(
                  context,
                  constants.genreAppRoute,
                  arguments: genre,
                );
              },
              child: _buildDrawerCard(
                genre.name,
              ),
            ),
          ),
        )
        .toList();
  }

  Widget _buildDrawerCard(String title) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(),
        color: Colors.blueGrey.shade800,
      ),
      width: double.infinity,
      child: Text(
        title,
        style: const TextStyle(
          fontSize: drawerTitleFontSize,
          fontWeight: FontWeight.bold,
          color: Colors.white70,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).dialogBackgroundColor,
      child: FutureBuilder<DataState<List<Genre>>>(
        future: futureValidGenreList,
        builder: (
          BuildContext context,
          AsyncSnapshot<DataState> snapshot,
        ) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          }

          if (!snapshot.hasData) {
            return const Text('no genre data');
          }

          if (snapshot.data is DataSuccess) {
            return ListView(
              padding: const EdgeInsets.all(listPadding),
              children: _buildDrawerItems(context, snapshot.data!.data),
            );
          }
          if (snapshot.data is DataFailed) {
            return Text('Error fetching genre data ${snapshot.data!.error}');
          }

          return const Placeholder();
        },
      ),
    );
  }
}
