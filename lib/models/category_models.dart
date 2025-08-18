class CategoryModels {
  String id;
  String name;
  String imageName;
  CategoryModels({
    required this.id,
    required this.name,
    required this.imageName,
  });
  static List<CategoryModels> categories = [
    CategoryModels(id: '', name: 'general', imageName: 'general'),
    CategoryModels(id: '', name: 'busniess', imageName: 'busniess'),
    CategoryModels(id: '', name: 'sport', imageName: 'sport'),
    CategoryModels(id: '', name: 'helth', imageName: 'helth'),
    CategoryModels(id: '', name: 'entertainment', imageName: 'entertainment'),
    CategoryModels(id: '', name: 'science', imageName: 'science'),
    CategoryModels(id: '', name: 'technology', imageName: 'technology'),
  ];
}
