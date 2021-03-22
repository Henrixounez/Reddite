import 'package:draw/draw.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

import 'package:reddite/states/auth.dart';
import 'package:reddite/states/posts_state.dart';
import 'package:reddite/utils/colors.dart';
import 'package:reddite/utils/styles.dart';
import 'package:reddite/widgets/Button.dart';
import 'package:reddite/widgets/CommentContent.dart';
import 'package:reddite/widgets/Post.dart';
import 'package:reddite/widgets/Scaffold.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration.zero, () async {
      postsStore.loadProfilePosts();
    });

    return WillPopScope(
      onWillPop: () async {
        postsStore.loadPosts();
        return true;
      },
      child: RedditeScaffold(
        extendBodyBehindAppBar: true,
        showFab: false,
        customNavbar: AppBar(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () async {
              postsStore.loadPosts();
              Navigator.pop(context);
            }
          ),
        ),
        body: StreamBuilder(
          stream: postsStore.streamController.stream,
          builder: (context, snapshot) {
            return snapshot.hasData ?
              CustomScrollView(
                controller: postsStore.scrollController,
                slivers: [
                  profileInfos(context),
                  postList(),
                ],
              )
            : loading();
          }
        ),
      )
    );
  }

  Widget postList() {
    return  SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          bool loadMore = (index > postsStore.contents.length - 10);
          if (loadMore && !postsStore.isLoading) {
            postsStore.loadProfilePosts(loadMore: true);
          }
          if (postsStore.contents[index] is Submission) {
            Submission post = postsStore.contents[index];
            return Post(
              post: post,
            );
          } else {
            Comment comment = postsStore.contents[index];
            return CommentContent(comment: comment);
          }
        },
        childCount: postsStore.contents.length
      )
    );
  }

  Widget profileInfos(BuildContext context) {
    double iconSize = 150;

    return SliverToBoxAdapter(
      child: Stack(
        children: [
          Column(
            children: [
              Container(
                height: 180,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.center,
                    colors: [
                      colorTheme.secondary,
                      colorTheme.primary,
                    ]
                  )
                ),
              ),
              Container(
                height: 150,
                padding: EdgeInsets.only(top: 30),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('u/${authStore.me.displayName}', style: fontMedium.copyWith(color: colorTheme.secondaryText, fontSize: 25))
                  ],
                ),
              )
            ],
          ),
          Positioned(
            left: (MediaQuery.of(context).size.width / 2) - (iconSize / 2),
            top: 150 - (iconSize / 2),
            child: ProfilePicker(iconSize: iconSize)
          )
        ],
      ),
    );
  }

  Widget loading() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }
}

class ProfilePicker extends StatefulWidget {

  ProfilePicker({
    Key key,
    @required this.iconSize,
  }) : super(key: key);

  final double iconSize;

  @override
  _ProfilePickerState createState() => _ProfilePickerState();
}

class _ProfilePickerState extends State<ProfilePicker> {
  final ImagePicker _picker = ImagePicker();

  void _getImg(bool fromCamera) async {
    try {
      final pickedFile = await _picker.getImage(
        source: fromCamera ? ImageSource.camera : ImageSource.gallery,
        imageQuality: 20,
      );

      Navigator.of(context).pop();

      final croppedFile = await ImageCropper.cropImage(
        sourcePath: pickedFile.path,
        aspectRatioPresets: [CropAspectRatioPreset.square],
        androidUiSettings: AndroidUiSettings(
          toolbarTitle: 'Crop Image',
          toolbarColor: colorTheme.primary,
          toolbarWidgetColor: colorTheme.icon,
          initAspectRatio: CropAspectRatioPreset.original,
          lockAspectRatio: true
        ),
        iosUiSettings: IOSUiSettings(title: 'Crop'),
        maxHeight: 256,
        maxWidth: 256
      );

      Subreddit userSubreddit = await authStore.reddit.subreddit(authStore.me.path.replaceAll('user/', 'u_').replaceAll('/', '')).populate();
      await userSubreddit.stylesheet.uploadMobileIcon(
        imagePath: Uri.file(croppedFile.path)
      );
      await authStore.refreshMe();
    } catch (error) {
      print(error);
    }
  }

  void _showPicker(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) => Container(
        height: 120,
        margin: EdgeInsets.symmetric(horizontal: 5),
        padding: EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
          color: colorTheme.secondaryBg,
          borderRadius: BorderRadius.vertical(top: Radius.circular(10))
        ),
        child: Column(
          children: [
            ListTile(
              leading: Icon(Icons.photo_library, color: colorTheme.icon),
              title: Text('From Gallery', style: fontBook.copyWith(color: colorTheme.primaryText)),
              onTap: () => _getImg(false)
            ),
            ListTile(
              leading: Icon(Icons.photo_camera, color: colorTheme.icon),
              title: Text('From Camera', style: fontBook.copyWith(color: colorTheme.primaryText)),
              onTap: () => _getImg(true)
            )
          ],
        )
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    return Observer(
        builder: (_) => Container(
          height: widget.iconSize,
          width: widget.iconSize,
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(
            shape: BoxShape.circle
          ),
          child: RedditeButton(
            onPressed: () => _showPicker(context),
            child: authStore.me.icon != null ?
              Image.network(
                '${authStore.me.icon}',
                width: widget.iconSize,
                height: widget.iconSize,
                fit: BoxFit.contain
              ) :
              SizedBox.fromSize(size: Size(widget.iconSize, widget.iconSize)),
        )
      )
    );
  }
}