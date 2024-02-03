# ChatApp
ChatApp is a modern and efficient messaging application designed with the Model-View-ViewModel (MVVM) architectural pattern and powered by Google's Firestore database. It aims to provide a seamless and intuitive user experience with robust messaging features.

## Features
 • Messaging: Send and receive text messages, images, and videos.
 • Group Chats: Create and manage groups to stay connected with multiple users.
 • Location Sharing: Share your location with friends and family.
 • Profile Customization: Personalize your profile with a custom avatar and status.
 • Push Notifications: Receive real-time updates on messages and notifications.
 • Responsive UI: Clean and responsive user interface for quick and easy navigation.

## Architecture
ChatApp is built using the MVVM architectural pattern, which separates the application into three main components:

1. Model: Interacts with the Firestore database to provide the necessary data.
2. ViewModel: Contains the business logic of the app, manipulating data received from the Model and exposing it to the View.
3. View: Displays the UI to the user, offering a seamless and intuitive experience.

### Model
The data layer responsible for interacting with the Firestore database. It handles all CRUD operations and provides data to the ViewModel.

### ViewModel
Contains the business logic of the application. It manipulates data received from the Model and prepares it for the View. The ViewModel also handles user interactions and updates the Model accordingly.

### View
Responsible for displaying the UI. It observes data from the ViewModel and updates the UI components in response to data changes, providing users with an interactive and responsive experience.

## Usage
 • Sign up or log in to start using ChatApp.
 • Create new chats or join existing groups.
 • Send and receive messages, share media, and customize your profile.

## Contributing
We welcome contributions from the community! To contribute to ChatApp, please follow these steps:

1. Fork the repository.
2. Create a new branch (git checkout -b feature/your-feature).
3. Make your changes.
4. Commit your changes (git commit -m 'Add some feature').
5. Push to the branch (git push origin feature/your-feature).
6. Open a pull request.

## Acknowledgements
Thanks to the Firebase team for their excellent Firestore database.
Inspired by modern messaging apps for feature ideas and UI design.
