### 📄 `services_locator.dart`

#### 🧩 Purpose

Initializes and configures the `get_it` service locator for dependency injection throughout the app.

#### ⚙️ Classes / Functions

*   `final di = GetIt.instance`: The global service locator instance.
*   `Future<void> setupLocator()`: Registers all application dependencies, such as data sources, repositories, use cases, and cubits.
