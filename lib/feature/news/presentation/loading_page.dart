import 'package:flutter/material.dart';
import 'package:news_app/feature/news/presentation/widgets/loading_container.dart';

class LoadingPage extends StatelessWidget {
  const LoadingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: 5,
      separatorBuilder: (context,index) => const Divider(
        color: Colors.grey,
        height: 1.0,
      ),
      itemBuilder: (context,index) => LoadingContainer()
    );
    
  }
}
