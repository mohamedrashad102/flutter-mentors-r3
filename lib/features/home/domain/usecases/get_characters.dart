import '../entities/character.dart';
import '../repos/home_repo.dart';

class GetCharacters {
  final HomeRepo _repository;
  GetCharacters(this._repository);

  List<Character> call() {
    return _repository.getCharacters();
  }
}