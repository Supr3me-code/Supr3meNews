import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:news_app/helper/data.dart';
import 'package:news_app/models/article_model.dart';
import 'package:news_app/models/category_model.dart';
import 'package:news_app/helper/news.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:news_app/views/article_view.dart';
import 'package:news_app/views/category_view.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<CategoryModel> categories = new List<CategoryModel>();
  List<ArticleModel> articles = new List<ArticleModel>();

  bool _loading = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    categories = getCategories();
    getNews();
  }

  getNews() async {
    News newsClass = News();
    await newsClass.getNews();
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
          IconButton(icon: Icon(Icons.search), onPressed: (){})
        ],
        centerTitle: true,
        elevation: 0.0,
      ),
      drawer: Drawer(
           child: Container(
              color: Colors.black,


    /// Categories
                child:Container(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      height: 70,
                      child: ListView.builder(
                      itemCount: categories.length,
                      // shrinkWrap: true,
                      itemBuilder: (context, index){
                      return CategoryTile(
                      imageUrl: categories[index].imageUrl,
                      categoryName: categories[index].categoryName,
                  );
                 }),
                ),
              ),
            ),

      body:
     

            Container(
              color: Colors.black,
              child: SingleChildScrollView(
                child: Column(

                  children: <Widget>[
                    // Container(
                    //   child: Text("Search Bar lol",style: TextStyle(color: Colors.white),),
                    // ),
                    ///Articles
                    Container(
                      padding: EdgeInsets.only(top: 20),

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

class DataSearch extends SearchDelegate<String>{
  @override
  List<Widget> buildActions(BuildContext context) {
    // TODO: implement buildActions
    throw UnimplementedError();
  }

  @override
  Widget buildLeading(BuildContext context) {
    // TODO: implement buildLeading
    throw UnimplementedError();
  }

  @override
  Widget buildResults(BuildContext context) {
    // TODO: implement buildResults
    throw UnimplementedError();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // TODO: implement buildSuggestions
    throw UnimplementedError();
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
            children: <Widget>[
              ClipRRect(
                  borderRadius: BorderRadius.circular(6),
                  child: CachedNetworkImage(
                    imageUrl: imageUrl, width: 250, height: 60, fit: BoxFit.cover,)),
              Container(
                alignment: Alignment.center,
                width: 120,
                height: 60,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(categoryName, style: TextStyle(color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w900),),
              )
            ],
          )
      ),
    );
  }
}

class ArticleTile extends StatelessWidget {
  
  final String imageUrl, title, desc,url;
  ArticleTile({@required this.imageUrl, @required this.title, @required this.desc, @required this.url});
  
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

