import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:helpapp/screens/article_view.dart';

import '../models/article_model.dart';
import '../models/news.dart';
import '../models/slider_model.dart';
import 'slider_data.dart';
class AllNews extends StatefulWidget {
  String news;
  AllNews({required this.news});

  @override
  State<AllNews> createState() => _AllNewsState();
}

class _AllNewsState extends State<AllNews> {
  List<sliderModel> sliders = [];
  List<ArticleModel> articles = [];
  void initState() {
    getSlider();
    getNews();
    super.initState();
  }

  getNews() async {
    News newsclass = News();
    await newsclass.getNews();
    articles = newsclass.news;
    setState(() {
      
    });
  }

  getSlider() async {
    Sliders slider = Sliders();
    await slider.getSlider();
    sliders = slider.sliders;
    setState(() {
      
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(100, 100, 100, 100),
        title: Text(
          widget.news + " News",
          style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        elevation: 0.0,
      ),
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 10.0),
        child: ListView.builder(
            shrinkWrap: true,
            physics: ClampingScrollPhysics(),
            itemCount:
                widget.news == "Breaking" ? sliders.length : articles.length,
            itemBuilder: (context, index) {
              print(articles.length);
              print(sliders.length);
              return AllNewsSection(
                  Image: widget.news == "Breaking"
                      ? sliders[index].urlToImage!
                      : articles[index].urlToImage!,
                  desc: widget.news == "Breaking"
                      ? sliders[index].description!
                      : articles[index].description!,
                  title: widget.news == "Breaking"
                      ? sliders[index].title!
                      : articles[index].title!,
                  url: widget.news == "Breaking"
                      ? sliders[index].url!
                      : articles[index].url!);
            }),
      ),
    );
  }
}

class AllNewsSection extends StatelessWidget {
  String Image, desc, title, url;
  AllNewsSection(
      {required this.Image,
      required this.desc,
      required this.title,
      required this.url});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => ArticleView(blogUrl: url)));
      },
      child: Container(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: CachedNetworkImage(
                  imageUrl: Image,
                  width: MediaQuery.of(context).size.width,
                  height: 200,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(
              height: 5.0,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                title,
                maxLines: 2,
                style: TextStyle(
                    color: const Color.fromARGB(255, 191, 190, 190),
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold),
              ),
            ),
            
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                desc,
                maxLines: 3,
                style: TextStyle(
                    color: Color.fromARGB(255, 160, 159, 159),fontSize: 12.0,
                    ),
              ),
            ),
            SizedBox(
              height: 10.0,
            ),
            Divider(
  color: Colors.grey,
  thickness: 1,
  indent: 10,
  endIndent: 10,
), SizedBox(
              height: 10.0,
            ),
          ],
        ),
      ),
    );
  }
}
