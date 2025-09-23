### Question 6: What's the difference between Expanded and Flexible widgets? Provide a use case for each.  
**Answer:**  
- **Expanded**:  
  - Forces the child to take up *all* the remaining available space in the main axis (inside a `Row` or `Column`).  
  - The child widget will stretch to fill the space.  
  - **Use case**: In a `Row` with a `Text` on the left and a `Button` on the right, wrap the `Text` in `Expanded` so it fills the available space between them.  

- **Flexible**:  
  - Gives the child flexibility: it first tries to keep its natural size, then expands only if there’s extra space.  
  - Does not force the child to fill all the space.  
  - **Use case**: In a `Column` with a `Text` and an `Image`, wrap the `Image` in `Flexible` so it only expands if there’s free space, otherwise it keeps its natural size.  

---

### Question 7: When would you use RepaintBoundary and why is it important for performance?  
**Answer:**  
- **RepaintBoundary** is a widget that creates a separate "painting layer." This means that when something inside it changes, only that part is repainted instead of the entire screen.  
- **Use case**: When you have a widget that updates frequently (like an animation, a chart, or a `ListView` with many items), wrapping it in a `RepaintBoundary` prevents unnecessary redraws of other widgets.  
- **Importance for performance**:  
  - Reduces unnecessary repaints.  
  - Keeps the UI smooth and responsive (better FPS).  
  - Saves CPU/GPU work, especially for complex widgets.  

---

### Question 8: Explain the difference between AnimatedContainer and AnimatedBuilder. When would you choose one over the other?  
**Answer:**  
- **AnimatedContainer**:  
  - A widget that implicitly animates changes in its properties (like width, height, color, border radius, padding, etc.).  
  - You just change the property, and Flutter automatically animates the transition.  
  - **Use case**: Simple UI animations like smoothly changing the size of a button when tapped.  

- **AnimatedBuilder**:  
  - A widget that gives you full control over building animations. It listens to an `AnimationController` and rebuilds its child tree whenever the animation’s value changes.  
  - More flexible and powerful than `AnimatedContainer`.  
  - **Use case**: Complex, custom animations (e.g., animating multiple properties, orchestrating staggered animations, or working with custom painters).  

👉 **Rule of thumb**: Use `AnimatedContainer` for **simple property animations**. Use `AnimatedBuilder` for **complex or custom animations**.  

---

### Question 9: What is the purpose of GlobalKey and when should you avoid using it?  
**Answer:**  
- **Purpose**:  
  - A `GlobalKey` is used to uniquely identify a widget across the widget tree and access its state, context, or size.  
  - Examples:  
    - Accessing a form’s state (`GlobalKey<FormState>`) to validate/submit.  
    - Finding the position/size of a widget.  
    - Preserving state across widget rebuilds.  

- **When to avoid**:  
  - Overusing `GlobalKey` can hurt performance because Flutter has to do more work to maintain the identity of widgets.  
  - Avoid it for general state sharing — instead, use **state management solutions** (Provider, Riverpod, Cubit, etc.).  
  - Use it **only when you really need direct access** to a widget’s state.  

---

### Question 10: Describe the widget lifecycle methods and when each is called.  
**Answer:** (For **StatefulWidget**)  

1. **`createState()`**  
   - Called once when the StatefulWidget is inserted into the widget tree.  
   - Creates the `State` object.  

2. **`initState()`**  
   - Called once when the `State` object is first created.  
   - Best place to initialize controllers, listeners, or start async work.  

3. **`didChangeDependencies()`**  
   - Called right after `initState()`, and whenever dependencies change (like if `InheritedWidget` data changes).  
   - Good for cases where the widget depends on inherited data.  

4. **`build()`**  
   - Called every time the widget needs to be drawn.  
   - Should be a pure function of the widget’s state.  

5. **`didUpdateWidget(oldWidget)`**  
   - Called when the parent rebuilds and passes a new widget configuration to the same `State`.  
   - Useful to compare the old vs new widget and react accordingly.  

6. **`setState()`**  
   - Not a lifecycle method itself, but it triggers a rebuild by calling `build()`.  

7. **`deactivate()`**  
   - Called when the widget is removed from the tree temporarily.  

8. **`dispose()`**  
   - Called when the widget is permanently removed.  
   - Best place to clean up resources (dispose controllers, cancel timers, remove listeners).  
