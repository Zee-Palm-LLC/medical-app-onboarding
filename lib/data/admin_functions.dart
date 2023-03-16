import 'enums/category_enum.dart';

String getCollectionName(CategoryCourse category) {
  switch (category) {
    case CategoryCourse.design:
      return 'design';
    case CategoryCourse.ui:
      return 'ui';
    case CategoryCourse.coding:
      return 'coding';
    case CategoryCourse.seo:
      return 'seo';
    case CategoryCourse.amazon:
      return 'amazon';
    default:
      return 'other_courses';
  }
}
