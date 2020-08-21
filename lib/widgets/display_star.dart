import 'package:dancer/screens/private/ranking.dart';
import 'package:dancer/screens/private/ranking_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:dancer/globals.dart';
import 'package:dancer/graphql/private.dart' as gql;
import 'package:dancer/graphql/models/user.dart';
import 'package:dancer/thirdparty/flutter_awesome_alert_box.dart';

import 'fade_transition.dart';

class StarDisplay extends StatelessWidget {
  final User teacher;
  final bool votable;

  const StarDisplay({Key key, this.teacher, this.votable})
      : assert(teacher != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    if (!votable || teacher.isTeacher()) {
      return RatingBarIndicator(
        rating: teacher.ranking.toInt().toDouble(),
        itemBuilder: (context, index) => Icon(
          Icons.star,
          color: Colors.black,
        ),
        itemCount: 5,
        itemSize: 24,
        direction: Axis.horizontal,
      );
    }

    return RatingBar(
      initialRating: 0,
      minRating: 0,
      direction: Axis.horizontal,
      allowHalfRating: false,
      itemCount: 5,
      itemSize: 24,
      itemPadding: EdgeInsets.symmetric(horizontal: 0.0),
      unratedColor: Colors.grey,
      tapOnlyMode: true,
      ratingWidget: RatingWidget(
        full: Icon(Icons.star),
        half: Icon(Icons.star),
        empty: Icon(Icons.star_border),
      ),
      onRatingUpdate: (rating) async {
        ConfirmAlertBox(
          context: context,
          infoMessage: "",
          title: "for ${teacher.firstName}",
          //icon: Icon(Icons.school, color: Color(0xffBF8A2A)),
          icons: Row(
            children: List.generate(5, (index) {
              return Icon(
                index < rating ? Icons.star : Icons.star_border,
              );
            }),
          ), //Icons.star,
          onPressedYes: () async {
            final r = await gql.Private.rankTeacher(teacher.id, rating.toInt());
            if (r.hasException) {
              print("error voting: ${r.exception.graphqlErrors[0].message}");
              Navigator.pop(context);
              return;
            }

            print("vote: ${r.data}");
            Navigator.pop(context);
            Navigator.push(context, FadeRoute(page: RankingWrapper()));
          },
          onPressedNo: () { Navigator.pop(context); },
          buttonTextForYes: "Vote",
          buttonColorForYes: Color(0xffBF8A2A),
          buttonTextForNo: "Cancel",
          buttonColorForNo: Colors.black,
          buttonTextColorForYes: Colors.black,
        );
      },
    );

    /*return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(5, (index) {
        return Icon(
          index < value ? Icons.star : Icons.star_border,
        );
      }),
    );*/
  }
}