import '../domain/entities/poster.dart' show Poster;

class RemotePostersDataSource {
  List<Poster> getPosters([int page = 4, List<Poster> oldPosters = const []]) {
    if (page == 0) {
      return oldPosters;
    }
    final posters = [
      ...oldPosters,
      Poster(
        title: 'Detective Conan',
        type: 'Mystery',
        posterPath: 'assets/images/poster1.png',
      ),
      Poster(
        title: 'Hunter x Hunter',
        type: 'Adventure',
        posterPath: 'assets/images/poster2.png',
      ),
      Poster(
        title: 'Dragon Ball Z',
        type: 'Action',
        posterPath: 'assets/images/poster3.png',
      ),
    ];
    return getPosters(page - 1, posters);
  }
}
