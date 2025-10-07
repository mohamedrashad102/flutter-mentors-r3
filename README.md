# Laza E-commerce App

A modern e-commerce application for accessories, built with Flutter.

## ✨ Features

*   **Authentication**: Full auth flow including login, registration, and email verification.
*   **Splash & Welcome Screens**: An engaging onboarding experience for new users.
*   **Clean Architecture**: A robust and scalable architecture separating business logic from UI.
*   **State Management**: Predictable state management using BLoC (Cubit).
*   **Theming**: A centralized theme system for a consistent look and feel.

## 🚀 Getting Started

To get a local copy up and running, follow these simple steps.

### Prerequisites

*   Flutter SDK: [https://flutter.dev/docs/get-started/install](https://flutter.dev/docs/get-started/install)

### Installation

1.  Clone the repo
    ```sh
    git clone https://github.com/your_username/laza.git
    ```
2.  Install packages
    ```sh
    flutter pub get
    ```
3.  Run the app
    ```sh
    flutter run
    ```

## 🏗️ Architecture

This project follows the principles of **Clean Architecture**, separating the code into three main layers:

*   **Domain**: Contains the core business logic, entities, and use cases. It is the innermost layer and has no dependencies on other layers.
*   **Data**: Implements the repository contracts defined in the domain layer and handles data retrieval from remote (API) or local sources.
*   **Presentation**: Contains the UI (views/widgets) and state management logic (Cubits).

### Key Packages

*   **State Management**: [`flutter_bloc`](https://pub.dev/packages/flutter_bloc) for predictable state management.
*   **Navigation**: [`go_router`](https://pub.dev/packages/go_router) for declarative routing.
*   **Networking**: [`dio`](https://pub.dev/packages/dio) for powerful and reliable HTTP requests.
*   **Dependency Injection**: [`get_it`](https://pub.dev/packages/get_it) for service location.
*   **Value Equality**: [`equatable`](https://pub.dev/packages/equatable) to avoid boilerplate for `==` and `hashCode`.

## 📁 Folder Structure

The project is organized by feature, with a `core` directory for shared functionalities.

```
lib
├── core/           # Shared utilities, services, and widgets
├── features/       # Feature-based modules
│   └── auth/       # Authentication feature
│       ├── data/
│       ├── domain/
│       └── presentation/
└── main.dart       # App entry point
```