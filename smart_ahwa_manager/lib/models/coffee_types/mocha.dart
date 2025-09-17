import 'coffee.dart';

class Mocha extends Coffee {
  const Mocha()
      : super(
          name: 'Mocha',
          emoji: '🍫',
          description: 'Espresso with chocolate and milk',
          type: CoffeeType.mocha,
        );
}
