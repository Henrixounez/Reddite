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
    String url = post.preview.length > 0 ?
      post.preview[0].source.url.toString() :
      post.url.toString();
    return Container(
      height: findNeededHeight(context),
      child: Image.network(
        url,
        width: MediaQuery.of(context).size.width,
        fit: BoxFit.fitWidth,
        loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress == null)
            return child;
          return Center(
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(colorTheme.primary),
              value: loadingProgress.expectedTotalBytes != null ? loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes : null,
            ),
          );
        },
      )
    );
  }

  double findNeededHeight(BuildContext context) {
    bool hasPreview = post.preview.length > 0;
    double width = hasPreview ? post.preview[0].source.width.toDouble() : (post.data['thumbnail_height'] as int).toDouble();
    double height = hasPreview ? post.preview[0].source.height.toDouble() : (post.data['thumbnail_width'] as int).toDouble();
    double screenWidth = MediaQuery.of(context).size.width;

    return (width < screenWidth) ?
      height * (screenWidth / width) :
      height / (width / screenWidth);
  }
}