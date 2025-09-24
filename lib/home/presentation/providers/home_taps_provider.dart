import 'package:flutter_riverpod/flutter_riverpod.dart';

final homeTapsProvider = NotifierProvider<HomeTapsNotifier, HomeTapsState>(
  () => HomeTapsNotifier(),
);

class HomeTapsState {
  final int index;
  HomeTapsState({required this.index});

  bool get isFirst => index == 0;
  bool get isLast => index == HomeTapsNotifier.taps.length - 1;

  bool isCurrentIndex(int index) => this.index == index;
}

class HomeTapsNotifier extends Notifier<HomeTapsState> {
  @override
  build() {
    return HomeTapsState(index: 0);
  }

  static const taps = [
    'All',
    'Popular',
    'Trending',
    'New Releases',
    'Top Rated',
  ];

  void updateIndex(int index) {
    state = HomeTapsState(index: index);
  }
}
