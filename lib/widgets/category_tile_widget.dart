import 'package:flutter/material.dart';
import 'package:newsapp/pages/category_news.dart';

class CategoryTile extends StatelessWidget {
  // ignore: prefer_typing_uninitialized_variables
  final image, categoryname;
  const CategoryTile({super.key, this.image, this.categoryname});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context)=> CategoryNews(name: categoryname)));
      },
      child: Container(
        margin: const EdgeInsets.only(right: 20),
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.asset(
                image,
                width: 120,
                height: 100,
                fit: BoxFit.cover,
              ),
            ),
            Container(
              width: 120,
              height: 70,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10), color: Colors.black45),
              child: Center(
                child: Text(
                  categoryname,
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.bold),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}