import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'coffee_orders/add_order_view.dart';
import 'coffee_orders/dashboard_view.dart';
import 'coffee_orders/pending_orders_view.dart';

final selectedIndexProvider = StateProvider<int>((ref) => 1);

class AppShell extends ConsumerWidget {
  const AppShell({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedIndex = ref.watch(selectedIndexProvider);

    final List<Widget> pages = [
      const DashboardView(),
      const AddOrderView(),
      const PendingOrdersView(),
    ];

    return Scaffold(
      body: IndexedStack(index: selectedIndex, children: pages),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.1),
              blurRadius: 8,
              offset: const Offset(0, -2),
            ),
          ],
        ),
        child: BottomNavigationBar(
          currentIndex: selectedIndex,
          onTap: (index) {
            ref.read(selectedIndexProvider.notifier).state = index;
          },
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.dashboard_outlined),
              activeIcon: Icon(Icons.dashboard),
              label: 'Dashboard',
              tooltip: 'Dashboard',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.add_circle_outline),
              activeIcon: Icon(Icons.add_circle),
              label: 'New Order',
              tooltip: 'Add New Order',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.pending_actions_outlined),
              activeIcon: Icon(Icons.pending_actions),
              label: 'Pending',
              tooltip: 'Pending Orders',
            ),
          ],
        ),
      ),
    );
  }
}
