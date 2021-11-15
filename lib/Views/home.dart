import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:newsapp/Views/article_page.dart';
import 'package:newsapp/Views/category.dart';
import 'package:newsapp/helper/data.dart';
import 'package:newsapp/helper/news.dart';
import 'package:newsapp/model/category_model.dart';

class Home extends StatefulWidget {

  const Home({Key key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  // List<dynamic>categories = [];
  List<CategoryModel> categories = [];
  var articles;
  bool _loading = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    categories = getCategories();
    getActualNews();
  }

  getActualNews() async {
    News newsClass = News();
    articles = newsClass.news;
    await newsClass.getNews();

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
        elevation: 10.0,
        centerTitle: true,
      ),
      body: _loading ? Center(child: Container(child: CircularProgressIndicator(),)) :
      SingleChildScrollView(
        child: Container(
            margin: EdgeInsets.only(top: 10),
          child: Column(
            children: [
              /// Category
              Container(
                padding: EdgeInsets.symmetric(horizontal: 16),
                height: 70,
                child: ListView.builder(
                  itemCount: categories.length,
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index){
                    return CategoryTile(
                      imageURL: categories[index].imageUrl,
                      categoryName: categories[index].categoryName,
                    );
                    })
              ),
              /// blog
              Container(
                padding: EdgeInsets.only(top: 16),
                child: ListView.builder(itemCount: articles.length,shrinkWrap:true,physics: ClampingScrollPhysics(),itemBuilder: (context, index){
                  return BlogTitle(imageUrl: articles[index].urlToImage, title: articles[index].title, desc: articles[index].description,url: articles[index].url);
                }),
              )
            ],
          )
        ),
      ),
    );
  }
}

class CategoryTile extends StatelessWidget {
  final String imageURL , categoryName;
  CategoryTile({this.imageURL,this.categoryName});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context)=> Category(category: categoryName.toLowerCase(),)));
      },
      child: Container(
        margin: EdgeInsets.only(right: 16),
        child: Stack(
          children: [
            ClipRRect(borderRadius: BorderRadius.circular(6.0),
            child: CachedNetworkImage(imageUrl: imageURL,width: 120, height: 60,fit: BoxFit.cover),),
            Container(
              alignment: Alignment.center,
              width: 120,height: 60,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6),
                color: Colors.black38,
              ),
              child: Text(categoryName , style: TextStyle(color: Colors.white,fontSize: 14,fontWeight: FontWeight.w800)),
            )
          ],
        ),
      ),
    );
  }
}

class BlogTitle extends StatelessWidget {
  final String imageUrl,title,desc,url;
  BlogTitle({@required this.imageUrl,@required this.title,@required this.desc,@required this.url});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context) => Article(blogUrl: url,)));
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 16),
        child: Column(
          children: [
            ClipRRect(borderRadius:BorderRadius.circular(6),child: Image.network(imageUrl)),
            Text(title,style: TextStyle(fontSize: 17,fontWeight: FontWeight.w500),),
            SizedBox(height: 8,),
            Text(desc,style: TextStyle(color: Colors.black54),)
          ]

        ),
      ),
    );
  }
}

