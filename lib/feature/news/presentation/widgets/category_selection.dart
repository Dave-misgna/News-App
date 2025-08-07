import 'package:flutter/material.dart';

class CategorySelection extends StatelessWidget {
  const CategorySelection({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ElevatedButton(onPressed: (){}, child: Text('Latest')),
        ElevatedButton(onPressed: (){}, child:Text('Sport') ),
        ElevatedButton(onPressed: (){}, child: Text('Politics')),
        ElevatedButton(onPressed: (){}, child: Text('Economy')),
        ElevatedButton(onPressed: (){}, child: Text('Film')),
        ElevatedButton(onPressed: (){}, child: Text('Technology')),
        ElevatedButton(onPressed: (){}, child: Text('Music')),
 
      ],
    );
  }
}