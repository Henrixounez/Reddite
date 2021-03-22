import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:reddite/states/posts_state.dart';
import 'package:reddite/utils/colors.dart';
import 'package:reddite/utils/styles.dart';

// Sort Bar
//
// Used in main Subreddit View as a SliverAppBar
// Allows to select a sorting for the Subreddit
// Hot/New/Top/Controversial/Rising

class SortBar extends StatefulWidget {
  SortBar({Key key}) : super(key: key);

  @override
  _SortBarState createState() => _SortBarState();
}

class _SortBarState extends State<SortBar> {
  Map<String, IconData> icons = {
    'hot': Icons.local_fire_department,
    'new': Icons.new_releases,
    'top': Icons.equalizer,
    'controversial': Icons.bolt,
    'rising': Icons.trending_up,
  };
  Map<String, String> nameDisplay = {
    'hot': 'Hot',
    'new': 'New',
    'top': 'Top',
    'controversial': 'Controversial',
    'rising': 'Rising',
  };

  @override
  Widget build(BuildContext context) {
    return Container(
      color: colorTheme.secondaryBg,
      height: 36,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: () {
                showModalBottomSheet<void>(
                  context: context,
                  builder: buildModalBottom,
                  backgroundColor: Colors.transparent
                );
              },
              splashColor: colorTheme.primaryBg,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: mainHorizontalPadding),
                child: Row(
                  children: [
                    Icon(icons[postsStore.sorting], color: colorTheme.icon, size: 14,),
                    SizedBox(width: 5),
                    Text(nameDisplay[postsStore.sorting], style: fontBook.copyWith(fontSize: 11)),
                  ]
                )
              )
            )
          ),
        ]
      )
    );
  }

  // Modal Bottom Sheet to select the sorting type
  Widget buildModalBottom(BuildContext context) {
    return Container(
      height: 300,
      margin: EdgeInsets.symmetric(horizontal: 5),
      padding: EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: colorTheme.secondaryBg,
        borderRadius: BorderRadius.vertical(top: Radius.circular(10))
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Text(
              'SORT POSTS BY',
              style: fontBook
            ),
          ),
          modalBottomChoice(context, 'hot'),
          modalBottomChoice(context, 'new'),
          modalBottomChoice(context, 'top'),
          modalBottomChoice(context, 'controversial'),
          modalBottomChoice(context, 'rising'),
        ],
      )
    );
  }

  // Choice of the Modal Bottom Sheet for a sorting type
  // Have the Icon, Name of the sorting and shows if it is the currently selected
  Widget modalBottomChoice(BuildContext context, String sort) {
    return Expanded(
      child: TextButton(
        onPressed: () async {
          if (postsStore.scrollController != null)
            await postsStore.scrollController.animateTo(0, duration: Duration(milliseconds: 500), curve: Curves.easeInOut);
          Timer(Duration(milliseconds: 500), () => postsStore.setSorting(sort));
          Navigator.pop(context);
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Icon(
                  icons[sort],
                  color: sort == postsStore.sorting ? colorTheme.icon : colorTheme.primaryText,
                ),
                SizedBox(width: 10,),
                Text(
                  nameDisplay[sort],
                  style: fontBook.apply(
                    color: sort == postsStore.sorting ? colorTheme.icon : colorTheme.primaryText
                  )
                ),
              ],
            ),
            if (sort == postsStore.sorting)
              Icon(Icons.check, color: Colors.blue),
          ]
        )
      )
    );
  }
}