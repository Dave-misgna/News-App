import 'package:news_app/feature/news/data/model/news_model.dart';

class MainPageModel {
  final List<NewsModel> news;
  final int page;
  final String searchQuery;
  final bool isLoading;
  final String errorMessage;

  MainPageModel({required this.news, required this.page, this.searchQuery = '', this.isLoading = false, this.errorMessage = ''});

  MainPageModel.initial() : news = [], page = 1, searchQuery = '', isLoading = false, errorMessage = '';

  MainPageModel copyWith({List<NewsModel>? news, int? page, String? searchQuery, bool? isLoading, String? errorMessage}) {
    return MainPageModel(
      news: news ?? this.news,
      page: page ?? this.page,
      searchQuery: searchQuery ?? this.searchQuery,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
