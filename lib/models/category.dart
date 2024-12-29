class CategoryModel {
  static String sportsid = 'sports';
  static String musicid = 'music';
  static String moviesid = 'movies';
  String id;
  late String title;
  late String image;
  CategoryModel({required this.id, required this.title, required this.image});
  // //CategoryModel.fromid(this.id) {
  //   if (id == sportsid) {
  //     title = 'Sports';
  //     image = 'assets/sports.png';
  //   } else if (id == musicid) {
  //     title = 'Music';
  //     image = 'assets/music.png';
  //   } else if (id == moviesid) {
  //     title = 'Movies';
  //     image = 'assets/movies.png';
  //   }
  // }
  static List<CategoryModel> getCategries() {
    return [
      CategoryModel(id: sportsid, title: 'Sports', image: 'assets/sports.png'),
      CategoryModel(id: musicid, title: 'Music', image: 'assets/music.png'),
      CategoryModel(id: moviesid, title: 'Movies', image: 'assets/movies.png'),
    ];
  }
}
