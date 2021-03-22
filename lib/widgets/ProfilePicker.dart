import 'package:draw/draw.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:reddite/states/auth.dart';
import 'package:reddite/utils/colors.dart';
import 'package:reddite/utils/styles.dart';

import 'package:reddite/widgets/Button.dart';

// Profile Picker
//
// Shows connected user's Profile Picture
// and allows to change it with a new picture from Gallery or Camera

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

  // Get Image from Camera or Gallery, crops it to 256x256 and sends it to Reddit
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

  // Show Modal Bottom Sheet to select to get Image from Gallery or Camera
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