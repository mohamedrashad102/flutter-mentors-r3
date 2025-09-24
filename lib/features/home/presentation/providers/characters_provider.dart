import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/entities/character.dart';
import 'di_providers.dart';

final charactersProvider = Provider<List<Character>>((ref) {
  final getCharacters = ref.read(getCharactersProvider);
  return getCharacters();
});
