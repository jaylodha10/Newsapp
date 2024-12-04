import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:newsapp/models/article_model.dart';
import 'package:newsapp/models/categories_model.dart';
import 'package:newsapp/models/slider_model.dart';
import 'package:newsapp/pages/all_news.dart';
import 'package:newsapp/services/data.dart';
import 'package:newsapp/services/slider_data.dart';
import 'package:newsapp/widgets/blog_tile_widget.dart';
import 'package:newsapp/widgets/build_image_widget.dart';
import 'package:newsapp/widgets/build_indicator.dart';
import 'package:newsapp/widgets/category_tile_widget.dart';
import 'package:newsapp/services/news.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<CategoryModel> categories = [];
  List<SliderModel> sliderList = [];
  List<ArticleModel> articles = [];
  bool _loading = true;

  int activeIndex = 0;

  @override
  void initState() {
    categories = getCategories();
    getslider();
    getNews();
    super.initState();
  }

  getNews() async {
    News newsclass = News();
    await newsclass.getNews();
    articles = newsclass.news;
    setState(() {
      _loading = false;
    });
  }

  getslider() async {
    Sliders slider = Sliders();
    await slider.getSlider();
    sliderList = slider.sliders;
    setState(() {
      sliderList = slider.sliders;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Flutter"),
            Text(
              " News",
              style: TextStyle(color: Colors.blue),
            )
          ],
        ),
        backgroundColor: Colors.grey.shade300,
      ),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: const EdgeInsets.only(top: 20, left: 20),
                    height: 70,
                    child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        shrinkWrap: true,
                        itemCount: categories.length,
                        itemBuilder: (context, index) {
                          return CategoryTile(
                            image: categories[index].image,
                            categoryname: categories[index].categoryName,
                          );
                        }),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Breaking News",
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        AllNews(news: "Breaking")));
                          },
                          child: const Text(
                            "View All",
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.blue),
                          ),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  CarouselSlider.builder(
                    itemCount: 5,
                    itemBuilder: (context, index, realIndex) {
                      String? res = sliderList[index].urlToImage;
                      String? res1 = sliderList[index].title;
                      return BuildImage(index: index, image: res, name: res1)
                          .buildImage(context, res!, index, res1!);
                    },
                    options: CarouselOptions(
                      height: 250,
                      autoPlay: true,
                      autoPlayInterval: const Duration(seconds: 3),
                      autoPlayAnimationDuration:
                          const Duration(milliseconds: 800),
                      viewportFraction: 0.8,
                      onPageChanged: (index, reason) {
                        setState(() {
                          activeIndex = index;
                        });
                      },
                      enlargeCenterPage: true,
                      enlargeStrategy: CenterPageEnlargeStrategy.height,
                      scrollPhysics: const BouncingScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Center(
                      child: BuildIndicator(
                              activeIndex: activeIndex, sliderList: sliderList)
                          .buildIndicator()),
                  const SizedBox(
                    height: 30,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Trending News",
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        AllNews(news: "Trending")));
                          },
                          child: const Text(
                            "View All",
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.blue),
                          ),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  ListView.builder(
                      physics: const ClampingScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: articles.length,
                      itemBuilder: (context, index) {
                        return BlogTile(
                            url: articles[index].url!,
                            desc: articles[index].description!,
                            imageurl: articles[index].urlToImage!,
                            title: articles[index].title!);
                      })
                ],
              ),
            ),
    );
  }
}
