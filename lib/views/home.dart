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
      drawer: Drawer(
           child: Container(
              color: Colors.black,


    /// Categories
                child:Container(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      height: 70,
                      child: 
                         ListView.builder(
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

                /// Categories
                // Container(
                //   padding: EdgeInsets.symmetric(horizontal: 16),
                //   height: 70,
                //   child: ListView.builder(
                //       itemCount: categories.length,
                //       shrinkWrap: true,
                //       scrollDirection: Axis.horizontal,
                //       itemBuilder: (context, index){
                //         return CategoryTile(
                //           imageUrl: categories[index].imageUrl,
                //           categoryName: categories[index].categoryName,
                //         );
                //       }),
                // ),

                ///Articles
                Container(
                  padding: EdgeInsets.only(top: 20),

                  child: 
                    ListView.builder(
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
                      })
                )
              ],
            ),
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
                  // end: Alignment.topRight,
                  // begin: Alignment.bottomLeft
                  ),
                  
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
        color: Colors.black,
        padding: EdgeInsets.fromLTRB(16, 0, 16, 10),
        child: Card(
          color: Colors.grey.shade900,
          elevation: 10,
          shadowColor: Colors.grey.shade300,
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.symmetric(vertical:18.0),
                child: SizedBox(
                  height: MediaQuery.of(context).size.height/4,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(6),
                    child: Image.network(imageUrl,fit: BoxFit.cover)),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical:8.0),
                child: SizedBox(                  
                width: MediaQuery.of(context).size.width/1.2,
                  child: Text(title,style: TextStyle(
                  fontSize: 17,
                  color: Colors.white,
                ),),),
              ),
              Padding(
                padding: const EdgeInsets.only(top:8.0),
                child: SizedBox(
                  height: MediaQuery.of(context).size.height/4,
                  width: MediaQuery.of(context).size.width/1.2,
                  child: Text(desc,style: TextStyle(
                    fontSize: 16, color: Colors.grey,
                  ),),
                ),
              ),
              
            ],
          ),
        ),
      ),
    );
  }
}
