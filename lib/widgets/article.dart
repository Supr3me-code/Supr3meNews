import 'package:flutter/material.dart';
import 'package:news_app/views/article.dart';

class ArticleTile extends StatelessWidget {
  final String? imageUrl, title, desc, url;

  ArticleTile({
    required this.imageUrl,
    required this.title,
    required this.desc,
    this.url,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ArticleView(
              articleUrl: url,
            ),
          ),
        );
      },
      child: Container(
        padding: EdgeInsets.fromLTRB(16, 0, 16, 10),
        child: Column(
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.circular(6),
              child: Image.network(imageUrl!, fit: BoxFit.cover),
            ),
            SizedBox(height: 4),
            Text(title!, style: Theme.of(context).textTheme.subtitle1),
            SizedBox(height: 4),
            Text(desc!, style: Theme.of(context).textTheme.caption),
          ],
        ),
      ),
    );
  }
}
