import 'package:flutter/material.dart';

class StarRating extends StatefulWidget {
  final int maxRating;
  final double rating;
  final Function(double) onRated;

  const StarRating({
    Key? key,
    required this.maxRating,
    required this.rating,
    required this.onRated,
  }) : super(key: key);

  @override
  _StarRatingState createState() => _StarRatingState();
}

class _StarRatingState extends State<StarRating> {
  double _currentRating = 0.0;

  @override
  void initState() {
    super.initState();
    _currentRating = widget.rating;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(
        widget.maxRating,
        (index) {
          bool isSelected = index < _currentRating;
          return MouseRegion(
            cursor: SystemMouseCursors.click,
            child: GestureDetector(
              onTap: () {
                setState(() {
                  _currentRating = index + 1.0;
                  widget.onRated(_currentRating);
                });
              },
              child: Icon(
                isSelected ? Icons.star : Icons.star_border,
                color: isSelected ? Colors.yellow[700] : Colors.grey[400],
              ),
            ),
            onEnter: (_) {
              setState(() {
                _currentRating = index + 1.0;
              });
            },
            onExit: (_) {
              setState(() {
                _currentRating = widget.rating;
              });
            },
          );
        },
      ),
    );
  }
}
