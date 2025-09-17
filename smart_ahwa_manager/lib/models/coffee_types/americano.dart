import 'coffee.dart';

class Americano extends Coffee {
  const Americano()
    : super(
        name: 'Americano',
        emoji: '🖤',
        description: 'Espresso diluted with hot water',
        type: CoffeeType.americano,
      );
}
