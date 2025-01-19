import 'package:flutter/material.dart';

class CategoriesSelector extends StatefulWidget {
  CategoriesSelector({super.key});
  @override
  State<CategoriesSelector> createState() => _CategoriesSelectorState();
}

class _CategoriesSelectorState extends State<CategoriesSelector> {
  int selectedIndex = 0;
  final List<String> categories = ['Messages', "Online", "Groups", "Requests"];

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.green.shade300,
      height: 90,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: () {
              setState(() {
                selectedIndex = index;
              });
            },
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
              child: Text(
                categories[index],
                style: TextStyle(
                    color:
                        index == selectedIndex ? Colors.white : Colors.white60,
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.2),
              ),
            ),
          );
        },
      ),
    );
  }
}
