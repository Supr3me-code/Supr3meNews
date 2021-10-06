import 'package:flutter/material.dart';
import 'package:news_app/models/article.dart';
import 'package:news_app/views/article.dart';
import 'package:news_app/helper/news.dart';
import 'package:news_app/widgets/appbar.dart';
import 'package:news_app/widgets/article.dart';

class CategoryNews extends StatefulWidget {
  final String? category;
  CategoryNews({this.category});

  @override
  _CategoryNewsState createState() => _CategoryNewsState();
}

class _CategoryNewsState extends State<CategoryNews> {
  late Future<List<Article>> _articleFuture;

  @override
  void initState() {
    _articleFuture = getNewsByCategory(this.widget.category);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Supr3meAppBar(),
      body: FutureBuilder<List<Article>>(
        future: _articleFuture,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return ArticleTile(
                  //null safety measures
                  imageUrl: snapshot.data![index].urlToImage!,
                  title: snapshot.data![index].title!,
                  desc: snapshot.data![index].description!,
                  url: snapshot.data![index].url!,
                );
              },
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
