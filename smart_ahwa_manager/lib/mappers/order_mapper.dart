import '../factories/coffee_factory.dart';
import '../models/order.dart';

class OrderMapper {
  static Map<String, dynamic> toMap(Order order) {
    return {
      'id': order.id,
      'customerName': order.customerName,
      'coffeeType': order.coffee.type.name,
      'status': order.status.name,
      'createdAt': order.createdAt.toIso8601String(),
      'notes': order.notes,
    };
  }

  static Order fromMap(Map<String, dynamic> map) {
    final coffeeFactor = CoffeeFactory();
    return Order(
      id: map['id'],
      customerName: map['customerName'],
      coffee: coffeeFactor.create(map['coffeeType']),
      status: OrderStatus.values.firstWhere((e) => e.name == map['status']),
      createdAt: DateTime.parse(map['createdAt']),
      notes: map['notes'],
    );
  }
}
