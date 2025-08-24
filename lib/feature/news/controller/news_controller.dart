import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:news_app/feature/news/data/model/main_page_model.dart';
import 'package:news_app/feature/news/data/model/news_model.dart';
import 'package:news_app/feature/news/data/services/category_service.dart';

class NewsController extends StateNotifier<MainPageModel> {
  final CategoryService categoryService;
  NewsController({required this.categoryService, MainPageModel? state})
    : super(state ?? MainPageModel.initial()) {
    fetchNews();
  }

  Future<void> fetchNews() async {
    try {
      List<NewsModel> newsList = [];
      state = state.copyWith(isLoading: true);

      newsList = await categoryService.getNews(state.page);
      state = state.copyWith(
        news: [...state.news, ...newsList],
        page: state.page + 1,
        isLoading: false,
      );
    } catch (e) {
      state = state.copyWith(isLoading: false, errorMessage: e.toString());
      throw Exception(e.toString());
    }
  }

  Future<void> searchNews(String query, {bool isPagination = false}) async {
    try {
      List<NewsModel> newsList = [];

    if (!isPagination) {
      // Fresh search: reset state
      state = state.copyWith(
        news: [],
        page: 1,
        searchQuery: query,
        isLoading: true,
        
      );
    }else {
      state = state.copyWith(
        isLoading: true,
        page: state.page + 1,
      );
    } 
    newsList = await categoryService.searchNews(query, state.page);

    state = state.copyWith(
      news:  [...state.news, ...newsList] ,
      page: state.page + 1,
      isLoading: false,
    );
    } catch (e) {
      state = state.copyWith(isLoading: false, errorMessage: e.toString());
      throw Exception(e.toString());
    }
  }
}
