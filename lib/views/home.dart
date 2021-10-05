import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:news_app/helper/data.dart';
import 'package:news_app/models/article.dart';
import 'package:news_app/models/category.dart';
import 'package:news_app/helper/news.dart';
import 'package:news_app/views/article.dart';
import 'package:news_app/views/category.dart';
import 'package:news_app/widgets/appbar.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Category> categories = [];
  List<Article> articles = [];

  @override
  void initState() {
    super.initState();
    categories = getCategories();
    getNews();
  }

  getNews() async {
    News newsClass = News();
    await newsClass.getNews();
    articles = newsClass.news;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Supr3meAppBar(),
      drawer: Drawer(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: ListView.builder(
            itemCount: categories.length,
            itemBuilder: (context, index) {
              return CategoryTile(
                imageUrl: categories[index].imageUrl,
                categoryName: categories[index].name,
              );
            },
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.only(top: 20),
        child: ListView.builder(
          itemCount: articles.length,
          physics: ScrollPhysics(),
          shrinkWrap: true,
          itemBuilder: (context, index) {
            return ArticleTile(
              imageUrl: "${articles[index].urlToImage}",
              title: "${articles[index].title}",
              desc: "${articles[index].description}",
              url: "${articles[index].url}",
            );
          },
        ),
      ),
    );
  }
}

class CategoryTile extends StatelessWidget {
  final imageUrl, categoryName;

  CategoryTile({this.imageUrl, this.categoryName});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CategoryNews(
              category: categoryName.toLowerCase(),
            ),
          ),
        );
      },
      child: Container(
        margin: EdgeInsets.fromLTRB(16, 20, 0, 5),
        child: Stack(
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.circular(6),
              child: CachedNetworkImage(
                imageUrl: imageUrl,
                width: 250,
                height: 60,
                fit: BoxFit.cover,
              ),
            ),
            Container(
              alignment: Alignment.center,
              height: 60,
              child: Text(
                categoryName,
                style: Theme.of(context).textTheme.headline6,
              ),
            )
          ],
        ),
      ),
    );
  }
}

class ArticleTile extends StatelessWidget {
  final String imageUrl, title, desc, url;
  ArticleTile(
      {required this.imageUrl,
      required this.title,
      required this.desc,
      required this.url});

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
              child: Image.network(imageUrl, fit: BoxFit.cover),
            ),
            SizedBox(height: 4),
            Text(title, style: Theme.of(context).textTheme.subtitle1),
            SizedBox(height: 4),
            Text(desc, style: Theme.of(context).textTheme.caption),
          ],
        ),
      ),
    );
  }
}
