import '../entities/character.dart';
import '../entities/poster.dart';

abstract class HomeRepo {
  List<Poster> getPosters();
  List<Character> getCharacters();
}
