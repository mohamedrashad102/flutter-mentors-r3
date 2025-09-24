import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/data_source/remote_home_data_source.dart';
import '../../data/repos/home_repo.dart';
import '../../domain/repos/home_repo.dart';

final remotePostersDataSourceProvider = Provider<RemoteHomeDataSource>((ref) {
  return RemoteHomeDataSource();
});

final homeRepoProvider = Provider<HomeRepo>((ref) {
  final remoteData = ref.read(remotePostersDataSourceProvider);
  return HomeRepoImpl(remoteData);
});

final remoteCharactersDataSourceProvider = Provider<RemoteHomeDataSource>((
  ref,
) {
  return RemoteHomeDataSource();
});
