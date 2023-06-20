import 'package:doctor/lab/lab_review/api_lab_review/api_lab_review.dart';
import 'package:flutter/material.dart';
import 'package:smooth_star_rating_null_safety/smooth_star_rating_null_safety.dart';

import '../../styles/colors.dart';

class ReviewDialog extends StatefulWidget {
  const ReviewDialog(this.id, {super.key});

  final int id;

  @override
  _ReviewDialogState createState() => _ReviewDialogState();
}

class _ReviewDialogState extends State<ReviewDialog> {
  double _rating = 0.0;
  String _reviewText = '';

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Write a review'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SmoothStarRating(
            rating: _rating,
            // size: 20,
            filledIconData: Icons.star,
            halfFilledIconData: Icons.star_half,
            defaultIconData: Icons.star_border_rounded,

            starCount: 5,

            allowHalfRating: false,
            spacing: 5,
            color: Colors.amber,
            onRatingChanged: (value) {
              setState(() {
                _rating = value;
              });
            },
          ),
          SizedBox(height: 16),
          TextField(
            maxLines: 3,
            decoration: InputDecoration(
              hintText: 'Write your review here',
            ),
            onChanged: (value) {
              setState(() {
                _reviewText = value;
              });
            },
          ),
        ],
      ),
      actions: [
        TextButton(
          style: ButtonStyle(
            // Set the background color
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text('Cancel',style: TextStyle(color:Colors.red),),
        ),
        ElevatedButton(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(defaultColor), // Set the background color
          ),
          onPressed: () {
            int intValue = _rating.truncate();
            apireviews.postReview(_reviewText, widget.id, intValue);
            Navigator.of(context).pop();
          },
          child: Text('Submit'),
        ),
      ],
    );
  }
}
