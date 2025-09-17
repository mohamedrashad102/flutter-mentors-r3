import '../models/coffee_types/americano.dart';
import '../models/coffee_types/cappuccino.dart';
import '../models/coffee_types/coffee.dart';
import '../models/coffee_types/espresso.dart';
import '../models/coffee_types/latte.dart';
import '../models/coffee_types/mocha.dart';
import '../models/coffee_types/turkish_coffee.dart';

class CoffeeFactory {
  Coffee create(CoffeeType type) {
    return switch (type) {
      CoffeeType.espresso => Espresso(),
      CoffeeType.latte => Latte(),
      CoffeeType.cappuccino => Cappuccino(),
      CoffeeType.mocha => Mocha(),
      CoffeeType.turkishCoffee => TurkishCoffee(),
      CoffeeType.americano => const Americano(),
    };
  }

  Coffee createFromString(String type) {
    final coffeeType = CoffeeType.values.firstWhere((e) => e.name == type);
    return create(coffeeType);
  }
}
