import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:news/uitls/colorsapp.dart';

class DrawerHome extends StatelessWidget {
  DrawerHome({required this.onGoToHomeClicked});
  VoidCallback onGoToHomeClicked;
  @override
  Widget build(BuildContext context) {
    Size sizeScreen = MediaQuery.sizeOf(context);
    TextTheme textTheme = Theme.of(context).textTheme;
    return Container(
      color: Colorsapp.black,
      width: sizeScreen.width * 0.7,
      child: Column(
        children: [
          Container(
            color: Colorsapp.white,
            height: sizeScreen.height * 0.2,
            width: double.infinity,
            alignment: Alignment.center,
            child: Text(
              'News App',
              style: textTheme.titleLarge!.copyWith(
                color: Colorsapp.black,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(16),
            child: GestureDetector(
              onTap: () {
                onGoToHomeClicked();
                Navigator.of(context).pop();
              },
              child: Row(
                children: [
                  SvgPicture.asset('assets/icons/Home.svg'),
                  SizedBox(width: 8),
                  Text(
                    'Go To Home',
                    style: textTheme.titleMedium!.copyWith(fontSize: 24),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
