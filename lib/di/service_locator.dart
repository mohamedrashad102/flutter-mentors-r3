
import 'package:get_it/get_it.dart';
import 'package:provider_challenge/cubits/counter_cubit.dart';

final getIt = GetIt.instance;

void setup() {
  getIt.registerFactory(() => CounterCubit());
}
