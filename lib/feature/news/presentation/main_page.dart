import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news_app/feature/news/controller/news_provider.dart';
import 'package:news_app/feature/news/data/model/main_page_model.dart';
import 'package:news_app/feature/news/presentation/loading_page.dart';
import 'package:news_app/feature/news/presentation/widgets/news_tile.dart';

class MainPage extends ConsumerStatefulWidget {
  const MainPage({super.key});

  @override
  ConsumerState<MainPage> createState() => _MainPageState();
}

class _MainPageState extends ConsumerState<MainPage> {
  late ScrollController scrollController;
  final TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    scrollController = ScrollController();
    scrollController.addListener(() {
      final position = scrollController.position;
      if (position.pixels >= position.maxScrollExtent - 300) {
        
        final controller = ref.read(newsControllerProvider.notifier);
        final state = ref.read(newsControllerProvider);

        if (state.isLoading) return;

        if (state.searchQuery.isEmpty) {
          controller.fetchNews();
        } else {
          controller.searchNews(state.searchQuery, isPagination: true);
        }
      }
    });
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    MainPageModel data = ref.watch(newsControllerProvider);

    return Scaffold(
            appBar: AppBar(
              title: Text(
                'The Guardian',
                style: GoogleFonts.merriweather(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              centerTitle: true,
              leading: IconButton(
                onPressed: () {
                  context.go('/login');
                },
                icon: Icon(Icons.arrow_back, color: Colors.white),
              ),
              backgroundColor: Color(0xFF052962),
            ),
            body:data.isLoading && data.news.isEmpty
              ? LoadingPage()
              : data.errorMessage.isNotEmpty
              ? Center(child: Text(data.errorMessage))
              :  Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16.0,
                      vertical: 8.0,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Expanded(
                          child: TextField(
                            controller: searchController,
                            decoration: InputDecoration(
                              hintText: 'Search news...',
                              prefixIcon: Icon(Icons.search),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8.0),
                                borderSide: BorderSide(
                                  color: Colors.grey,
                                  width: 1.0,
                                ),
                              ),
                            ),
                            onSubmitted: (value) {
                              ref
                                  .read(newsControllerProvider.notifier)
                                  .searchNews(value);
                            },
                            style: TextStyle(
                              fontSize: 16.0,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  Expanded(
                    child: ListView.builder(
                      controller: scrollController,
                      itemCount: data.news.length,
                      itemBuilder: (context, index) {
                        final news = data.news[index];
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: GestureDetector(
                            onTap: () {},
                            child: NewsTile(news: news),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          );
  }
}
