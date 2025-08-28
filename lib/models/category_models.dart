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
    CategoryModels(id: 'general', name: 'general', imageName: 'general'),
    CategoryModels(id: 'business', name: 'busniess', imageName: 'busniess'),
    CategoryModels(id: 'sports', name: 'sport', imageName: 'sport'),
    CategoryModels(id: 'health', name: 'helth', imageName: 'helth'),
    CategoryModels(
      id: 'entertainment',
      name: 'entertainment',
      imageName: 'entertainment',
    ),
    CategoryModels(id: 'science', name: 'science', imageName: 'science'),
    CategoryModels(
      id: 'technology',
      name: 'technology',
      imageName: 'technology',
    ),
  ];
}
