import 'package:smart_ahwa_manager/models/order.dart';
import 'package:smart_ahwa_manager/services/order_services.dart';

class MemoryOrderServices implements OrderServices {
  final List<Order> _orders = [];

  @override
  Future<void> addOrder(Order order) async {
    prepareOrder(order);
    _orders.add(order);
  }

  @override
  Future<List<Order>> getOrders() async {
    return _orders;
  }

  @override
  Future<void> markAsCompleted(int orderId) async {
    final orderIndex = _orders.indexWhere((order) => order.id == orderId);
    if (orderIndex != -1) {
      _orders[orderIndex] = _orders[orderIndex].copyWith(
        status: OrderStatus.completed,
      );
    }
  }

  void prepareOrder(Order order) {
    if (_orders.any((o) => o.id == order.id)) {
      throw Exception('Order already exists');
    } else if (order.status.name == OrderStatus.completed.name) {
      throw Exception('Order is already completed');
    }
    order.customerName.trim();
  }
}
