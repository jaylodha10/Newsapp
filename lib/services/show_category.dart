import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:newsapp/models/show_category.dart';

class ShowCategoryNews {
  List<ShowCategoryModel> categories = [];

  Future<void> getCategoriesNews(String category) async {
    String url =
        "https://newsapi.org/v2/top-headlines?country=us&category=$category&apiKey=2389dcfef91e4c528aa469d76c659888";

    try {
      var response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        var jsonData = jsonDecode(response.body);

        if (jsonData['status'] == 'ok') {
          jsonData["articles"].forEach((element) {
            if (element["urlToImage"] != null &&
                element["description"] != null) {
              ShowCategoryModel categoryModel = ShowCategoryModel(
                title: element["title"],
                description: element["description"],
                url: element["url"],
                urlToImage: element["urlToImage"],
                content: element["content"],
                author: element["author"],
              );
              categories.add(categoryModel);
            }
          });
          for (var article in categories) {
            print("Title: ${article.title}");
            print("Description: ${article.description}");
            print("URL: ${article.url}");
            print("Image URL: ${article.urlToImage}");
            print("Content: ${article.content}");
            print("Author: ${article.author}");
            print("---------------------------");
          }
        } else {
          print("Error: News API returned status ${jsonData['status']}");
        }
      } else {
        print(
            "Error: Failed to fetch news. Status code: ${response.statusCode}");
      }
    } catch (e) {
      print("Exception occurred: $e");
    }
  }
}
