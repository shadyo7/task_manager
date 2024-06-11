Task Manager

Task Manager is a Flutter application designed for managing tasks efficiently. This project is part of a job assignment and showcases my skills in Flutter development.

# Getting Started

Prerequisites:
Before you begin, ensure you have the following installed on your system:

Flutter SDK
Dart SDK (Comes with Flutter installation)
An IDE such as Android Studio or Visual Studio Code

# Installation

Follow these steps to set up the project on your local machine:

1: Clone the repository:

   - git clone https://github.com/shadyo7/task_manager.git
   - cd task_manager

2: Install dependencies:

   - flutter pub get

3: Run the app:

   - flutter run


# Project Structure:
The project follows a simple structure to keep the code organized and maintainable

lib/
├── main.dart           # Entry point of the application
│        
├── screens/            # Contains all the screens
│    ├── task_screen.dart
│    ├── add_task.dart
│    ├── edit_task.dart
│    ├── splash_screen.dart
│    └── login_screen.dart
├── models/             # Contains data models
│    └── task_model.dart
├── Provider/           # Contains business logic and state management
│    ├── auth_provider.dart
│    └── task_provider.dart
├── services/           # Contains services like API calls
│    ├──auth_services.dart
│    ├──task_services.dart
│    └──local_storage_services.dart
├── utilities/          # Contains constant like text styles
│    └──constants.dart
└── widgets/            # Contains reusable widgets
     └── custom_widgets.dart


# Features
Authentication: Login and Logout
Task Management: Add, edit, and delete tasks.
Local Persistence: Tasks are saved locally on the device using Shared Preferences.
Custom UI Components: Includes custom widgets for a consistent and user-friendly interface.
State Management: Uses Provider for efficient state management.


Dependencies
The project uses the following packages:
# provider: ^6.1.2
# http: ^1.2.1
# shared_preferences: ^2.2.3

Contact
For any questions or feedback, feel free to reach out:

Email: ishahid116@gmail.com
GitHub: shadyo7
