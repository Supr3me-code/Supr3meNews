import 'package:flutter/material.dart';
import 'package:news_app/models/article.dart';
import 'package:news_app/views/article_view.dart';
import 'package:news_app/helper/news.dart';

class CategoryNews extends StatefulWidget {

  final String? category;
  CategoryNews({this.category});

  @override
  _CategoryNewsState createState() => _CategoryNewsState();
}

class _CategoryNewsState extends State<CategoryNews> {

  List<ArticleModel> articles = [];
  bool _loading = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCategoryNews();
  }

  getCategoryNews() async {
    CategoryNewsClass newsClass = CategoryNewsClass();
    await newsClass.getNews(widget.category);
    articles = newsClass.news;
    setState(() {
      _loading = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text("Supr3me",
              style: TextStyle(color: Colors.white),
            ),
            Text("News",style: TextStyle(color: Colors.deepOrange),)
          ],
        ),
        actions: <Widget>[
          Opacity(
            opacity: 0,
            child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Icon(Icons.account_balance_sharp)),
          )
        ],
        centerTitle: true,
        elevation: 0.0,
      ),

      body: SingleChildScrollView(
        child: Container(

          child: Column(
            children: <Widget>[
              Container(
                // padding: EdgeInsets.only(top: 20),

                child: ListView.builder(
                    itemCount: articles.length,
                    physics: ScrollPhysics(),
                    shrinkWrap: true,
                    // scrollDirection: Axis.vertical,
                    itemBuilder: (context, index) {
                      return ArticleTile(
                          imageUrl: "${articles[index].urlToImage}",
                          title: "${articles[index].title}",
                          desc: "${articles[index].description}",
                          url: "${articles[index].url}"
                      );
                    }),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class ArticleTile extends StatelessWidget {

  final String imageUrl, title, desc,url;
  ArticleTile({required this.imageUrl, required this.title, required this.desc, required this.url});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(
          builder: (context) => ArticleView(
            articleUrl: url,
          ),
        ));

      },
      child: Container(
        color: Colors.black,
        padding: EdgeInsets.fromLTRB(16, 0, 16, 10),
        child: Column(
          children: <Widget>[
            ClipRRect(borderRadius: BorderRadius.circular(6),
                child: Image.network(imageUrl,fit: BoxFit.cover)),
            Text(title,style: TextStyle(
              fontSize: 17,
              color: Colors.white,
            ),),
            Text(desc,style: TextStyle(
              fontSize: 14, color: Colors.grey,
            ),),
          ],
        ),
      ),
    );
  }
}

