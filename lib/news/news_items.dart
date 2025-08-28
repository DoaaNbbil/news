import 'package:flutter/material.dart';
import 'package:news/models/news_responces/news.dart';
import 'package:news/widget/showModalBottomSheet.dart';
import 'package:news/uitls/colorsapp.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:cached_network_image/cached_network_image.dart';

class NewsItems extends StatelessWidget {
  final News news;
  const NewsItems(this.news, {super.key});

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;

    return InkWell(
      onTap: () {
        showNewsBottomSheet(context, news);
      },
      child: Container(
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colorsapp.white),
        ),
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: CachedNetworkImage(
                imageUrl: news.urlToImage.isNotEmpty
                    ? Uri.decodeFull(news.urlToImage)
                    : 'https://as2.ftcdn.net/jpg/00/89/55/15/1000_F_89551596_LdHAZRwz3i4EM4J0NHNHy2hEUYDfXc0j.jpg',
                width: double.infinity,
                height: MediaQuery.sizeOf(context).height * 0.25,
                fit: BoxFit.cover,

                placeholder: (context, url) =>
                    Center(child: CircularProgressIndicator()),

                errorWidget: (context, url, error) =>
                    Icon(Icons.broken_image, size: 50, color: Colors.grey),
              ),
            ),
            SizedBox(height: 10),
            Text(news.title, style: textTheme.titleMedium),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('By : ${news.source.name}', style: textTheme.labelSmall),
                if (news.publishedAt != null)
                  Text(
                    timeago.format(news.publishedAt!),
                    style: textTheme.labelSmall,
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
