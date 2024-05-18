# Google Docs Clone

Welcome to **Google Docs Clone**! This project is a real-time collaborative document editing application, inspired by Google Docs. Built with Flutter for the frontend and Node.js with Express.js for the backend, it uses MongoDB as the database and integrates Google authentication for user management.

## Features

- **Real-time Collaboration**: Edit documents in real-time with multiple users.
- **User Authentication**: Secure login using Google Authentication.
- **Document Management**: Create, edit, and delete documents.
- **Shareable Links**: Generate and share document links for collaboration.
- **Rich Text Editing**: Supports various text formatting options.
- **Responsive Design**: Optimized for both web and mobile platforms.

## Screenshots

<div style="display: flex; overflow-x: auto; padding: 10px; gap: 50px;">
  <img src="https://github.com/Ketan-Verma21/Google-Docs-Clone/assets/106913278/e849abdc-5b8a-4c5c-ae0a-9a9cb6f22fca" alt="Google Sign in" width="450" />
  <img src="https://github.com/Ketan-Verma21/Google-Docs-Clone/assets/106913278/cccad5d3-cc91-4299-8494-2ecbd3e9dfb7" alt="Auth Page" width="450" />
  <img src="https://github.com/Ketan-Verma21/Google-Docs-Clone/assets/106913278/1bde28b8-5e44-4812-92f8-24629a0b58dd" alt="Home Page" width="450" />
  <img src="https://github.com/Ketan-Verma21/Google-Docs-Clone/assets/106913278/eb24965e-c51e-4b8c-bd55-39712570e92a" alt="Document Page" width="450" />
  <img src="https://github.com/Ketan-Verma21/Google-Docs-Clone/assets/106913278/f4984ca3-3059-4468-80af-d4b6de00f62e" alt="Document edited" width="450" />
  <img src="https://github.com/Ketan-Verma21/Google-Docs-Clone/assets/106913278/45e8f1dd-c252-4b73-9460-61815bbc7e66" alt="Document link copied" width="450" />
</div>

## Getting Started

To get a copy of the project up and running on your local machine, follow these simple steps.

### Prerequisites

- [Flutter](https://flutter.dev/docs/get-started/install) SDK
- [Node.js](https://nodejs.org/en/download/) and [npm](https://www.npmjs.com/get-npm)
- [MongoDB](https://www.mongodb.com/try/download/community) (or a MongoDB Atlas account)
- [Google Cloud Platform](https://console.cloud.google.com/) account for Google Authentication

### Installation

1. **Clone the repository:**
   ```bash
   git clone https://github.com/Ketan-Verma21/Google-Docs-Clone.git
   cd Google-Docs-Clone
   ```

2. **Set up the backend:**
   - Navigate to the `server` directory:
     ```bash
     cd server
     ```
   - Install the required dependencies:
     ```bash
     npm install
     ```
   - Create a `.env` file in the `server` directory and add your MongoDB URI and Google OAuth credentials:
     ```
     MONGO_URI=your_mongo_uri
     GOOGLE_CLIENT_ID=your_google_client_id
     GOOGLE_CLIENT_SECRET=your_google_client_secret
     ```
   - Start the server:
     ```bash
     npm start
     ```

3. **Set up the frontend:**
   - Navigate to the `client` directory:
     ```bash
     cd client
     ```
   - Install the required dependencies:
     ```bash
     flutter pub get
     ```
   - Ensure you have your Firebase project set up for Flutter and download the `google-services.json` file. Place it in the `client/android/app` directory.
   - Run the app:
     ```bash
     flutter run
     ```

## Folder Structure

```
google-docs-clone/
|- client
|  |- android
|  |- build
|  |- ios
|  |- lib
|  |  |- components
|  |  |- models
|  |  |- pages
|  |  |- services
|  |  |- theme
|  |  |- main.dart
|  |- test
|  |- pubspec.yaml
|- server
|  |- controllers
|  |- models
|  |- routes
|  |- index.js
|  |- package.json
|  |- .env
```

- **client**: Contains the Flutter frontend code.
  - **components**: Reusable UI components.
  - **models**: Data models.
  - **pages**: Screens and pages of the application.
  - **services**: Services like authentication and database interactions.
  - **theme**: Theme-related files for styling the app.
  - **main.dart**: The entry point of the Flutter application.
- **server**: Contains the Node.js backend code.
  - **controllers**: Functions to handle API requests.
  - **models**: Mongoose models for MongoDB.
  - **routes**: API endpoints.
  - **index.js**: The entry point of the Node.js application.

## Contributing

We welcome contributions to enhance the Google Docs Clone! To contribute:

1. Fork the repository.
2. Create a new branch (`git checkout -b feature/your-feature-name`).
3. Commit your changes (`git commit -am 'Add some feature'`).
4. Push to the branch (`git push origin feature/your-feature-name`).
5. Create a new Pull Request.

## Contact

If you have any questions or feedback, feel free to reach out:

- **Name**: Ketan Verma
- **Email**: try.vrmketan@gmail.com
- **GitHub**: [Ketan-Verma21](https://github.com/Ketan-Verma21)
