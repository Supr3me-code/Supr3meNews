import 'dart:convert';

import 'package:news_app/models/article.dart';
import 'package:http/http.dart' as http;
class News{
  List<ArticleModel> news = [];

  Future<void> getNews() async{
    Uri url = Uri.parse("https://newsapi.org/v2/top-headlines?country=in&apiKey=5218da74c8a8410790f03364b628d035");

    var response = await http.get(url);

    var jsonData = jsonDecode(response.body);

    if(jsonData['status'] == "ok"){
      jsonData["articles"].forEach((element){
        if(element['title']!=null && element['urlToImage'] != null && element['description'] != null){
          ArticleModel articleModel = ArticleModel(
            title: element['title'],
            author: element['author'],
          description: element['description'],
          url: element['url'],
          urlToImage: element['urlToImage'],
          // publishedAt: element['publishedAt'],
          content: element['content'],
          );
          news.add(articleModel);
        }
      });
    }
  }
}

class CategoryNewsClass{
  List<ArticleModel> news = [];

  Future<void> getNews(String? category) async{
    Uri url = Uri.parse("https://newsapi.org/v2/top-headlines?category=$category&country=in&apiKey=5218da74c8a8410790f03364b628d035");

    var response = await http.get(url);

    var jsonData = jsonDecode(response.body);

    if(jsonData['status'] == "ok"){
      jsonData["articles"].forEach((element){
        if(element['title']!=null && element['urlToImage'] != null && element['description'] != null){
          ArticleModel articleModel = ArticleModel(
            title: element['title'],
            author: element['author'],
            description: element['description'],
            url: element['url'],
            urlToImage: element['urlToImage'],
            // publishedAt: element['publishedAt'],
            content: element['content'],
          );
          news.add(articleModel);
        }
      });
    }
  }
}