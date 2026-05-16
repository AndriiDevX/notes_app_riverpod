# Notes App 📝

A clean, fast, and responsive dynamic notes application built with **Flutter**. The project showcases modern state management, advanced routing, local data persistence, and beautiful UI/UX sorting capabilities based on the **Nordic Minimal** design aesthetic.

---

## 🚀 Features

* **Offline-First (Local Persistence):** Notes are securely stored on the device using **Hive**, meaning your data persists even after restarting the app.
* **Advanced State Management:** Complete Separation of Concerns (SoC) using **Riverpod** (`StateNotifierProvider`).
* **Dynamic Filtering:** Toggle view seamlessly between all notes, only favorites, or non-favorites via unified multi-state chips.
* **Real-time Live Search:** Instant results as you type inside the query bar using integrated reactive states.
* **Robust Routing:** Smooth screen transitions and safe argument passing via **GoRouter**.
* **Intuitive UX:** Dynamic action dialogs, swipe-free instant deletion with snackbar confirmations, and quick single-tap favorite toggling.

---

## 🛠️ Architecture & Tech Stack

This application emphasizes clean code practices and unidirectional data flow:

```
  [ UI Layer ]  <--->  [ Riverpod Providers ]  <--->  [ Data Layer (Hive NoSQL) ]
 (Screens/Chips)          (Reactive State)               (Local Storage Map)

```

* **Framework:** Flutter (Dart)
* **State Management:** Flutter Riverpod
* **Routing & Navigation:** GoRouter
* **Database:** Hive & Hive Flutter (Lightweight NoSQL key-value store)

---

## 📂 Project Structure

The project maintains a flat, feature-focused design for high readability:

* `main.dart` — Initializes hardware bindings, bootstraps the Hive local boxes, and injects the global Riverpod `ProviderScope`.
* `app_router.dart` — Centralized declarative routing paths and type-safe `extra` object routing variables.
* `note_model.dart` — Lightweight data blueprint featuring a custom immutable object data cloner (`copyWith`).
* `note_provider.dart` — State layer engine orchestrating the full CRUD lifecycle pipeline alongside JSON/Map serializations.
* `notes_screen.dart` — The main interface displaying live queries, compound multi-filter options, and rapid reactive data flows.
* `details_screen.dart` — Separate atomic viewing and editing layer handling synchronous data saves.

---

## 💾 Core Logic Highlights

### Map Serialization (Offline Storage)

Because the app saves complex structures without boilerplate generators, data is parsed directly into lightweight maps:

```dart
void saveNotes() {
  final notesJson = state.map((note) {
    return {
      'id': note.id,
      'title': note.title,
      'isFavorite': note.isFavorite,
    };
  }).toList();
  notesBox.put('notes', notesJson);
}

```

### Multi-State Compound Filtering

Real-time filtering handles search queries and preference filtering concurrently within the layout tree:

```dart
final filteredNotes = notes
    .where((note) => note.title.toLowerCase().contains(query.toLowerCase()))
    .where((note) =>
          (selectedFilter == Filter.all) ||
          (selectedFilter == Filter.onlyFavorites && note.isFavorite) ||
          (selectedFilter == Filter.onlyNotFavorites && !note.isFavorite),
    ).toList();

```

---

## ⚡ Getting Started

### Prerequisites

Make sure you have the Flutter SDK installed on your machine.

### Installation

1. **Clone the repository:**
```bash
git clone https://github.com/your-username/notes-app.git
cd notes-app

```


2. **Get dependencies:**
```bash
flutter pub get

```


3. **Run the application:**
```bash
flutter run

```



---

## 📈 Future Milestones

* [ ] Implement strict `TypeAdapters` for binary performance optimization.
* [ ] Add dark mode themes matching clean Nordic Minimal standards.
* [ ] Incorporate sorting options by creation date/time.

