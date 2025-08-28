import 'package:flutter/material.dart';
import 'package:news/models/news_responces/news.dart';
import 'package:news/uitls/colorsapp.dart';
import 'package:url_launcher/url_launcher.dart';

void showNewsBottomSheet(BuildContext context, News news) {
  TextTheme textTheme = TextTheme.of(context);
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
    ),
    builder: (context) => Padding(
      padding: const EdgeInsets.all(16),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(
                news.urlToImage.isNotEmpty
                    ? news.urlToImage
                    : 'https://as2.ftcdn.net/jpg/00/89/55/15/1000_F_89551596_LdHAZRwz3i4EM4J0NHNHy2hEUYDfXc0j.jpg',
                width: double.infinity,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Image.network(
                    'https://as2.ftcdn.net/jpg/00/89/55/15/1000_F_89551596_LdHAZRwz3i4EM4J0NHNHy2hEUYDfXc0j.jpg',
                    fit: BoxFit.cover,
                  );
                },
              ),
            ),
            SizedBox(height: 16),

            Text(
              news.description.isNotEmpty
                  ? news.description
                  : "do not have description",
              style: textTheme.bodyMedium!.copyWith(color: Colorsapp.black),
            ),
            SizedBox(height: 20),

            ElevatedButton(
              onPressed: () async {
                if (news.url.isNotEmpty) {
                  final Uri url = Uri.parse(news.url);
                  if (await canLaunchUrl(url)) {
                    await launchUrl(url, mode: LaunchMode.externalApplication);
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          'Can not open link',
                          style: textTheme.titleMedium,
                        ),
                      ),
                    );
                  }
                }
              },
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadiusGeometry.circular(8),
                ),
                minimumSize: Size(double.infinity, 50),
                backgroundColor: Colors.black,
              ),
              child: Text('View Full Articel', style: textTheme.titleMedium),
            ),
          ],
        ),
      ),
    ),
  );
}
