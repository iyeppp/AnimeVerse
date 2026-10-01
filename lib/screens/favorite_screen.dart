import 'package:flutter/material.dart';

import '../data/dummy_data.dart';
import '../widgets/app_scaffold.dart';
import '../widgets/favorite_anime_card.dart';
import '../widgets/main_bottom_nav.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    // Untuk sementara seluruh data dummy ditampilkan sebagai daftar favorit.
    // Nanti diganti dengan data favorit yang tersimpan (local storage/Firebase).
    final favoriteAnimeList = DummyData.animeList;

    return AppScaffold(
      appBar: AppBar(
        title: Text(
          "Favorite Anime",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w800,
            fontSize: screenWidth * 0.06,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      bottomNavigationBar: const MainBottomNav(currentIndex: 1),
      body: Column(
        children: [
          SizedBox(height: screenHeight * 0.01),
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.symmetric(vertical: screenHeight * 0.01),
              itemCount: favoriteAnimeList.length,
              itemBuilder: (context, index) {
                final anime = favoriteAnimeList[index];
                return FavoriteAnimeCard(
                  title: anime.title,
                  genre: anime.genre,
                  rating: anime.rating,
                  imagePath: anime.imagePath,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
