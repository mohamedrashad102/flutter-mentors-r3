import 'coffee.dart';

class Espresso extends Coffee {
  const Espresso()
      : super(
          name: 'Espresso',
          emoji: '☕',
          description: 'Strong and bold coffee shot',
          type: CoffeeType.espresso,
        );
}
