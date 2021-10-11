import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news_app/helper/data.dart';
import 'package:news_app/models/article.dart';
import 'package:news_app/models/category.dart';
import 'package:news_app/helper/news.dart';
import 'package:news_app/views/category.dart';
import 'package:news_app/widgets/appbar.dart';
import 'package:news_app/widgets/article.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Category> categories = [];
  late Future<List<Article>> _articleFuture;

  @override
  void initState() {
    _articleFuture = getNews();
    categories = getCategories();
    super.initState();
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
        child: FutureBuilder<List<Article>>(
          future: this._articleFuture,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                itemCount: snapshot.data!.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return ArticleTile(
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
          Navigator.push(context, MaterialPageRoute(
              builder: (context) => CategoryNews(
                category: categoryName.toLowerCase(),
              )
          )
          );
      },
      child: Container(
          margin: EdgeInsets.fromLTRB(16, 20, 0, 5),
          child: Stack(
            alignment: AlignmentDirectional.topEnd,
            children: <Widget>[
              ClipRRect(
                  borderRadius: BorderRadius.circular(6),
                  child: CachedNetworkImage(
                    imageUrl: imageUrl, width: 250, height: 70, fit: BoxFit.cover,
                    )),
              Container(
                alignment: Alignment.center,
                width: 120,
                height: 70,
                decoration: BoxDecoration(
                  gradient: LinearGradient(colors: [Colors.black26,Colors.black],
                  ),
                  
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(categoryName, style: GoogleFonts.lora(
                      color: Colors.white,
                      fontSize: 16,
                      letterSpacing: 0.3,
                      fontWeight: FontWeight.w600,
                    ),
                 ),
              )
            ],
          )
      ),
    );
  }
}

