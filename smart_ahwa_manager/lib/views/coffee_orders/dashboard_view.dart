import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../providers/order_providers.dart';
import '../../theme/coffee_theme.dart';
import '../app_shell.dart';

class DashboardView extends ConsumerWidget {
  const DashboardView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dashboardStatsAsync = ref.watch(dashboardStatsProvider);
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: CoffeeColors.cream,
      appBar: AppBar(
        title: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: CoffeeColors.textOnPrimary.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Icon(
                Icons.coffee,
                color: CoffeeColors.textOnPrimary,
                size: 24,
              ),
            ),
            const SizedBox(width: 12),
            const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Smart Ahwa',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: CoffeeColors.textOnPrimary,
                  ),
                ),
                Text(
                  'Manager Dashboard',
                  style: TextStyle(
                    fontSize: 12,
                    color: CoffeeColors.textOnPrimary,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      body: RefreshIndicator(
        onRefresh: () => ref.read(ordersProvider.notifier).refreshOrders(),
        color: CoffeeColors.primaryBrown,
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Column(
            children: [
              // Header Gradient Section
              Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [CoffeeColors.primaryBrown, CoffeeColors.mocha],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 0, 20, 32),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Good morning! ☀️',
                        style: TextStyle(
                          color: CoffeeColors.textOnPrimary,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 4),
                      const Text(
                        'Ready to brew some success?',
                        style: TextStyle(
                          color: CoffeeColors.textOnPrimary,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 24),
                      _QuickActionsRow(ref: ref),
                    ],
                  ),
                ),
              ),

              // Main Content
              Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Icon(
                          Icons.analytics_outlined,
                          color: CoffeeColors.primaryBrown,
                          size: 20,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          'Business Analytics',
                          style: theme.textTheme.headlineSmall?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: CoffeeColors.textPrimary,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    dashboardStatsAsync.when(
                      data: (report) => _StatisticsSection(report: report),
                      loading: () => const _LoadingSection(),
                      error: (error, stackTrace) => _ErrorCard(
                        message: 'Failed to load analytics',
                        onRetry: () =>
                            ref.read(ordersProvider.notifier).refreshOrders(),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _QuickActionsRow extends StatelessWidget {
  final WidgetRef ref;

  const _QuickActionsRow({required this.ref});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _QuickActionCard(
            title: 'New Order',
            subtitle: 'Create order',
            icon: Icons.add_circle_rounded,
            onTap: () => ref.read(selectedIndexProvider.notifier).state = 1,
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: _QuickActionCard(
            title: 'Pending',
            subtitle: 'View orders',
            icon: Icons.pending_actions_rounded,
            onTap: () => ref.read(selectedIndexProvider.notifier).state = 2,
          ),
        ),
      ],
    );
  }
}

class _QuickActionCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final VoidCallback onTap;

  const _QuickActionCard({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: CoffeeColors.textOnPrimary.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: CoffeeColors.textOnPrimary.withValues(alpha: 0.2),
        ),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(16),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                Icon(icon, size: 32, color: CoffeeColors.textOnPrimary),
                const SizedBox(height: 8),
                Text(
                  title,
                  style: const TextStyle(
                    color: CoffeeColors.textOnPrimary,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  subtitle,
                  style: TextStyle(
                    color: CoffeeColors.textOnPrimary.withValues(alpha: 0.8),
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _LoadingSection extends StatelessWidget {
  const _LoadingSection();

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Padding(
        padding: EdgeInsets.all(40),
        child: Column(
          children: [
            CircularProgressIndicator(color: CoffeeColors.primaryBrown),
            SizedBox(height: 16),
            Text(
              'Brewing your analytics...',
              style: TextStyle(color: CoffeeColors.textSecondary),
            ),
          ],
        ),
      ),
    );
  }
}

class _StatisticsSection extends StatelessWidget {
  final dynamic report;

  const _StatisticsSection({required this.report});

  @override
  Widget build(BuildContext context) {
    final totalOrders = report.getTotalOrders();
    final pendingOrders = report.getTotalPendingOrders();
    final completedOrders = report.getTotalCompletedOrders();
    final completionRate = totalOrders > 0
        ? (completedOrders / totalOrders * 100).toStringAsFixed(1)
        : '0.0';

    return Column(
      children: [
        // Summary Cards Grid
        GridView.count(
          crossAxisCount: 2,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          childAspectRatio: 1.22,
          mainAxisSpacing: 16,
          crossAxisSpacing: 16,
          children: [
            _StatCard(
              title: 'Total Orders',
              value: totalOrders.toString(),
              icon: Icons.receipt_long_rounded,
              color: CoffeeColors.primaryBrown,
              subtitle: 'All time',
            ),
            _StatCard(
              title: 'Pending',
              value: pendingOrders.toString(),
              icon: Icons.schedule_rounded,
              color: CoffeeColors.pendingOrange,
              subtitle: 'Awaiting',
            ),
            _StatCard(
              title: 'Completed',
              value: completedOrders.toString(),
              icon: Icons.check_circle_rounded,
              color: CoffeeColors.completedGreen,
              subtitle: 'Finished',
            ),
            _StatCard(
              title: 'Success Rate',
              value: '$completionRate%',
              icon: Icons.trending_up_rounded,
              color: CoffeeColors.accent1,
              subtitle: 'Performance',
            ),
          ],
        ),

        const SizedBox(height: 24),

        if (totalOrders > 0)
          _MostPopularSection(report: report)
        else ...[
          _EmptyStateCard(),
        ],
      ],
    );
  }
}

class _MostPopularSection extends StatelessWidget {
  final dynamic report;

  const _MostPopularSection({required this.report});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Row(
          children: [
            Icon(Icons.star_rounded, color: CoffeeColors.accent1, size: 20),
            SizedBox(width: 8),
            Text(
              'Popular Choice',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: CoffeeColors.textPrimary,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        _MostPopularCoffeeCard(report: report),
      ],
    );
  }
}

class _StatCard extends StatelessWidget {
  final String title;
  final String value;
  final String subtitle;
  final IconData icon;
  final Color color;

  const _StatCard({
    required this.title,
    required this.value,
    required this.subtitle,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: CoffeeColors.surfaceLight,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: CoffeeColors.darkBrown.withValues(alpha: 0.1),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
        border: Border.all(color: color.withValues(alpha: 0.2), width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(icon, size: 20, color: color),
              ),
              const Spacer(),
              Text(
                subtitle,
                style: TextStyle(
                  color: CoffeeColors.textSecondary,
                  fontSize: 11,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            value,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          Text(
            title,
            style: const TextStyle(
              fontSize: 13,
              color: CoffeeColors.textSecondary,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}

class _MostPopularCoffeeCard extends StatelessWidget {
  final dynamic report;

  const _MostPopularCoffeeCard({required this.report});

  @override
  Widget build(BuildContext context) {
    final mostPopularCoffee = report.getMostPopularCoffee();
    final coffeeStats = report.getCoffeeStatistic(mostPopularCoffee);

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: CoffeeColors.surfaceLight,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: CoffeeColors.darkBrown.withValues(alpha: 0.1),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
        gradient: LinearGradient(
          colors: [CoffeeColors.cream, CoffeeColors.surfaceLight],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 64,
            height: 64,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [CoffeeColors.accent1, CoffeeColors.primaryBrown],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: CoffeeColors.primaryBrown.withValues(alpha: 0.3),
                  blurRadius: 8,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Center(
              child: Text(
                mostPopularCoffee.emoji,
                style: const TextStyle(fontSize: 32),
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  mostPopularCoffee.name,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: CoffeeColors.textPrimary,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  mostPopularCoffee.description,
                  style: const TextStyle(
                    fontSize: 12,
                    color: CoffeeColors.textSecondary,
                  ),
                ),
                const SizedBox(height: 8),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: CoffeeColors.accent1.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    '${coffeeStats.numberOfOrders} orders • ${coffeeStats.percentage.toStringAsFixed(1)}% of total',
                    style: const TextStyle(
                      fontSize: 11,
                      color: CoffeeColors.accent1,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _EmptyStateCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(40),
      decoration: BoxDecoration(
        color: CoffeeColors.surfaceLight,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: CoffeeColors.darkBrown.withValues(alpha: 0.1),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: const Column(
        children: [
          Icon(
            Icons.local_cafe_outlined,
            size: 80,
            color: CoffeeColors.lightBrown,
          ),
          SizedBox(height: 20),
          Text(
            'No orders yet',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: CoffeeColors.textPrimary,
            ),
          ),
          SizedBox(height: 8),
          Text(
            'Your coffee journey starts here.\nCreate your first order to see analytics!',
            style: TextStyle(fontSize: 14, color: CoffeeColors.textSecondary),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

class _ErrorCard extends StatelessWidget {
  final String message;
  final VoidCallback onRetry;

  const _ErrorCard({required this.message, required this.onRetry});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: CoffeeColors.surfaceLight,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.red.withValues(alpha: 0.3)),
      ),
      child: Column(
        children: [
          const Icon(Icons.error_outline_rounded, size: 48, color: Colors.red),
          const SizedBox(height: 12),
          const Text(
            'Something went wrong',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: CoffeeColors.textPrimary,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            message,
            style: const TextStyle(
              fontSize: 14,
              color: CoffeeColors.textSecondary,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          FilledButton.icon(
            onPressed: onRetry,
            icon: const Icon(Icons.refresh_rounded),
            label: const Text('Try Again'),
          ),
        ],
      ),
    );
  }
}
