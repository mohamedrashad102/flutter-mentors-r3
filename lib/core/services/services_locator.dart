import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

final di = GetIt.instance;

Future<void> setupLocator() async {
  final pref = await SharedPreferences.getInstance();

  di.registerSingleton<SharedPreferences>(pref);
}
