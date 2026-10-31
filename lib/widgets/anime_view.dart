import 'package:flutter/material.dart';

import '../models/anime.dart';
import 'anime_card.dart';

class AnimeView extends StatelessWidget {
  final List<Anime> animelist;

  const AnimeView({super.key, required this.animelist});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: MediaQuery.of(context).size.width * 0.04,
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          int crossAxisCount;
          double childAspectRatio;
          if (constraints.maxWidth < 600) {
            crossAxisCount = 3;
            childAspectRatio = 0.55;
          } else if (constraints.maxWidth < 900) {
            crossAxisCount = 5;
            childAspectRatio = 0.6;
          } else {
            crossAxisCount = (constraints.maxWidth / 200).floor().clamp(4, 6);
            childAspectRatio = 0.8;
          }
          return GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: crossAxisCount,
              mainAxisSpacing: constraints.maxWidth * 0.03,
              crossAxisSpacing: constraints.maxWidth * 0.05,
              childAspectRatio: childAspectRatio,
            ),
            itemCount: animelist.length,
            itemBuilder: (context, index) {
              final anime = animelist[index];
              // AnimeCard sudah handle navigasi via GoRouter secara internal
              return AnimeCard(
                id: anime.id,
                title: anime.title,
                imagePath: anime.imagePath,
              );
            },
          );
        },
      ),
    );
  }
}
