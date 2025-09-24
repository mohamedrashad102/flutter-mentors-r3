import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/entities/poster.dart';
import 'di_providers.dart';

final postersProvider = Provider<List<Poster>>((ref) {
  final repo = ref.read(homeRepoProvider);
  return repo.getPosters();
});
