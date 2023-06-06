import 'package:flutter/material.dart';
import 'package:design_system/design_system.dart';

class TitleTopBarWidget extends StatelessWidget {
  const TitleTopBarWidget({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 37),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          /*const Padding(
            padding: EdgeInsets.only(left: 11.0),
            child: BackButtonWidget(),
          ),*/
          Text(
            title,
            style: AppFonts.title3(),
          ),
          // const Padding(
          //   padding: EdgeInsets.only(left: 4.0),
          //   child: CircleAvatarWidget(),
          // ),
        ],
      ),
    );
  }
}