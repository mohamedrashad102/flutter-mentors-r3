import 'package:equatable/equatable.dart';

enum CoffeeType {
  espresso,
  cappuccino,
  latte,
  americano,
  mocha,
  turkishCoffee;
}

abstract class Coffee extends Equatable {
  final String name;
  final String emoji;
  final String description;
  final CoffeeType type;

  const Coffee({
    required this.name,
    required this.emoji,
    required this.description,
    required this.type,
  });

  @override
  List<Object?> get props => [name, emoji, description, type];
}
