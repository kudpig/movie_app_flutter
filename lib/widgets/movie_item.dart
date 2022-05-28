import 'package:flutter/material.dart';
import '../screens/movie_detail_screen.dart';

class MovieItem extends StatelessWidget {
  final int id;
  final String imageUrl;
  final String title;

  const MovieItem(
    this.id,
    this.imageUrl,
    this.title,
  );

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: GridTile(
        child: Image.network(
          imageUrl,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) {
            return Container(
              color: Colors.white,
              child: LayoutBuilder(builder: (context, constraints) {
                return Icon(
                  Icons.error,
                  color: Colors.red,
                  size: constraints.biggest.width,
                );
              }),
            );
          },
        ),
        footer: GridTileBar(
          backgroundColor: Colors.black54,
          title: Text(
            title,
            textAlign: TextAlign.start,
          ),
        ),
      ),
      onTap: () {
        Navigator.of(context)
            .pushNamed(MovieDetailScreen.routeName, arguments: id);
      },
    );
  }
}
