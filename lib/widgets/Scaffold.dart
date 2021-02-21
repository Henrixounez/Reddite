import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:reddite/states/auth.dart';
import 'package:reddite/utils/colors.dart';
import 'package:reddite/widgets/Input.dart';

class RedditeScaffold extends StatelessWidget {
  const RedditeScaffold({
    Key key,
    @required this.body,
    this.showNavbar = true,
  }) : super(key: key);

  final Widget body;
  final bool showNavbar;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: showNavbar ? appBar() : null,
        body: this.body,
      )
    );
  }

  Widget appBar() {
    return AppBar(
      automaticallyImplyLeading: false,
      shadowColor: Color(0x000000),
      titleSpacing: 16,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Observer(
            builder: (_) => Container(
              height: 32,
              width: 32,
              clipBehavior: Clip.antiAlias,
              decoration: BoxDecoration(
                color: white,
                borderRadius: BorderRadius.all(Radius.circular(32))
              ),
              child: authStore.me.icon != null ?
                Image.network('${authStore.me.icon}', width: 32, height: 32, fit: BoxFit.contain,) :
                SizedBox.fromSize(size: Size(32, 32)),
            )
          ),
          SizedBox(width: 16,),
          RedditeTopInput(
            onChange: null,
            onSubmit: null,
            hintText: "Search"
          ),
        ]
      ),
    );
  }
}