# fluttertp1

# Waiting Room App – State Management Basics + TDD

A Flutter application developed using Test-Driven Development (TDD) that demonstrates state management basics, interactive queue management, and UI reactivity in Flutter.

---

## Overview

The **Waiting Room App** brings together concepts from **Workshop 1** (UI widgets, greeting card, real-time clock) and **Workshop 2** (State Management with TDD, interactive queue list):

- **Interactive Queue View (Workshop 2)**: Add clients by typing a name and tapping **Add**, view the real-time queue counter (`Clients in Queue: X`), and remove clients with the delete button (`Icons.delete`).
- **Greeting Card View (Workshop 1)**: Centered interactive card displaying a greeting and name (`Najjar Iheb`), tappable background color change, and a live 1-second auto-refreshing clock.
- **Dynamic View Switcher**: An AppBar action button that allows toggling seamlessly between the **Queue View** and **Card View** in localhost / web or mobile.

---

## Architecture & Code Documentation

### 1. Business Logic: `WaitingRoomManager`
**File:** `lib/waiting_room_manager.dart`

Responsible for managing the state of the client queue independently of the UI.

- **`List<String> get clients`**
  - Read-only getter that exposes the internal list of client names.
- **`void addClient(String name)`**
  - Appends a new client name to the queue.
- **`void removeClient(String name)`**
  - Removes the specified client from the queue.

---

### 2. User Interface: `WaitingRoomApp` & `WaitingRoomScreen`
**File:** `lib/main.dart`

Connects the business logic to Flutter's reactive widget tree and hosts the interactive switch.

- **`void main()`**
  - Application entry point; initializes and runs `WaitingRoomApp`.
- **`WaitingRoomApp` (`StatelessWidget`)**
  - Root widget configuring `MaterialApp` and loading `WaitingRoomScreen`.
- **`WaitingRoomScreen` (`StatefulWidget`)**
  - Stateful screen hosting both the Queue View and Card View.
- **`_WaitingRoomScreenState` (`State<WaitingRoomScreen>`)**
  - Manages the local UI state:
    - `_manager`: Instance of `WaitingRoomManager` maintaining queue data.
    - `_controller`: `TextEditingController` controlling input in the client name text field.
    - `_showCardView`: Boolean flag indicating whether the Card View (`true`) or Queue View (`false`) is visible.
    - **`_addClient()`**: Validates input text, adds the client via `_manager.addClient()`, clears the text field, and calls `setState()` to trigger a UI rebuild.
    - **`dispose()`**: Disposes `_controller` to release resources and prevent memory leaks.
    - **`build(BuildContext context)`**:
      - `AppBar`: Displays dynamic title (`'Local Waiting Room'` or `'Waiting Room Card'`) and a toggle `TextButton.icon` in `actions` to switch between views.
      - `body`: Conditionally renders either `WaitingRoomCard` or the Queue layout (`Row` with `TextField` + `ElevatedButton`, queue counter `Text`, and `ListView.builder` of cards with delete buttons).

---

### 3. Auxiliary Components (from Workshop 1)
- **`WaitingRoomCard` (`lib/waiting_room_card.dart`)**:
  - `build()`: Displays a card with a greeting and client name.
  - `onTap`: Toggles the background highlight color between default and light blue using `setState()`.
- **`WaitingRoomTimestamp` (`lib/waiting_room_timestamp.dart`)**:
  - `initState()`: Starts a 1-second recurring `Timer` to refresh the clock.
  - `dispose()`: Cancels the timer when the widget is disposed.
  - `build()`: Renders the formatted real-time timestamp.

---

## Testing & TDD Suite

The project includes unit and widget tests covering all functionality:

### 1. Unit Tests: `WaitingRoomManager`
**File:** `test/waiting_room_manager_test.dart`

- **`'should add a client to the waiting list'`**:
  - Verifies that `addClient()` increases queue length and correctly stores the client.
- **`'should remove a client from the waiting list'`**:
  - Verifies that `removeClient()` properly deletes a client from the list.

### 2. Widget Tests: UI & Interactions
**File:** `test/waiting_room_widget_test.dart`

- **`'should add a new client to the list on button tap'`**:
  - Simulates user entering a name in `TextField`, clicking `Add`, and asserts the client card and updated counter appear.
- **`'should remove a client from the list when the delete button is tapped'`**:
  - Simulates adding a client, tapping the delete icon, and asserts the client is removed and counter drops to 0.
- **`'should toggle between Queue View and Card View on button tap'`**:
  - Tests tapping the AppBar switch button, verifying the view toggles between the Queue list and the Workshop 1 Card.

### 3. Card Widget Tests
**File:** `test/waiting_room_card_test.dart`

- Verifies that `WaitingRoomCard` displays name greeting and toggles background color when tapped.

---

## How to Run

### Install Dependencies
```sh
flutter pub get
```

### Run on Localhost / Web
```sh
flutter run -d chrome
```

### Run on Any Connected Device / Emulator
```sh
flutter run
```

### Run All Tests
```sh
flutter test
```

### Run Code Analyzer
```sh
flutter analyze
```
