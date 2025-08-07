import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:news_app/feature/news/data/model/news_model.dart';

class NewsTile extends StatelessWidget {
  final NewsModel news;
  const NewsTile({super.key, required this.news});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          newsThumbnail(news.thumbnail), 
          newsDescription()],
      ),
    );
  }

  Widget newsThumbnail(String imageUrl) {
    return Container(
      width: 100,
      height: 100,
      decoration: BoxDecoration(
        image: DecorationImage(image: NetworkImage(imageUrl),fit: BoxFit.cover),
      ),
    );
  }

  String formatDate(String date) {
    final newsTime = DateTime.parse(date);
    return DateFormat('yyyy-MM-dd').format(newsTime);
  }

  Widget newsDescription() {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              news.title,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 4),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Section: ${news.sectionName}'),
                Text(formatDate(news.publicationDate)),
              ],
            )
            
            
          ],
        ),
      ),
    );
  }
}
