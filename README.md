# Technical Test for Samay

## Introduction

This technical test aims to demonstrate competence with technologies and best practices in Flutter app development, as well as the implementation of the required functionalities for Samay. The app is designed to be easily scalable and supports the addition of other languages. Currently, it only supports **English**, but to add more languages, it is only necessary to add the corresponding `language.json` file. The modular structure of the code allows functionalities to be implemented efficiently.

Migration to an API or integration with web services is simple, as the app is designed with an architecture that makes these changes easy to implement without affecting other areas of the project. Migration can be done by implementing the **repositories** in the **data** layer, without modifying the visual layer (UI).

## Exports

In the **exports** folder of the GitHub repository, two APKs are provided:

- **app-fake-release.apk**: Uses default data in the app.
- **app-prod-release.apk**: Uses data from the generated database.

You can download the APKs from the repository at the following URL:

[https://github.com/marlonc98/samay_test](https://github.com/marlonc98/samay_test)

## Technologies Used

- **Flutter**: The main framework for app development.

## Dependencies

- **get_it**: ^8.0.2  
  Used for dependency injection using the **Singleton** pattern, ensuring that classes are instantiated only once and reused throughout the app lifecycle.

- **shared_preferences**: ^2.3.3  
  Used to store brief user information, such as added devices and selected agencies.

- **either_dart**: ^1.0.0  
  Helps manage errors with an explicit and limited structure, avoiding excessive try-catch blocks.

- **infinite_scroll_pagination**: ^4.1.0  
  Used for implementing search with pagination in the property section.

- **http**: ^1.2.2  
  Included as a foundation for future web connections, as migration to an API is considered.

- **provider**: ^6.1.2  
  Used for state management. The app's architecture is designed with **Provider** for better widget readability and efficient state management.

- **flutter_blue_plus**: ^1.34.5  
  Enables Bluetooth device connection via BLE. This dependency is a more updated version of flutter_blue, using similar logic.

- **flutter_svg**: ^2.0.16  
  Used for rendering the logo in SVG format, ensuring image quality across different resolutions.

- **intl**: ^0.20.1  
  Handles date formatting, particularly for date fields.

- **image_picker**: ^1.1.2  
  Allows selecting images from the camera or gallery.

- **permission_handler**: ^11.3.1  
  Manages permissions for Bluetooth and other required services.

- **sqflite**: ^2.4.1  
  Local database for storing information, as there is no active web connection.

- **path**: ^1.9.0  
  Provides relative paths, such as for accessing the local database.

## Project Structure

The project is organized as follows:

### **assets/**
Contains all the images required for the app.

- **images/**: Folder with permanent images.
- **temp_images/**: Folder containing temporary images to show fake or simulated data.

### **lib/**
Main directory containing the Flutter app source code. It includes the following subfolders:

- **data/**:  
  - **db/**: Local database configuration. Includes basic functions like get, put, and perform queries.
  - **dto/**: Data Transfer Object (DTO) that converts data from the database into objects used internally.
  - **repositories/**: Implementations of the repositories defined in the domain layer.

- **di/**: Manages dependency injection using the **Singleton** pattern. Classes are instantiated only once and reused throughout the app lifecycle.

- **domain/**: Contains the core logic of the app.  
  - **Repositories**: Defines how actions should be handled and what should be received or delivered.
  - **Entities**: Represents the app's internal models.
  - **States**: Abstract classes that manage the global states of the app.
  - **Use Cases**: Connects the logic in specific functions.

- **presentation/**: Contains all the app's visual components.

- **utils/**: Utility files with general classes for date formatting, currencies, and common functions.

- **flavors/**: Configuration for the app's different environments.

## Environment Setup

### Prerequisites

- Flutter SDK installed (≥ v3.0.0).
- Android Studio or Visual Studio Code set up for Flutter development.
- Devices supporting BLE (Bluetooth Low Energy) if you want to test Bluetooth functionality.

### Installation

1. Clone the repository.

```bash
git clone https://github.com/marlonc98/samay_test
```

2. Install the dependencies.

```bash
flutter pub get
```

3. Run the app on an emulator or physical device with a specific flavor.

```bash
flutter run --flavor <flavor_name>
```

## Running the Project

### How to Run the Project?

To run the app with one of the configured **flavors**, use the following command:

```bash
flutter run --flavor <dev | prod | fake>
```

- **dev**: For development purposes.
- **prod**: For production purposes.
- **fake**: For using default or mock data.

Each flavor is configured to use different data and setup. For example, **dev** flavor is designed for development testing, **prod** is for actual production environments, and **fake** uses hardcoded/mock data to demonstrate the app’s interface and behavior.


## How to Add Functionality

To add new features, the project follows a modular, layered architecture. Here’s a brief process:

1. **Create Entities**: Define entities, such as a `User` entity for login.
2. **Create Use Cases**: Implement the logic for features, e.g., `Login`, `Logout`.
3. **Create Repositories**: Define a repository for the feature (e.g., `AuthenticationRepository`).
4. **Create Fake Repositories**: For testing, create fake repositories that return mock data.
5. **Update DI**: Inject the dependencies via the DI layer.
6. **Create UI**: Create interfaces to interact with the new functionality using the Use Cases.
7. **Test with Fake Data**: Ensure the feature works with fake data before integrating it with real data.

Once everything works with fake data, you can implement the real repositories and connect them to the database.

## Flow Explanation

The app follows a Clean Architecture approach. The flow of the app is as follows:

1. The **UI** calls a **Use Case**.
2. The **Use Case** interacts with **Repositories** and **States**.
3. The **Repositories** fetch data and pass it to the domain entities using DTOs.
4. The **State** is updated with the response.
5. The UI receives the updated state and displays the result.

For example, during login, the `LoginRepository` calls the database, retrieves the user information, maps it to a domain entity via the DTO, and updates the user state. The UI will then receive the user information and display it.

## Implemented Features

- **State Management**: Managed using `Provider` for reactive state handling.
- **Local Storage**: Uses `shared_preferences` for short-term data storage and `sqflite` for persistent storage.
- **Bluetooth Connection**: Bluetooth devices can be connected via BLE using `flutter_blue_plus`.
- **Pagination**: Property listing uses `infinite_scroll_pagination` for efficient data loading.
- **Image Selection**: Users can pick images using `image_picker`.
- **Permissions**: Managed using `permission_handler` for Bluetooth and other necessary services.

## Migration to Server

Migrating to a server is easy. You only need to modify the **data layer** (repositories) to fetch data from a server-side database instead of using the local database. The UI will not require any changes. This ensures a smooth transition from local to server-based data storage.

## Additional Features

- **Singleton Pattern**: Used for dependency injection to ensure single instances of classes, especially for the DI layer and database configuration.
- **Provider**: For state management, ensuring clear separation between the UI and business logic.
- **Agency Requirement**: When creating a project, you cannot proceed without selecting an agency first. This simulates a login process.
- **Navigation**: A bottom navigation bar is used to separate the real estate and Bluetooth functionalities, making the interface more intuitive.
- **Device Interaction**: For devices in Bluetooth range, you can send data via text and monitor the connection status in real-time. Only devices with specific names are allowed to connect.
- **Code For Bluetooth Classic**: On the bracnh classic you will find an older version of the code, with the domotic working but with the classic vs of bluetooth

## Final Considerations

- **Scalability**: The project is designed with modularity in mind, making it easy to add new features or modify existing ones.
- **Server Migration**: The data layer is designed to allow a smooth migration from local databases to server-side storage without affecting the UI.
- **Bluetooth Support**: The app is optimized for devices with BLE support, such as Arduino for serial communication.

## License

This project is shared as a technical test and cannot be used or distributed without my prior authorization. All rights reserved.

For any inquiries, you can contact me at:

- **Email**: [marlonmz1998@gmail.com](mailto:marlonmz1998@gmail.com)
- **Phone**: +57 3234686680

Marlon Alejandro Méndez Castañeda
