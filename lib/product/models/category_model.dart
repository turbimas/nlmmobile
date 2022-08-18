class CategoryModel {
  String id;
  String get name => 'Category $id';
  List<String> subCategories =
      List.generate(10, (index) => (index * 100).toString());
  String imgUrl = 'https://picsum.photos/200';
  String get masterCategoryId => 'MasterCategory ${id * 10}';

  CategoryModel(this.id);
}
