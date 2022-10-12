import 'dart:convert';

import 'package:news_app/models/article.dart';
import 'package:http/http.dart' as http;

Future<List<Article>> getNews() async {
  List<Article> news = [];

  // This API key shouldn't be stored here
  Uri url = Uri.parse(
      "https://newsapi.org/v2/top-headlines?country=in&apiKey=5218da74c8a8410790f03364b628d035");

  var response = await http.get(url);
  
  //fetching data
  var jsonData = jsonDecode(response.body);

  if (jsonData['status'] == "ok") {
    jsonData["articles"].forEach(
      (element) {
        if (element['title'] != null &&
            element['urlToImage'] != null &&
            element['description'] != null) {
          Article articleModel = Article(
            title: element['title'],
            author: element['author'],
            description: element['description'],
            url: element['url'],
            urlToImage: element['urlToImage'],
            content: element['content'],
          );
          news.add(articleModel);
        }
      },
    );
  }

  return news;
}

//creating a future to create a pipeline
Future<List<Article>> getNewsByCategory(String? category) async {
  List<Article> news = [];

  Uri url = Uri.parse(
      "https://newsapi.org/v2/top-headlines?category=$category&country=in&apiKey=5218da74c8a8410790f03364b628d035");

  var response = await http.get(url);

  var jsonData = jsonDecode(response.body);

  if (jsonData['status'] == "ok") {
    jsonData["articles"].forEach(
      (element) {
        if (element['title'] != null &&
            element['urlToImage'] != null &&
            element['description'] != null) {
          Article articleModel = Article(
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
      },
    );
  }

  return news;
}

//creating a future to build data pipelines
Future<List<Article>> getNewsBySearchQuery(String? query) async {
  List<Article> news = [];

  String urlEncodedQuery = Uri.encodeQueryComponent(query!);

  Uri url = Uri.parse(
      "https://newsapi.org/v2/everything?qInTitle=$urlEncodedQuery&apiKey=5218da74c8a8410790f03364b628d035");

  var response = await http.get(url);

  var jsonData = jsonDecode(response.body);

  if (jsonData['status'] == "ok") {
    jsonData["articles"].forEach(
      (element) {
        if (element['title'] != null &&
            element['urlToImage'] != null &&
            element['description'] != null) {
          Article articleModel = Article(
            title: element['title'],
            author: element['author'],
            description: element['description'],
            url: element['url'],
            urlToImage: element['urlToImage'],
            content: element['content'],
          );

          news.add(articleModel);
        }
      },
    );
  }

  return news;
}
