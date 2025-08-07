import 'package:flutter/material.dart';

class LoadingContainer extends StatelessWidget {
  
  const LoadingContainer({
    super.key,
    
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Skeleton(width: 100, height: 100),
          Expanded(child: Column(
          children: [
            Skeleton(width: double.infinity, height: 20),
            const SizedBox(height: 10),
            Skeleton(width: double.infinity, height: 15),
            const SizedBox(height: 10),
            Skeleton(width: double.infinity, height: 15),
          ])),
        ],
      ),
    );
  }
}

class Skeleton extends StatelessWidget {
  const Skeleton({
    super.key,
    required this.width,
    required this.height,
  });

  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: Colors.black.withAlpha(50),
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }
}

