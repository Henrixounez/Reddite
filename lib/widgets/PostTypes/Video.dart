import 'package:better_player/better_player.dart';
import 'package:draw/draw.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:video_provider/video_provider.dart';

// Post Video
//
// Shows a Video from a Post

class PostVideo extends StatefulWidget {
  final Submission post;
  final bool isGif;

  PostVideo({
    Key key,
    @required this.post,
    this.isGif = false
  }) : super(key: key);

  @override
  _PostVideoState createState() => _PostVideoState();
}

class _PostVideoState extends State<PostVideo> {
  Uri videoUrl;

  // We initialize VideoProvider with the URL of the Video of the Post
  @override
  void initState() {
    super.initState();

    videoUrl = !widget.isGif ? 
      widget.post.url :
      VideoProvider.fromUri(widget.post.url).getVideos().first.uri;
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: BetterPlayerListVideoPlayer(
        BetterPlayerDataSource(
          BetterPlayerDataSourceType.network,
          videoUrl.toString(),
        ),
        configuration: BetterPlayerConfiguration(
          fit: BoxFit.fitHeight,
          aspectRatio: 16/9,
          controlsConfiguration: BetterPlayerControlsConfiguration(
            showControlsOnInitialize: false
          )
        ),
        key: Key(widget.hashCode.toString()),
        playFraction: 0.8,
      ),
    );
  }
}