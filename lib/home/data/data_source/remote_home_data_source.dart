import '../../domain/entities/character.dart';
import '../../domain/entities/poster.dart' show Poster;

class RemoteHomeDataSource {
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

  List<Character> getCharacters([
    int page = 4,
    List<Character> oldCharacters = const [],
  ]) {
    if (page == 0) {
      return oldCharacters;
    }
    final characters = [
      ...oldCharacters,
      Character(
        name: 'Gon Freecss',
        image: 'assets/images/character1.png',
        series: 'Hunter x Hunter',
      ),
      Character(
        name: 'Naruto Uzumaki',
        image: 'assets/images/character2.png',
        series: 'Naruto',
      ),
      Character(
        name: 'Luffy',
        image: 'assets/images/character3.png',
        series: 'One Piece',
      ),
      Character(
        name: 'Conan Edogawa',
        image: 'assets/images/character4.png',
        series: 'Detective Conan',
      ),
      Character(
        name: 'Goku',
        image: 'assets/images/character5.png',
        series: 'Dragon Ball',
      ),
    ];
    return getCharacters(page - 1, characters);
  }
}
