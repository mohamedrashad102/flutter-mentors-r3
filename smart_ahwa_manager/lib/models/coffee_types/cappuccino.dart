import 'coffee.dart';

class Cappuccino extends Coffee {
  const Cappuccino()
      : super(
          name: 'Cappuccino',
          emoji: '🥛',
          description: 'Espresso with steamed milk foam',
          type: CoffeeType.cappuccino,
        );
}
