import '../../domain/entities/poster.dart';
import '../../domain/repos/home_repo.dart';
import '../remote_movies_data_source.dart';

class HomeRepoImpl implements HomeRepo {
  final RemotePostersDataSource _remoteData;

  HomeRepoImpl(this._remoteData);

  @override
  List<Poster> getPosters() {
    return _remoteData.getPosters();
  }
}
