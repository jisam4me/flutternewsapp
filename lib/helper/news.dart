import 'dart:convert';
import 'package:newsapp/model/article_model.dart';
import 'package:http/http.dart' as http;

class News{
  List<ArticleModel> news = [];

  Future<void> getNews() async{
    String url ="https://newsapi.org/v2/top-headlines?country=in&apiKey=c45aa14a38354fa8801ac43576f05a04";
    var response = await http.get(Uri.parse(url));
    var jsonData = jsonDecode(response.body);
    if(jsonData['status']=="ok"){
      print("ok");
      jsonData["articles"].forEach((element){
        if(element['urlToImage'] != null && element['description'] != null){

          ArticleModel articleModel = ArticleModel(
            title: element['title'],
            author: element['author'],
            description: element['description'],
            url: element['url'],
            urlToImage: element['urlToImage'],
            publishedAt: DateTime.parse(element['publishedAt']),
            content: element['content']
          );
          news.add(articleModel);
        }
      });
          }
    }

}

class CategoryNews{
  List<ArticleModel> news = [];

  Future<void> getCategoryNews(String category) async{

    String url ="https://newsapi.org/v2/top-headlines?country=in&category=$category&apiKey=c45aa14a38354fa8801ac43576f05a04";
    var response = await http.get(Uri.parse(url));
    var jsonData = jsonDecode(response.body);
    if(jsonData['status']=="ok"){
      print("ok");
      jsonData["articles"].forEach((element){
        if(element['urlToImage'] != null && element['description'] != null){

          ArticleModel articleModel = ArticleModel(
              title: element['title'],
              author: element['author'],
              description: element['description'],
              url: element['url'],
              urlToImage: element['urlToImage'],
              publishedAt: DateTime.parse(element['publishedAt']),
              content: element['content']
          );
          news.add(articleModel);
          print(element['author']);
        }
      });
    }
  }

}