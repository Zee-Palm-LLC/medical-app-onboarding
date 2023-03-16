// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:animation_app/models/category_model.dart';
import 'package:flutter/material.dart';

class MyDropdown extends StatefulWidget {
  final List<CategoryModel>? categories;
  final CategoryModel? selectedCategory;
  final Function(CategoryModel?) onCategoryChanged;
  MyDropdown({
    Key? key,
    required this.categories,
    required this.selectedCategory,
    required this.onCategoryChanged,
  }) : super(key: key);
  @override
  _MyDropdownState createState() => _MyDropdownState();
}

class _MyDropdownState extends State<MyDropdown> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
          color: Color(0xfff3f3f4), borderRadius: BorderRadius.circular(5)),
      child: DropdownButton<CategoryModel>(
          value: widget.selectedCategory,
          hint: Text("Select Category", style: TextStyle(color: Colors.grey)),
          underline: SizedBox(),
          isExpanded: true,
          dropdownColor: Color(0xfff3f3f4),
          items: widget.categories!
              .map((category) => DropdownMenuItem<CategoryModel>(
                    value: category,
                    key: ValueKey(category.id),
                    child: Text(category.category),
                  ))
              .toList(),
          onChanged: widget.onCategoryChanged),
    );
  }
}
