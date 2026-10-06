# Waiting Room App — Workshop 3: Provider & Scalable State Management with TDD

A Flutter application developed using **Test-Driven Development (TDD)** demonstrating structured and scalable state management with the **Provider** package (`provider: ^6.0.0`).

---

## 📌 Overview

This project refactors the local state (`setState()`) implementation into a decoupled, maintainable architecture powered by `ChangeNotifier` and `ChangeNotifierProvider`.

### Why Provider?
- **Eliminates Prop-Drilling:** State is provided at the root and accessed directly anywhere in the widget hierarchy.
- **Prevents Unnecessary Rebuilds:** Widgets reactively rebuild only when relevant data changes instead of rebuilding the entire tree.
- **Clean Separation of Concerns:** Business logic lives entirely inside `QueueProvider`, independent of Flutter UI widgets.

---

## ✨ Features

- **Add Clients:** Type a name into the input field and tap **Add** to place a client at the end of the queue.
- **Live Queue Counter:** Displays real-time waiting count (`Clients in Queue: X`).
- **Client List:** Displays waiting clients in an organized card list with individual delete buttons (`Icons.delete`).
- **Serve Next Client (FIFO):** An AppBar action button (`Icons.skip_next`) that automatically serves and removes the client at the front of the line (index `0`).

---

## 🏗️ Architecture

```
lib/
├── main.dart             # Root app, ChangeNotifierProvider, & WaitingRoomScreen (StatelessWidget)
└── queue_provider.dart    # Central business logic extending ChangeNotifier
test/
├── waiting_room_manager_test.dart # Unit tests for QueueProvider logic
└── waiting_room_widget_test.dart  # Widget tests for reactive UI behavior
```

### 1. `QueueProvider` (`lib/queue_provider.dart`)
Extends `ChangeNotifier` to manage queue state:
- `List<String> get clients`: Exposes unmodifiable access to the queue.
- `void addClient(String name)`: Appends client and calls `notifyListeners()`.
- `void removeClient(String name)`: Removes a specific client and calls `notifyListeners()`.
- `void nextClient()`: Implements FIFO queue consumption by removing the first client (`removeAt(0)`) and calling `notifyListeners()`.

### 2. `WaitingRoomScreen` (`lib/main.dart`)
A clean `StatelessWidget`:
- Injected at the root via `ChangeNotifierProvider`.
- Uses `context.watch<QueueProvider>()` to subscribe to state changes.
- Uses `context.read<QueueProvider>()` to trigger methods without unnecessary re-renders.

---

## 🧪 Test-Driven Development (TDD)

All features were implemented using the **Red-Green-Refactor** TDD cycle:

### 1. Unit Tests (`test/waiting_room_manager_test.dart`)
- `should add a client to the waiting list`
- `should remove a client from the waiting list`
- `should remove the first client when nextClient() is called`

### 2. Widget Tests (`test/waiting_room_widget_test.dart`)
- `should add a new client to the list on button tap`
- `should remove a client from the list when the delete button is tapped`
- `should remove the first client from the list when "Next Client" is tapped`

---

## 🚀 Getting Started

### 1. Install Dependencies
```bash
flutter pub get
```

### 2. Run Tests
```bash
flutter test
```

### 3. Run the Application
```bash
# On Web (Chrome or Edge)
flutter run -d chrome
# or
flutter run -d edge

# On Windows desktop
flutter run -d windows
```
