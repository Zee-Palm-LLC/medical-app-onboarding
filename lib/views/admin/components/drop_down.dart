// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:animation_app/data/constants.dart';
import 'package:flutter/material.dart';

import 'package:animation_app/data/enums/category_enum.dart';
import 'package:get/get.dart';

class MyDropdown extends StatefulWidget {
  CategoryCourse? value;
  MyDropdown({Key? key, this.value}) : super(key: key);
  @override
  _MyDropdownState createState() => _MyDropdownState();
}

class _MyDropdownState extends State<MyDropdown> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: Color(0xfff3f3f4),
        borderRadius: BorderRadius.circular(5)
      ),
      child: DropdownButton<CategoryCourse>(
        value: widget.value,
        underline: SizedBox(),
        isExpanded: true,    
        dropdownColor: Color(0xfff3f3f4),
        
        items: CategoryCourse.values.map((category) {
          return DropdownMenuItem(
            value: category,
            child: Text(category.toString().split('.')[1].capitalizeFirst.toString()),
          );
        }).toList(),
        onChanged: (value) {
          setState(() {
            widget.value = value!;
            print(widget.value);
          });
        },
      ),
    );
  }
}
