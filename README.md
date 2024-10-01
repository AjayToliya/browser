
# Mirror Wall App

## Introduction

The **Mirror Wall App** is a versatile browser application designed to enhance your web browsing experience with intuitive navigation buttons, multiple search engine options, and essential connectivity features.

This documentation provides detailed information on the app's features and usage.



![Screenshot_20240716_104830](https://github.com/user-attachments/assets/b55edb2c-28f4-4614-8d2c-d8db6217ca08)
![Screenshot_20240716_104845](https://github.com/user-attachments/assets/64e886c4-fbf0-48ac-a711-d73a6bc36076)
![Screenshot_20240716_104835](https://github.com/user-attachments/assets/e4493d90-a507-4240-aff6-af0384cd0fa4)
![Screenshot_20240716_105549](https://github.com/user-attachments/assets/f4c9a45f-a8e4-4523-adb4-d351d85ead3d)
![Screenshot_20240716_105814](https://github.com/user-attachments/assets/f5df3d68-af86-4d93-af82-7f3ca2ff71a6)

## Features

### 1. Home Button
- **Functionality**: The Home button allows users to quickly return to the app's default home page.
- **Location**: Typically located in the top navigation bar.
- **Usage**: When clicked, the Home button navigates users back to the set default homepage.

### 2. Bookmark Button
- **Functionality**: Enables users to save their favorite web pages for easy access later.
- **Usage**: Clicking the Bookmark button saves the current page to the bookmarks list, which is stored using local storage.

### 3. Next Button
- **Functionality**: The Next button allows users to navigate forward through their browsing history.
- **Usage**: It becomes active when there is a forward page to navigate to.

### 4. Back Button
- **Functionality**: Lets users navigate backward through their browsing history.
- **Usage**: Useful for returning to previously visited pages.

### 5. Search Engine Option
- **Functionality**: Provides users with multiple search engine options for their web searches.
- **Available Search Engines**: 
  - Google (Default)
  - Bing
  - DuckDuckGo
  - Yahoo
- **Usage**: Users can select their preferred search engine from the `PopupMenu`.

## Directory Structure

```
lib
├── model
│   └── data.dart
├── provider
│   ├── Connection_provider.dart
│   ├── bookmark.dart
│   └── browser.dart
├── view
│   └── homepage
│       └── android
│           ├── bookmarklist.dart
│           ├── homepage.dart
│           └── openmark.dart
└── main.dart
      
```           

## Installation

1. Clone the repository:
   ```bash
   git clone https://github.com/yourusername/mirror_wall_app.git
   ```
2. Navigate to the project directory:
   ```bash
   cd mirror_wall_app
   ```
3. Install the necessary dependencies:
   ```bash
   flutter pub get
   ```
4. Run the app:
   ```bash
   flutter run
   ```

## Requirements
- Flutter SDK
- WebView plugin (`webview_flutter`)
- Local storage for bookmarks (`shared_preferences`)

## Usage

1. **Home Button**: Tap the Home button to return to the home page.
2. **Bookmarks**: Save your favorite pages by tapping the Bookmark button.
3. **Navigation**: Use the Back and Next buttons to navigate through your browsing history.
4. **Search Engine**: Choose your preferred search engine from the PopupMenu.

## Contributing

1. Fork the repository.
2. Create a new feature branch:
   ```bash
   git checkout -b feature-branch-name
   ```
3. Commit your changes:
   ```bash
   git commit -m "Add some feature"
   ```
4. Push to the branch:
   ```bash
   git push origin feature-branch-name
  

