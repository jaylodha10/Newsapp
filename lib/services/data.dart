import 'package:newsapp/models/categories_model.dart';

List<CategoryModel> getCategories() {
  List<CategoryModel> categoryList =
      []; // Initialize an empty list to store categories

  CategoryModel categoryModel =
      CategoryModel(); // Create the first category and add it to the list
  categoryModel = CategoryModel();
  categoryModel.categoryName = 'Business';
  categoryModel.image = 'images/business1.jpeg';
  categoryList.add(categoryModel);

  categoryModel = CategoryModel(); //another category
  categoryModel.categoryName = 'Entertainment';
  categoryModel.image = 'images/business2.jpeg';
  categoryList.add(categoryModel);

  categoryModel = CategoryModel(); //another category
  categoryModel.categoryName = 'General';
  categoryModel.image = 'images/random.jpeg';
  categoryList.add(categoryModel);

  categoryModel = CategoryModel(); //another category
  categoryModel.categoryName = 'Health';
  categoryModel.image = 'images/health.jpeg';
  categoryList.add(categoryModel);

  categoryModel = CategoryModel(); //another category
  categoryModel.categoryName = 'Sports';
  categoryModel.image = 'images/sports.jpeg';
  categoryList.add(categoryModel);

  return categoryList; // Return the list of categories
}
