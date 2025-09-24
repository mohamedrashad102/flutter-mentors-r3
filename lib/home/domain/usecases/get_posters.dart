import '../entities/poster.dart';
import '../repos/home_repo.dart';

class GetPosters {
  final HomeRepo _repository;
  GetPosters(this._repository);

  List<Poster> call() {
    return _repository.getPosters();
  }
}
