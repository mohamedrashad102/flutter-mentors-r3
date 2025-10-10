import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/services/services_locator.dart';
import '../../../../core/widgets/custom_text_field.dart';
import '../cubits/home_cubit.dart';
import '../widgets/category_card.dart';
import '../widgets/product_card.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => di<HomeCubit>()..fetchInitialData(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Laza'),
          elevation: 0,
          backgroundColor: Colors.transparent,
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomTextField(
                controller: _searchController,
                labelText: 'Search',
                prefixIcon: const Icon(Icons.search),
                onFieldSubmitted: (value) {
                  context.read<HomeCubit>().fetchInitialData(searchTerm: value);
                },
              ),
              const SizedBox(height: 20),
              const Text(
                'Categories',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              BlocBuilder<HomeCubit, HomeState>(
                buildWhen: (previous, current) =>
                    current is HomeLoaded || current is HomeLoading,
                builder: (context, state) {
                  if (state is HomeLoaded) {
                    return SizedBox(
                      height: 100,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: state.categories.length,
                        itemBuilder: (context, index) {
                          final category = state.categories[index];
                          return CategoryCard(category: category);
                        },
                      ),
                    );
                  }
                  return const Center(child: CircularProgressIndicator());
                },
              ),
              const SizedBox(height: 20),
              const Text(
                'Products',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              Expanded(
                child: BlocBuilder<HomeCubit, HomeState>(
                  builder: (context, state) {
                    if (state is HomeLoading) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (state is HomeError) {
                      return Center(child: Text(state.message));
                    } else if (state is HomeLoaded) {
                      return GridView.builder(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              childAspectRatio: 0.7,
                              crossAxisSpacing: 15,
                              mainAxisSpacing: 15,
                            ),
                        itemCount: state.hasReachedMax
                            ? state.products.length
                            : state.products.length + 1,
                        itemBuilder: (context, index) {
                          if (index >= state.products.length) {
                            context.read<HomeCubit>().fetchMoreProducts();
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                          final product = state.products[index];
                          return ProductCard(product: product);
                        },
                      );
                    }
                    return const SizedBox.shrink();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
