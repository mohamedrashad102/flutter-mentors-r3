import '../models/order.dart';

abstract class OrderServices {
  Future<List<Order>> getOrders();
  Future<void> addOrder(Order order);
  Future<void> markAsCompleted(int orderId);
}
