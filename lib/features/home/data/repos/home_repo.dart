import '../../domain/entities/character.dart';
import '../../domain/entities/poster.dart';
import '../../domain/repos/home_repo.dart';
import '../data_source/remote_home_data_source.dart';

class HomeRepoImpl implements HomeRepo {
  final RemoteHomeDataSource _remoteData;

  HomeRepoImpl(this._remoteData);

  @override
  List<Poster> getPosters() {
    return _remoteData.getPosters();
  }

  @override
  List<Character> getCharacters() {
    return _remoteData.getCharacters();
  }
}
