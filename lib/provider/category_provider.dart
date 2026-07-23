import 'package:flutter/material.dart';

import '../models/category_model.dart';

class CategoryProvider extends ChangeNotifier {
  final List<CategoryModel> _categories = [
    CategoryModel(
      id: 'CAT001',
      name: 'Contract',
      description: 'Legal Contract',
      active: true,
    ),
    CategoryModel(
      id: 'CAT002',
      name: 'Agreement',
      description: 'Business Agreement',
      active: true,
    ),
    CategoryModel(
      id: 'CAT003',
      name: 'NDA',
      description: 'Non Disclosure Agreement',
      active: true,
    ),
    CategoryModel(
      id: 'CAT004',
      name: 'License',
      description: 'License Document',
      active: true,
    ),
  ];

  List<CategoryModel> get categories => _categories;

  /// ADD
  void add(CategoryModel category) {
    _categories.add(category);
    notifyListeners();
  }

  /// UPDATE
  void update(CategoryModel category) {
    final index =
        _categories.indexWhere((e) => e.id == category.id);

    if (index != -1) {
      _categories[index] = category;
      notifyListeners();
    }
  }

  /// DELETE
  void delete(String id) {
    _categories.removeWhere((e) => e.id == id);
    notifyListeners();
  }

  /// GET BY ID
  CategoryModel? getById(String id) {
    try {
      return _categories.firstWhere((e) => e.id == id);
    } catch (_) {
      return null;
    }
  }
}