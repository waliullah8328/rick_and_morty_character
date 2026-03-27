📱 Rick & Morty Character App (Flutter)

A Flutter application that displays characters from the Rick & Morty API with local editing and reset functionality using Riverpod for state management and Hive for offline storage.

🚀 Setup Instructions

1. Clone the Repository
git clone  https://github.com/your-username/rick-and-morty-app.git
cd rick-and-morty-app

3. Install Dependenciesm : 
flutter pub get

4. Generate Hive Adapters: 
flutter pub run build_runner build --delete-conflicting-outputs

5. Run the App: 
flutter run

🧠 State Management Choice

This project uses Riverpod for state management.

Why Riverpod?

✅ Compile-time safety
✅ No dependency on BuildContext
✅ Better testability
✅ Scalable architecture for large apps
✅ Supports both synchronous and asynchronous state

Riverpod helps keep business logic separate from UI and avoids common issues like context misuse or unwanted rebuilds.

💾 Storage Approach

This app uses Hive for local storage.

Why Hive?

✅ Lightweight and extremely fast
✅ Works offline
✅ No SQL queries needed
✅ Type-safe with adapters
✅ Perfect for caching API data

How It Works
API data is fetched and stored locally in Hive.
Each character (Result) is stored as a Hive object.
The original API response is saved in originalJson.

When a user edits a character:
Changes are stored locally
isEdited flag is set to true

When resetting:
The app restores original data from originalJson

Benefits

🔄 Easy reset to original API data
📦 Persistent offline storage
⚡ High performance read/write
📴 Works without internet

✨ Features

📋 Fetch and display characters
🔍 View character details
✏️ Edit character locally
🔄 Reset to original data
💾 Offline caching with Hive
⚡ Reactive UI using Riverpod

📦 Dependencies

flutter_riverpod,
Hive,
Dio,
google_fonts
cached_network_image,
go_router,
intl,
hive_flutter,
build_runner

✨ Youtube video (demostation) Link: 
https://www.youtube.com/watch?v=t0QeDoVf_jw
