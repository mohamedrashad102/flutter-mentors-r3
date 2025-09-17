import 'coffee.dart';

class TurkishCoffee extends Coffee {
  const TurkishCoffee()
      : super(
          name: 'Turkish Coffee',
          emoji: '☕',
          description: 'Traditional unfiltered coffee',
          type: CoffeeType.turkishCoffee,
        );
}
