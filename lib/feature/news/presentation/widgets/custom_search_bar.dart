import 'package:flutter/material.dart';

class CustomSearchBar extends StatelessWidget {
  final TextEditingController searchController;
  final void Function(String) onSubmitted;
  const CustomSearchBar({super.key, required this.searchController, required this.onSubmitted});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: searchController,
      decoration: InputDecoration(
        hintText: 'Search news...',
        prefixIcon: Icon(Icons.search),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: BorderSide(color: Colors.grey, width: 1.0),
        ),
      ),
      onSubmitted: (value)=> onSubmitted(value),
      style: TextStyle(fontSize: 16.0,color: Colors.black),
      
    );
  }
}