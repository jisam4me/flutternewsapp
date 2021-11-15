import 'package:flutter/material.dart';
import 'package:newsapp/Views/home.dart';
import 'package:newsapp/helper/news.dart';
import 'package:newsapp/model/article_model.dart';

class Category extends StatefulWidget {
  final String category;
  Category({this.category});

  @override
  _CategoryState createState() => _CategoryState();
}

class _CategoryState extends State<Category> {
  List<ArticleModel> articles =[];
  bool _loading = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCategoryNews();
  }

  getCategoryNews() async {
    CategoryNews newsClass = CategoryNews();

    await newsClass.getCategoryNews(widget.category);
    articles = newsClass.news;

    setState(() {
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Latest'),
              Text('News',style: TextStyle(color: Colors.red[500]),),
            ]
        ),
        actions: [
          Opacity(opacity:0,child: Container(padding: EdgeInsets.symmetric(horizontal: 16),child: Icon(Icons.save),))
        ],
        elevation: 10.0,
        centerTitle: true,
      ),
      body: _loading ? Center(child: Container(child: CircularProgressIndicator(),)) : SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.only(top: 16),
                child: ListView.builder(itemCount: articles.length,shrinkWrap:true,physics: ClampingScrollPhysics(),itemBuilder: (context, index){
                  return BlogTitle(imageUrl: articles[index].urlToImage, title: articles[index].title, desc: articles[index].description,url: articles[index].url);
                }),
              )
            ],
          ),
        ),
      ),
    );
  }
}
