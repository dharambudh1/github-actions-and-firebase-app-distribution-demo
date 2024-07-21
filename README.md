# GitHub Actions and Firebase App Distribution for Flutter App

## Overview

This repository demonstrates how to integrate GitHub Actions with Firebase App Distribution specifically for a Flutter application. The GitHub Actions workflow automates the process of building and distributing your Flutter app using Firebase.

## Workflow

The GitHub Actions workflow performs the following tasks:

1. **Checks out the repository**.
2. **Sets up Flutter**.
3. **Checks Flutter version**.
4. **Installs dependencies**.
5. **Runs tests**.
6. **Builds APK and App Bundle**.
7. **Archives the build artifacts**.
8. **Installs Firebase CLI**.
9. **Uploads the APK to Firebase App Distribution**.

## Configuration

### Prerequisites

1. **Firebase CLI**: Ensure that you have the Firebase CLI installed on your local machine to obtain a Firebase Auth Token.
   
   - Install Firebase CLI:
     ```bash
     npm install -g firebase-tools
     ```

   - Obtain a Firebase Auth Token for CI:
     ```bash
     firebase login:ci
     ```
     - Follow the URL provided to sign in and copy the generated token.

2. **GitHub Repository Secrets**: Store the following secrets in your GitHub repository:
   - `APP_ID`: Your Firebase App ID.
   - `FIREBASE_TOKEN`: The Firebase Auth Token obtained from the CLI.

### GitHub Actions Workflow

Below is the GitHub Actions workflow configuration for building and distributing your Flutter app:

```yaml
name: GitHub Actions and Firebase App Distribution for Flutter App

on:
  push:
    branches:
      - main
      - development

  pull_request:
    branches:
      - main
      - development

jobs:
  build:
    runs-on: ubuntu-latest

    steps:
      - name: Checkout Repository
        uses: actions/checkout@v4

      - name: Set up Flutter
        uses: subosito/flutter-action@v2
        with:
          channel: stable
          flutter-version-file: pubspec.yaml

      - name: Flutter Version Check
        run: flutter --version

      - name: Get Dependencies
        run: flutter pub get

      - name: Run Tests
        run: flutter test

      - name: Build APK
        run: flutter build apk

      - name: Build App Bundle
        run: flutter build appbundle

      - name: Archive APK and App Bundle
        uses: actions/upload-artifact@v4
        with:
          name: flutter-build-artifacts
          path: |
            build/app/outputs/flutter-apk/app-release.apk
            build/app/outputs/bundle/release/app-release.aab

      - name: Install Firebase CLI
        run: npm install -g firebase-tools
      
      - name: Upload artifact to Firebase App Distribution
        run: |
          firebase appdistribution:distribute build/app/outputs/flutter-apk/app-release.apk \
            --app ${{ secrets.APP_ID }} \
            --token ${{ secrets.FIREBASE_TOKEN }} \
            --release-notes "Improvements in bug fixes, user interface and experience, performance, and stability."
```

## Explanation

- **Checkout Repository**: Checks out the code from the repository.
- **Set up Flutter**: Installs the Flutter SDK based on the version specified in `pubspec.yaml`.
- **Flutter Version Check**: Displays the Flutter version to verify the setup.
- **Get Dependencies**: Installs Flutter dependencies.
- **Run Tests**: Executes Flutter tests to ensure code quality.
- **Build APK**: Builds the release APK.
- **Build App Bundle**: Builds the release App Bundle.
- **Archive APK and App Bundle**: Archives the build artifacts for further use or storage.
- **Install Firebase CLI**: Installs Firebase CLI globally.
- **Upload artifact to Firebase App Distribution**: Distributes the APK to Firebase App Distribution using the specified app ID and token.

## Additional Resources

- [GitHub Actions Documentation](https://docs.github.com/en/actions)
- [Firebase App Distribution Documentation](https://firebase.google.com/docs/app-distribution)
- [Flutter Documentation](https://flutter.dev/docs)

Feel free to modify the workflow to suit your specific needs.

## Preview
![alt text](https://i.ibb.co/VmDfsmM/Screenshot-from-2024-07-21-15-22-07.png "img")
