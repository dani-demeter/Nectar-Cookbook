import 'package:flutter/material.dart';
import '../main.dart';

class Ratings extends StatefulWidget {
  void Function(int) setNewRatingCallback;
  int rating;
  List<bool> isSelected = List.filled(5, false);
  Ratings(this.setNewRatingCallback, this.rating) {
    for (var i = 0; i < 5; i++) {
      isSelected[i] = i < rating;
    }
  }

  @override
  State<Ratings> createState() => _RatingsState();
}

class _RatingsState extends State<Ratings> {
  @override
  Widget build(BuildContext context) {
    List<Widget> starsList = [];
    List<Widget> emptyStarsList = [];
    for (var i = 0; i < 5; i++) {
      if (i < widget.rating) {
        starsList.add(Icon(
          Icons.star,
          color: mint,
        ));
      } else {
        emptyStarsList.add(Icon(Icons.star_border, color: mint));
      }
    }
    return ToggleButtons(
      constraints: BoxConstraints(maxWidth: appConfig['blockSize'] * 20),
      selectedBorderColor: Colors.transparent,
      borderColor: Colors.transparent,
      fillColor: Colors.transparent,
      splashColor: Colors.transparent,
      children: starsList + emptyStarsList,
      isSelected: widget.isSelected,
      onPressed: (int index) {
        setState(() {
          widget.rating = index + 1;
          widget.setNewRatingCallback(index + 1);
          for (var i = 0; i < 5; i++) {
            widget.isSelected[i] = i < widget.rating;
          }
        });
      },
    );
  }
}

class Favorited extends StatefulWidget {
  void Function(bool) setFavoriteCallback;
  bool isFavorite;
  Favorited(this.setFavoriteCallback, this.isFavorite);

  @override
  State<Favorited> createState() => _FavoritedState();
}

class _FavoritedState extends State<Favorited> {
  @override
  Widget build(BuildContext context) {
    return IconButton(
        icon: Icon(
            widget.isFavorite ? Icons.favorite : Icons.favorite_border_rounded,
            color: mint),
        onPressed: () => setState(() {
              widget.isFavorite = !widget.isFavorite;
              widget.setFavoriteCallback(widget.isFavorite);
            }));
  }
}
