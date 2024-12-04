import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:newsapp/models/article_model.dart';
import 'package:newsapp/models/slider_model.dart';
import 'package:newsapp/pages/article_view.dart';
import 'package:newsapp/services/news.dart';
import 'package:newsapp/services/slider_data.dart';

// ignore: must_be_immutable
class AllNews extends StatefulWidget {
  String news;
  AllNews({super.key, required this.news});

  @override
  State<AllNews> createState() => _AllNewsState();
}

class _AllNewsState extends State<AllNews> {
  List<SliderModel> sliderList = [];
  List<ArticleModel> articles = [];

  @override
  void initState() {
    getslider();
    getNews();
    super.initState();
  }

  getNews() async {
    News newsclass = News();
    await newsclass.getNews();
    articles = newsclass.news;
    setState(() {});
  }

  getslider() async {
    Sliders slider = Sliders();
    await slider.getSlider();
    sliderList = slider.sliders;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "${widget.news} News",
          style: const TextStyle(color: Colors.blue),
        ),
      ),
      body: Container(
          margin: const EdgeInsets.symmetric(horizontal: 10),
          child: ListView.builder(
              physics: const ClampingScrollPhysics(),
              shrinkWrap: true,
              itemCount: widget.news == "Breaking"
                  ? sliderList.length
                  : articles.length,
              itemBuilder: (context, index) {
                return AllNewsSection(
                    image: widget.news == "Breaking"
                        ? sliderList[index].urlToImage!
                        : articles[index].urlToImage!,
                    desc: widget.news == "Breaking"
                        ? sliderList[index].description!
                        : articles[index].description!,
                    title: widget.news == "Breaking"
                        ? sliderList[index].title!
                        : articles[index].title!,
                    url: widget.news == "Breaking"
                        ? sliderList[index].url!
                        : articles[index].url!);
              })),
    );
  }
}

// ignore: must_be_immutable
class AllNewsSection extends StatelessWidget {
  String image, title, desc, url;
  AllNewsSection(
      {super.key,
      required this.image,
      required this.title,
      required this.desc,
      required this.url});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => ArticleView(blogUrl: url)));
      },
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: CachedNetworkImage(
              imageUrl: image,
              width: MediaQuery.of(context).size.width,
              height: 200,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(height: 5),
          Text(
            title,
            maxLines: 2,
            style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
                color: Colors.black),
          ),
          Text(
            desc,
            maxLines: 3,
          ),
          const SizedBox(
            height: 20,
          )
        ],
      ),
    );
  }
}
