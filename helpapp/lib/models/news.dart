import 'dart:convert';


import 'package:http/http.dart' as http;

import 'article_model.dart';

class News{
  List<ArticleModel> news=[];
  
  
  Future<void> getNews()async{
String url="https://newsapi.org/v2/everything?q=car&from=2024-11-11&sortBy=publishedAt&apiKey=639d10116c964e13acf705f1d3235f69";
 var response= await http.get(Uri.parse(url));

var jsonData= jsonDecode(response.body);

if(jsonData['status']=='ok'){
  jsonData["articles"].forEach((element){
    if(element["urlToImage"]!=null && element['description']!=null){
      ArticleModel articleModel= ArticleModel(
        title: element["title"],
        description: element["description"],
        url: element["url"],
        urlToImage: element["urlToImage"],
        content: element["content"],
        author: element["author"],
      );
      news.add(articleModel);
    }
  });
}
 
  }
}