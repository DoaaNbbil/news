import 'package:flutter/material.dart';
import 'package:news/colorsapp.dart';
import 'package:timeago/timeago.dart' as timeago;

class NewsItems extends StatelessWidget {
  NewsItems({super.key});

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    DateTime dateTime = DateTime.now().subtract(Duration(minutes: 15));
    return Container(
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colorsapp.white),
      ),
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadiusGeometry.circular(8),
            child: Image.asset(
              'assets/images/Rectangle.png',
              width: double.infinity,
              height: MediaQuery.sizeOf(context).height * 0.25,
              fit: BoxFit.fill,
            ),
          ),
          SizedBox(height: 10),
          Text(
            '40-year-old man falls 200 feet to his death while canyoneering at national park',
            style: textTheme.titleMedium,
          ),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('By : Jon Haworth', style: textTheme.labelSmall),
              Text(timeago.format(dateTime), style: textTheme.labelSmall),
            ],
          ),
        ],
      ),
    );
  }
}
