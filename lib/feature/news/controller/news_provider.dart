import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import 'package:news_app/feature/news/controller/news_controller.dart';
import 'package:news_app/feature/news/data/model/main_page_model.dart';
import 'package:news_app/feature/news/data/services/api_services.dart';
import 'package:news_app/feature/news/data/services/category_service.dart';

final categoryProvider = Provider<CategoryService>((ref) {
  return CategoryService(
    apiServices: ApiServices(dio: Dio(), getIt: GetIt.instance),
  );
});

final newsControllerProvider = StateNotifierProvider<NewsController, MainPageModel>((ref) {
  final categoryService = ref.watch(categoryProvider);
  return NewsController(categoryService: categoryService);
});
