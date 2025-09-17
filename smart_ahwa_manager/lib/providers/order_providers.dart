import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smart_ahwa_manager/services/local_order_services.dart';
import 'package:smart_ahwa_manager/services/memory_order_services.dart';

import '../models/order.dart';
import '../reports/orders_report.dart';
import '../services/order_services.dart';

// SharedPreferences provider
final sharedPreferencesProvider = FutureProvider<SharedPreferences>((
  ref,
) async {
  return await SharedPreferences.getInstance();
});

// Order services provider
final orderServicesProvider = Provider<OrderServices>((ref) {
  final sharedPreferencesAsync = ref.watch(sharedPreferencesProvider);

  sharedPreferencesAsync.whenData(
    (sharedPreferences) => sharedPreferences.clear(),
  );
  return sharedPreferencesAsync.when(
    data: (sharedPreferences) => LocalOrderServices(sharedPreferences),
    loading: () => MemoryOrderServices(), // Fallback to memory during loading
    error: (_, __) => MemoryOrderServices(), // Fallback to memory on error
  );
});

// Orders state provider
final ordersProvider =
    StateNotifierProvider<OrdersNotifier, AsyncValue<List<Order>>>((ref) {
      final orderServices = ref.watch(orderServicesProvider);
      return OrdersNotifier(orderServices);
    });

// Pending orders provider
final pendingOrdersProvider = Provider<AsyncValue<List<Order>>>((ref) {
  final ordersAsync = ref.watch(ordersProvider);
  return ordersAsync.when(
    data: (orders) => AsyncValue.data(
      orders.where((order) => order.status == OrderStatus.pending).toList(),
    ),
    loading: () => const AsyncValue.loading(),
    error: (error, stackTrace) => AsyncValue.error(error, stackTrace),
  );
});

// Dashboard statistics provider
final dashboardStatsProvider = Provider<AsyncValue<OrdersReport>>((ref) {
  final ordersAsync = ref.watch(ordersProvider);
  return ordersAsync.when(
    data: (orders) => AsyncValue.data(OrdersReport(orders: orders)),
    loading: () => const AsyncValue.loading(),
    error: (error, stackTrace) => AsyncValue.error(error, stackTrace),
  );
});

// Order ID counter provider (for generating unique IDs)
final orderIdCounterProvider = StateProvider<int>((ref) {
  final ordersAsync = ref.watch(ordersProvider);
  return ordersAsync.when(
    data: (orders) => orders.isNotEmpty
        ? orders.map((order) => order.id).reduce((a, b) => a > b ? a : b) + 1
        : 1,
    loading: () => 1,
    error: (_, __) => 1,
  );
});

class OrdersNotifier extends StateNotifier<AsyncValue<List<Order>>> {
  final OrderServices _orderServices;

  OrdersNotifier(this._orderServices) : super(const AsyncValue.loading()) {
    _loadOrders();
  }

  Future<void> _loadOrders() async {
    try {
      final orders = await _orderServices.getOrders();
      state = AsyncValue.data(orders);
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    }
  }

  Future<void> addOrder(Order order) async {
    try {
      await _orderServices.addOrder(order);
      await _loadOrders(); // Refresh the orders list
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    }
  }

  Future<void> markOrderAsCompleted(int orderId) async {
    try {
      await _orderServices.markAsCompleted(orderId);
      await _loadOrders(); // Refresh the orders list
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    }
  }

  Future<void> refreshOrders() async {
    state = const AsyncValue.loading();
    await _loadOrders();
  }
}
