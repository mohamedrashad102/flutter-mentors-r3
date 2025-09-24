import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/remote_movies_data_source.dart';
import '../../data/repos/home_repo.dart';
import '../../domain/repos/home_repo.dart';

final remotePostersDataSourceProvider = Provider<RemotePostersDataSource>((
  ref,
) {
  return RemotePostersDataSource();
});

final homeRepoProvider = Provider<HomeRepo>((ref) {
  final remoteData = ref.read(remotePostersDataSourceProvider);
  return HomeRepoImpl(remoteData);
});
