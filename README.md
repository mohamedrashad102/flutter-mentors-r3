# Flutter Widget Exploration

![Flutter](https://img.shields.io/badge/Flutter-3.x-blue.svg)
![License](https://img.shields.io/badge/License-MIT-green.svg)
![PRs Welcome](https://img.shields.io/badge/PRs-welcome-brightgreen.svg)

This repository is a collection of Flutter widget challenges completed as part of a mentorship program. It showcases practical implementations of various Flutter widgets and concepts, from basic interactions to advanced animations.

---

## 🚀 Key Features

*   **Interactive Physics Simulation:** A drag-and-drop game built with `Draggable` and `DragTarget`.
*   **Dismissible Lists:** A task list that uses the `Dismissible` widget for swipe-to-delete functionality with undo.
*   **Advanced Animation Chains:** A custom loading animation created by chaining multiple animations with `AnimationController`.

---

## 📂 Project Structure

The project is organized into two main folders:

```
lib/
├── advanced_animation_chain/
│   ├── views/
│   └── widgets/
├── interactive_dismissible_lists/
│   ├── models/
│   ├── providers/
│   ├── views/
│   └── widgets/
└── interactive_physics_widget/
    ├── views/
    └── widgets/

showcase/
├── advanced_animation_chain.mp4
├── interactive_physics_widget.mp4
└── interactive_dismissible_lists.mp4
```

*   `lib/`: Contains the source code for all the widget challenges. Each challenge is organized into its own feature folder.
*   `showcase/`: Contains video demonstrations of each completed challenge.

---

## 🎯 Challenges

### 1️⃣ Interactive Physics Widget

**Folder:** `lib/interactive_physics_widget/`

**Task:**
Use **Draggable** and **DragTarget** widgets to create a mini physics simulation where users drag colored balls into matching containers.

**Requirements:**
- ✅ Draggable colored balls (at least 3 colors)
- ✅ Matching colored drop targets
- ✅ Visual feedback during dragging
- ✅ Success state when correct matches are made
- ✅ Handles both correct and incorrect drops

**Key Widgets & Concepts:**
*   `Draggable`: To make the colored balls draggable.
*   `DragTarget`: To create drop zones for the balls.
*   `StatefulWidget`: To manage the state of the matched items.
*   `SnackBar`: To provide feedback to the user.

**Demo:**
https://github.com/user-attachments/assets/a90eb1b4-ccc2-4445-9328-19b129b267f7



---

### 2️⃣ Interactive Dismissible Lists

**Folder:** `lib/interactive_dismissible_lists/`

**Task:**
Create an interactive list using **Dismissible** widgets where users can swipe to remove items with animations and state management.

**Key Widgets & Concepts:**
*   `Dismissible`: To enable swipe-to-dismiss functionality on list items.
*   `ReorderableListView`: To allow users to reorder items in the list.
*   `Riverpod`: For simple and effective state management.
*   `SnackBar` with `SnackBarAction`: To provide an "Undo" option after dismissing an item.

**Demo:**
https://github.com/user-attachments/assets/1fc9ec0b-8341-4120-9566-47ced7852b71



---

### 3️⃣ Advanced Animation Chain

**Folder:** `lib/advanced_animation_chain/`

**Task:**
Create a loading animation sequence with **3 dots** that scale and fade in order using **AnimationController** and **Tweens**.

**Requirements:**
- ✅ Proper `AnimationController` with disposal
- ✅ Sequential animations for 3 dots
- ✅ Includes scale + opacity animations
- ✅ Loops continuously
- ✅ Smooth animation curves

**Key Widgets & Concepts:**
*   `AnimationController`: To manage the animation's lifecycle.
*   `Tween`: To define the range of values for the animation.
*   `CurvedAnimation` & `Interval`: To create staggered and overlapping animations.
*   `AnimatedBuilder`: To rebuild the widget tree when the animation value changes.
*   `Transform.scale` & `Opacity`: To apply the scale and fade animations.

**Demo:**
https://github.com/user-attachments/assets/5bc6617e-d643-4712-8beb-f722e490d6cc



---

## ⚙️ Run the Project

To run this project locally, follow these steps:

1.  **Clone the repository:**
    ```bash
    git clone https://github.com/mohamedrashad102/flutter-mentors-r3
    cd FlutterMentorsR3
    ```

2.  **Install dependencies:**
    ```bash
    flutter pub get
    ```

3.  **Run the app:**
    ```bash
    flutter run
    ```

---

⚡ Built with Flutter during a mentorship program.
