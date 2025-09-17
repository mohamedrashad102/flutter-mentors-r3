# ☕ Smart Ahwa Manager

A modern Flutter application for coffee shop order management with comprehensive business analytics and multi-platform support.

## 📱 Overview

Smart Ahwa Manager is a cross-platform coffee shop management application built with Flutter. It provides an intuitive interface for managing coffee orders, tracking customer preferences, and generating detailed business reports. The app supports both mobile and desktop platforms with local data persistence.

## ✨ Features

- 📋 **Order Management**: Create, track, and manage coffee orders
- ☕ **Coffee Menu**: Support for various coffee types (Espresso, Latte, Cappuccino, Mocha, Turkish Coffee, Americano)
- 📊 **Business Analytics**: Comprehensive reporting with order statistics and insights
- 👤 **Customer Tracking**: Manage customer information and order history
- 💾 **Local Storage**: Persistent data storage using SharedPreferences
- 🔄 **Real-time Updates**: Dynamic order status management
- 📱 **Cross-Platform**: Works on Android, iOS, Web, and Desktop
- 🎨 **Modern UI**: Clean and intuitive Material Design interface

## 🛠️ Technology Stack

- **Framework**: Flutter SDK ^3.8.1
- **State Management**: Riverpod
- **Local Storage**: SharedPreferences
- **Architecture**: MVVM Pattern
- **Platform Support**: iOS, Android, Web, Windows, macOS, Linux

## 📁 Project Structure

```
lib/
├── factories/              # Coffee object creation
│   └── coffee_factory.dart
├── mappers/                # Data transformation utilities
│   └── order_mapper.dart
├── models/                 # Data models
│   ├── coffee_types/       # Coffee type definitions
│   ├── order.dart
│   └── order_statistic.dart
├── providers/              # State management
│   └── order_providers.dart
├── reports/                # Business analytics
│   └── orders_report.dart
├── services/               # Business logic layer
│   ├── local_order_services.dart
│   ├── memory_order_services.dart
│   └── order_services.dart
├── theme/                  # UI styling
│   └── coffee_theme.dart
├── views/                  # UI screens
│   ├── app_shell.dart
│   └── coffee_orders/
└── main.dart
```

## 🚀 Getting Started

### Prerequisites

Ensure you have the following installed:

- [Flutter SDK](https://flutter.dev/docs/get-started/install) (^3.8.1)
- [Dart SDK](https://dart.dev/get-dart)
- [Git](https://git-scm.com/downloads)
- IDE: [VS Code](https://code.visualstudio.com/) or [Android Studio](https://developer.android.com/studio)

### Installation

1. **Clone the repository**
   ```bash
   git clone <repository-url>
   cd smart_ahwa_manager
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Run the application**
   ```bash
   flutter run
   ```

### Platform-Specific Setup

#### For Android
```bash
flutter run -d android
```

#### For iOS (macOS only)
```bash
flutter run -d ios
```

#### For Web
```bash
flutter run -d web
```

#### For Desktop
```bash
# Windows
flutter run -d windows

# macOS
flutter run -d macos

# Linux
flutter run -d linux
```

## 📦 Dependencies

### Main Dependencies

| Package              | Version | Purpose                                   |
| -------------------- | ------- | ----------------------------------------- |
| `flutter_riverpod`   | ^2.4.9  | State management and dependency injection |
| `shared_preferences` | ^2.2.2  | Local data persistence                    |
| `equatable`          | ^2.0.5  | Value equality for models                 |
| `cupertino_icons`    | ^1.0.8  | iOS-style icons                           |

### Development Dependencies

| Package         | Version | Purpose            |
| --------------- | ------- | ------------------ |
| `flutter_test`  | SDK     | Testing framework  |
| `flutter_lints` | ^5.0.0  | Dart linting rules |

## 🎯 Core Functionality

### Order Management
- Create new coffee orders with customer details
- Track order status (Pending/Completed)
- Add notes and special instructions
- Mark orders as completed

### Coffee Types Supported
- ☕ **Espresso**: Classic Italian coffee shot
- 🥛 **Latte**: Espresso with steamed milk
- ☁️ **Cappuccino**: Espresso with foam and steamed milk
- 🍫 **Mocha**: Chocolate-flavored coffee variant
- 🇹🇷 **Turkish Coffee**: Traditional Turkish preparation
- ☕ **Americano**: Espresso with hot water

### Business Analytics
- Total order count
- Pending vs completed orders
- Most popular coffee types
- Customer statistics
- Performance metrics

### Data Persistence
- **Local Storage**: Orders saved locally using SharedPreferences
- **Memory Storage**: In-memory storage for development/testing
- **Data Mapping**: Efficient serialization and deserialization

## 🧪 Testing

Run the test suite:

```bash
# Run all tests
flutter test

# Run tests with coverage
flutter test --coverage

# Run integration tests
flutter test integration_test/
```

## 🔧 Build & Deployment

### Build for Production

```bash
# Android APK
flutter build apk --release

# Android Bundle
flutter build appbundle --release

# iOS (macOS only)
flutter build ios --release

# Web
flutter build web --release

# Windows
flutter build windows --release

# macOS
flutter build macos --release

# Linux
flutter build linux --release
```

### Code Quality

```bash
# Analyze code
flutter analyze

# Format code
flutter format .

# Check for outdated dependencies
flutter pub outdated
```

## 📱 Screenshots

*Add your app screenshots here to showcase the UI*

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 🙋‍♀️ Support

If you encounter any issues or have questions:

1. Check the [Issues](../../issues) page
2. Create a new issue if your problem isn't already listed
3. Provide detailed information about your environment and the issue

## 🚀 Future Enhancements

- [ ] User authentication and authorization
- [ ] Cloud synchronization
- [ ] Push notifications
- [ ] Advanced reporting with charts
- [ ] Multi-language support
- [ ] Dark theme support
- [ ] Export data functionality
- [ ] Integration with payment systems
- [ ] Advanced navigation system

---

**Made with ❤️ using Flutter**
