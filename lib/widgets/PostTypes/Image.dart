import 'package:draw/draw.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:reddite/utils/colors.dart';

class PostImage extends StatelessWidget {
  final Submission post;

  const PostImage({
    Key key,
    @required this.post,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: findNeededHeight(context),
      child: Image.network(
        post.preview[0].source.url.toString(),
        width: MediaQuery.of(context).size.width,
        fit: BoxFit.fitWidth,
        loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress == null)
            return child;
          return Center(
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(redditOrange),
              value: loadingProgress.expectedTotalBytes != null ? loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes : null,
            ),
          );
        },
      )
    );
  }

  double findNeededHeight(BuildContext context) {
    double width = post.preview[0].source.width.toDouble();
    double height = post.preview[0].source.height.toDouble();
    double screenWidth = MediaQuery.of(context).size.width;

    return (width < screenWidth) ?
      height * (screenWidth / width) :
      height / (width / screenWidth);
  }
}