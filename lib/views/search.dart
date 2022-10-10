import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:news_app/helper/news.dart';
import 'package:news_app/models/article.dart';
import 'package:news_app/widgets/article.dart';

class Search extends StatefulWidget {
  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  String query = '';
  TextEditingController _controller = TextEditingController();
  FocusNode _node = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey.shade900,        
      elevation:10,
      shadowColor: Colors.grey.shade500,
        title: Container(
          width: double.infinity,
          height: 40,
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(5)),
          child: Center(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.grey.shade900,
                //borderRadius: BorderRadius.circular(15)
              ),
              child: TextField(   
                textCapitalization: TextCapitalization.words,             
                focusNode: _node,
                autofocus: true,
                controller: _controller,
                onChanged: (text) {
                  this.query = text;
                },
                onEditingComplete: () => setState(() {}),
                decoration: InputDecoration(
                  // prefixIcon: IconButton(
                  //   icon: Icon(
                  //     Icons.search,
                  //     color: Colors.white
                  //   ),
                  //   onPressed: () => setState(() {}),
                  // ),
                  
                  suffixIcon: IconButton(
                    icon: Icon(
                      Icons.clear,
                      color: Colors.white,
                    ),
                    onPressed: () => _controller.clear(),
                  ),
                  hintText: 'Search topics',
                  hintStyle: TextStyle(color: Colors.grey),
                  border: InputBorder.none,
                ),
              ),
            ),
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.only(top: 20),
        child: FutureBuilder<List<Article>>(
          future: getQueriedArticles(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }

            if (snapshot.hasData) {
              if (snapshot.data!.isEmpty && this.query.isNotEmpty) {
                return Center(
                    child: Text(
                  'No Results found',
                  style: TextStyle(color: Colors.white),
                ));
              }

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
            }
            return Container();
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    this._controller.dispose();
    this._node.dispose();
    super.dispose();
  }

  Future<List<Article>> getQueriedArticles() async {
    this._node.unfocus();
    String query = this._controller.text;
    if (query.isEmpty) return [];
    return await getNewsBySearchQuery(query);
  }
}
