import 'package:flutter/material.dart';

class ScreenCategoryProvider extends ChangeNotifier{
  ScreenCategory category = ScreenCategory.meal;

  void switchCategory(ScreenCategory selectedCategory){
    category = selectedCategory;
    notifyListeners();
  } 
}

enum ScreenCategory{
  meal,
  allergy,
  etc,
}