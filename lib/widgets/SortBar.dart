import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:reddite/states/posts_state.dart';
import 'package:reddite/utils/colors.dart';
import 'package:reddite/utils/styles.dart';

class SortBar extends StatefulWidget {
  final ScrollController scrollController;

  SortBar({Key key, this.scrollController}) : super(key: key);

  @override
  _SortBarState createState() => _SortBarState();
}

class _SortBarState extends State<SortBar> {
  Map<String, IconData> icons = {
    'Hot': Icons.local_fire_department,
    'New': Icons.new_releases,
    'Top': Icons.equalizer,
    'Controversial': Icons.bolt,
    'Rising': Icons.trending_up,
  };

  String selected = 'Hot'; 

  @override
  Widget build(BuildContext context) {
    return Container(
      color: darkGrey,
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
              splashColor: Colors.white,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: mainHorizontalPadding),
                child: Row(
                  children: [
                    Icon(icons[selected], color: white, size: 14,),
                    SizedBox(width: 5),
                    Text(selected, style: fontBook.copyWith(fontSize: 11)),
                  ]
                )
              )
            )
          )
        ]
      )
    );
  }

  Widget buildModalBottom(BuildContext context) {
    return Container(
      height: 300,
      margin: EdgeInsets.symmetric(horizontal: 5),
      decoration: BoxDecoration(
        color: darkGrey,
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
          modalBottomChoice(context, 'Hot', 'hot'),
          modalBottomChoice(context, 'New', 'newest'),
          modalBottomChoice(context, 'Top', 'top'),
          modalBottomChoice(context, 'Controversial', 'controversial'),
          modalBottomChoice(context, 'Rising', 'rising'),
        ],
      )
    );
  }

  Widget modalBottomChoice(BuildContext context, String text, String sort) {
    return Expanded(
      child: FlatButton(
        onPressed: () async {
          if (widget.scrollController != null)
            await widget.scrollController.animateTo(0, duration: Duration(milliseconds: 500), curve: Curves.easeInOut);
          setState(() {
            selected = text;
          });
          Timer(Duration(milliseconds: 500), () => postsStore.setSorting(sort));
          Navigator.pop(context);
        },
        splashColor: lightText,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Icon(
                  icons[text],
                  color: text == selected ? white : lightText,
                ),
                SizedBox(width: 10,),
                Text(
                  text,
                  style: fontBook.apply(
                    color: text == selected ? white : lightText
                  )
                ),
              ],
            ),
            if (text == selected)
              Icon(Icons.check, color: Colors.blue),
          ]
        )
      )
    );
  }
}