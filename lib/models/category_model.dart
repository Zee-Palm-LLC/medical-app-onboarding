class CategoryModel {
  String image;
  String categoryName;
  CategoryModel({
    required this.image,
    required this.categoryName,
  });
}

List<CategoryModel> categoriesList = [
  CategoryModel(image: 'assets/design.svg', categoryName: 'Design'),
  CategoryModel(image: 'assets/figma.svg', categoryName: 'UI/UX'),
  CategoryModel(image: 'assets/coding.svg', categoryName: 'Coding'),
  CategoryModel(image: 'assets/seo.svg', categoryName: 'SEO'),
  CategoryModel(image: 'assets/amazon.svg', categoryName: 'Amazon'),
];
