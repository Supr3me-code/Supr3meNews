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
        child: Card(
          color: Colors.grey.shade900,
          elevation: 10,
          shadowColor: Colors.grey.shade300,
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 18.0),
                child: SizedBox(
                  height: MediaQuery.of(context).size.height / 4,
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(6),
                      child: Image.network(imageUrl!, fit: BoxFit.cover)),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width / 1.2,
                  child: Text(
                    title!,
                    style: TextStyle(
                      fontSize: 17,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: SizedBox(
                  height: MediaQuery.of(context).size.height / 4,
                  width: MediaQuery.of(context).size.width / 1.2,
                  child: Text(
                    desc!,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
