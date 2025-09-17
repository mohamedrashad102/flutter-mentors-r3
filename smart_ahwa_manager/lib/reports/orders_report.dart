import '../models/coffee_types/coffee.dart';
import '../models/order.dart';
import '../models/order_statistic.dart';

class OrdersReport {
  final List<Order> orders;

  const OrdersReport({required this.orders});

  int getTotalOrders() => orders.length;

  int getTotalPendingOrders() =>
      orders.where((order) => order.status == OrderStatus.pending).length;

  int getTotalCompletedOrders() =>
      orders.where((order) => order.status == OrderStatus.completed).length;

  Coffee getMostPopularCoffee() {
    final Map<Coffee, int> coffeeCount = {};
    for (final order in orders) {
      coffeeCount.update(order.coffee, (count) => count + 1, ifAbsent: () => 1);
    }
    return coffeeCount.entries.reduce((a, b) => a.value > b.value ? a : b).key;
  }

  OrderStatistic getCoffeeStatistic(Coffee coffee) {
    final int numberOfOrders = orders
        .where((order) => order.coffee == coffee)
        .length;
    final double percentage = numberOfOrders / getTotalOrders() * 100;
    return OrderStatistic(
      numberOfOrders: numberOfOrders,
      percentage: percentage,
    );
  }

  double getCompletedOrdersPercentage() =>
      getTotalCompletedOrders() / getTotalOrders() * 100;

  int getMostPopularCoffeeOrders() =>
      orders.where((order) => order.coffee == getMostPopularCoffee()).length;
}
