import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:newsapp/models/show_category.dart';
import 'package:newsapp/pages/article_view.dart';
import 'package:newsapp/services/show_category.dart';

// ignore: must_be_immutable
class CategoryNews extends StatefulWidget {
  String name;
  CategoryNews({super.key, required this.name});

  @override
  State<CategoryNews> createState() => _CategoryNewsState();
}

class _CategoryNewsState extends State<CategoryNews> {
  List<ShowCategoryModel> categories = [];
  // ignore: unused_field
  bool _loading = true;

  @override
  void initState() {
    getNews();
    super.initState();
  }

  getNews() async {
    ShowCategoryNews showCategoryNews = ShowCategoryNews();
    await showCategoryNews.getCategoriesNews(widget.name.toLowerCase());
    categories = showCategoryNews.categories;
    setState(() {
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          widget.name,
          style: const TextStyle(color: Colors.blue),
        ),
      ),
      body: Container(
          margin: const EdgeInsets.symmetric(horizontal: 10),
          child: ListView.builder(
              physics: const ClampingScrollPhysics(),
              shrinkWrap: true,
              itemCount: categories.length,
              itemBuilder: (context, index) {
                return ShowCategory(
                    image: categories[index].urlToImage!,
                    desc: categories[index].description!,
                    title: categories[index].title!,
                    url: categories[index].url!);
              })),
    );
  }
}

// ignore: must_be_immutable
class ShowCategory extends StatelessWidget {
  String image, title, desc , url;
  ShowCategory({super.key, required this.image, required this.title, required this.desc , required this.url});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context)=> ArticleView(blogUrl: url)));
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
          Text(title,maxLines: 2,style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 18,color: Colors.black),),
          Text(desc,maxLines: 3,),
          const SizedBox(height: 20,)
        ],
      ),
    );
  }
}
