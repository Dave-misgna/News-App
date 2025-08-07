import 'package:dio/dio.dart';
import 'package:news_app/feature/news/data/model/news_model.dart';
import 'package:news_app/feature/news/data/services/api_services.dart';

class CategoryService {
  final ApiServices apiServices;

  CategoryService({required this.apiServices});

  Future<List<NewsModel>> getNews(int? page) async {
    Response response = await apiServices.get('/search', {'page': page});

    if (response.statusCode == 200) {
      List<NewsModel> news = (response.data['response']['results'] as List)
          .map((news) => NewsModel.fromJson(news))
          .toList();
      return news;
    } else {
      throw Exception("Failed to load news");
    }
  }

  Future<List<NewsModel>> searchNews(String query, int?page) async {
    Response response = await apiServices.get('/search', {'q': query, 'page': page});
    if (response.statusCode == 200) {
      List<NewsModel> news = (response.data['response']['results'] as List)
          .map((news) => NewsModel.fromJson(news))
          .toList();
      return news;
    } else {
      throw Exception("Failed to load news");
    }
  }
}
