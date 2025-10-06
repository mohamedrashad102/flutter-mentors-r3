import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider_challenge/cubits/counter_cubit.dart';
import 'package:provider_challenge/screens/screen_d.dart';

class PageC extends StatelessWidget {
  const PageC({super.key, required this.counterCubit});

  final CounterCubit counterCubit;

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(value: counterCubit, child: const ScreenC());
  }
}

class ScreenC extends StatelessWidget {
  const ScreenC({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Page C')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _counterValue(),
            const SizedBox(height: 20),
            _incrementButton(context),
            const SizedBox(height: 20),
            _navigatorButton(context),
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

  ElevatedButton _navigatorButton(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => PageD()),
        );
      },
      child: const Text('Go to Page D'),
    );
  }
}
