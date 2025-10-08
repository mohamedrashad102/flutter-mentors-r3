# Gemini Project Context: Laza E-commerce App

This document provides a comprehensive overview of the Laza E-commerce App, a Flutter project. It is intended to be used as instructional context for Gemini to understand the project's architecture, conventions, and key components.

## Project Overview

Laza is a modern e-commerce application for accessories, built with Flutter. The project follows the principles of **Clean Architecture**, separating the code into three main layers: Domain, Data, and Presentation. The codebase is organized by feature, with a `core` directory for shared functionalities.

### Key Technologies & Packages:

*   **State Management**: `flutter_bloc` (using Cubits) for predictable state management.
*   **Navigation**: `go_router` for declarative routing.
*   **Networking**: `dio` for powerful and reliable HTTP requests. The project includes a custom `DioHelper` class that handles token refresh, logging, and error handling. The API base URL is `https://accessories-eshop.runasp.net/api`.
*   **Dependency Injection**: `get_it` for service location.
*   **Value Equality**: `equatable` to avoid boilerplate for `==` and `hashCode`.
*   **Storage**: `shared_preferences` and `flutter_secure_storage` for local data and token storage.
*   **UI Helpers**: `device_preview` for easy testing on different screen sizes, and `gap` for spacing in layouts.

## Building and Running

To get a local copy up and running, follow these steps:

1.  **Install packages:**
    ```sh
    flutter pub get
    ```
2.  **Run the app:**
    ```sh
    flutter run
    ```
3.  **Run tests:**
    ```sh
    flutter test
    ```

## Development Conventions

### Coding Style

The project uses `flutter_lints` with the following additional rules enforced in `analysis_options.yaml`:

*   `prefer_const_constructors`
*   `prefer_relative_imports`

### Documentation

The project has a defined format for documenting files in the `core` directory, as specified in `docs/docs_rules.md`. The documentation is generated in Markdown format and includes the purpose of the file and a list of its classes and functions.

### Asset Management

The project uses the `flutter_assets` package to generate a class named `AppAssets` in `lib/core/utils/app_assets.dart` for all assets located in the `assets/` directory. This provides a type-safe way to access assets in the code.

### Folder Structure

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
