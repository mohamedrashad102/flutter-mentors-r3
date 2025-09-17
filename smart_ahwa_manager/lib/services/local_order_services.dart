import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:smart_ahwa_manager/mappers/order_mapper.dart';
import 'package:smart_ahwa_manager/models/order.dart';
import 'package:smart_ahwa_manager/services/order_services.dart';

class LocalOrderServices implements OrderServices {
  final SharedPreferences _sharedPreferences;

  LocalOrderServices(this._sharedPreferences);

  @override
  Future<void> addOrder(Order order) async {
    await prepareOrder(order);
    final orders = await getOrders();
    orders.add(order);
    final ordersMap = orders.map((order) => OrderMapper.toMap(order)).toList();
    await _sharedPreferences.setString('orders', jsonEncode(ordersMap));
  }

  @override
  Future<List<Order>> getOrders() async {
    final ordersMap = _sharedPreferences.getString('orders');
    if (ordersMap == null) {
      return [];
    }
    final orders = jsonDecode(ordersMap) as List;
    return orders.map((order) => OrderMapper.fromMap(order)).toList();
  }

  @override
  Future<void> markAsCompleted(int orderId) async {
    final orders = await getOrders();
    final orderIndex = orders.indexWhere((order) => order.id == orderId);
    if (orderIndex != -1) {
      orders[orderIndex] = orders[orderIndex].copyWith(
        status: OrderStatus.completed,
      );
    }
    final ordersMap = orders.map((order) => OrderMapper.toMap(order)).toList();
    await _sharedPreferences.setString('orders', jsonEncode(ordersMap));
  }

  Future<void> prepareOrder(Order order) async {
    final orders = await getOrders();
    if (orders.any((o) => o.id == order.id)) {
      throw Exception('Order already exists');
    }
    order.customerName.trim();
  }
}
