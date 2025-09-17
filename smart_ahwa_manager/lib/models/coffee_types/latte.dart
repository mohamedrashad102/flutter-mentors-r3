import 'coffee.dart';

class Latte extends Coffee {
  const Latte()
      : super(
          name: 'Latte',
          emoji: '🤍',
          description: 'Espresso with smooth steamed milk',
          type: CoffeeType.latte,
        );
}
