import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider_challenge/cubits/counter_cubit.dart';

import '../di/service_locator.dart';

class PageD extends StatelessWidget {
  const PageD({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<CounterCubit>(),
      child: const ScreenD(),
    );
  }
}

class ScreenD extends StatelessWidget {
  const ScreenD({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Page D')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _counterValue(),
            const SizedBox(height: 20),
            _incrementButton(context),
          ],
        ),
      ),
    );
  }

  BlocBuilder<CounterCubit, int> _counterValue() {
    return BlocBuilder<CounterCubit, int>(
      builder: (context, count) {
        return Text('Counter: $count');
      },
    );
  }

  ElevatedButton _incrementButton(BuildContext context) {
    return ElevatedButton(
      onPressed: context.read<CounterCubit>().increment,
      child: const Text('Increment'),
    );
  }
}
