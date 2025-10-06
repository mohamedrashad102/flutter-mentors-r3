# Flutter Challenge: Multi-page Counter App

This project is a Flutter application that demonstrates a simple multi-page app with specific state management requirements. The app consists of four pages (A, B, C, and D) with two separate counters.

## The Challenge

The goal of this challenge was to build a Flutter app with the following features:

- **Four Pages:** A, B, C, and D.
- **Navigation:** A -> B -> C -> D.
- **Shared Counter:** Pages B and C share a counter. Any change in one should be reflected in the other.
- **Independent Counter:** Page D has its own independent counter.
- **Reset Logic:**
    - The shared counter (B and C) must reset to 0 every time the user navigates from A to B.
    - The independent counter (D) must reset to 0 every time Page D is opened.

## The Solution

This solution uses the `flutter_bloc` package for state management (specifically Cubit) and the `get_it` package for dependency injection.

### Project Structure

The project is structured into the following directories:

- `lib/cubits`: Contains the `CounterCubit` for managing the state of the counters.
- `lib/di`: Contains the service locator setup for `get_it`.
- `lib/screens`: Contains the widgets for each of the four pages.

### How it Works

- **Dependency Injection:** The `get_it` service locator is configured to provide a new instance of `CounterCubit` every time it's requested. This is achieved by using `registerFactory` in the service locator setup, which is the key to resetting the counters.

- **Page A:** A simple screen with a button to navigate to Page B.

- **Page B:** When navigating to Page B, a new `CounterCubit` instance is created using `getIt<CounterCubit>()` and provided to the widget tree using `BlocProvider`. This ensures the counter is always reset to 0.

- **Page C:** To share the counter state with Page B, the existing `CounterCubit` instance from Page B is passed to Page C and provided to the widget tree using `BlocProvider.value`.

- **Page D:** Like Page B, a new `CounterCubit` instance is created using `getIt<CounterCubit>()` when navigating to Page D, ensuring it has its own independent and reset counter.