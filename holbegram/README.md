# Holbegram

A social network mobile application built with Flutter, Firebase, and Cloudinary.

Flutter final project - Holberton School  
Project author: Youssef Belhadj  
Level: Novice  
Coefficient: 7

---

## Table of Contents

- [Holbegram](#holbegram)
  - [Table of Contents](#table-of-contents)
  - [About](#about)
  - [Features](#features)
  - [Tech Stack](#tech-stack)
  - [Project Structure](#project-structure)
  - [Prerequisites](#prerequisites)
  - [Local Installation](#local-installation)
  - [Firebase Setup](#firebase-setup)
    - [1) Create the Firebase project](#1-create-the-firebase-project)
    - [2) Enable Authentication](#2-enable-authentication)
    - [3) Create Firestore Database](#3-create-firestore-database)
    - [4) Add Android](#4-add-android)
    - [5) Add iOS (if needed)](#5-add-ios-if-needed)
  - [Cloudinary Setup](#cloudinary-setup)
  - [Run the Application](#run-the-application)
  - [Troubleshooting](#troubleshooting)
    - [Firebase not initialized error](#firebase-not-initialized-error)
    - [Android build fails](#android-build-fails)
    - [Dependency issues](#dependency-issues)
  - [Manual QA review](#manual-qa-review)
  - [Useful Resources](#useful-resources)
  - [Author](#author)

---

## About

Holbegram is an Instagram-inspired mobile application developed with Flutter.
The goal is to build a complete app with:

- user authentication
- data management with Firestore
- image upload
- shared content display

The main backend relies on Firebase (Auth + Firestore), while media files are stored on Cloudinary.

---

## Features

- Account creation (email / password)
- User login
- Image upload
- Post publishing
- Navigation between main screens

Features currently present in this repository (current base):

- Login screen
- Signup screen
- Upload image screen
- Reusable text field component

---

## Tech Stack

- Flutter
- Dart
- Firebase Authentication
- Cloud Firestore
- Cloudinary (image storage)

Flutter packages typically used for this project:

- firebase_core
- firebase_auth
- cloud_firestore
- image_picker
- provider
- uuid
- cached_network_image
- flutter_staggered_grid_view
- pull_to_refresh
- bottom_navy_bar

---

## Project Structure

```txt
holbegram/
|-- README.md
|-- lib/
|   |-- main.dart
|   |-- screens/
|       |-- login_screen.dart
|       |-- signup_screen.dart
|       |-- upload_image_screen.dart
|-- widgets/
|   |-- text_field.dart
```

---

## Prerequisites

Before starting, make sure you have:

- Flutter SDK installed
- Dart installed (via Flutter)
- Android Studio or VS Code
- Android/iOS emulator or physical device
- Firebase account
- Cloudinary account

Useful commands:

```bash
flutter --version
dart --version
```

---

## Local Installation

1. Clone the repository:

```bash
git clone https://github.com/harishammache/holbertonschool-holbegram.git
cd holbegram
```

2. Install dependencies:

```bash
flutter pub get
```

3. Check Flutter tools:

```bash
flutter doctor
```

---

## Firebase Setup

### 1) Create the Firebase project

- Go to https://firebase.google.com/
- Create a new project named `holbegram`
- Disable Google Analytics (optional according to instructions)

### 2) Enable Authentication

- Firebase Console -> Authentication -> Sign-in method
- Enable `Email/Password`

### 3) Create Firestore Database

- Firestore Database -> Create database
- Choose `Start in test mode`
- Choose the nearest region
- Publish

### 4) Add Android

- Add an Android app in Firebase
- Package name: `com.example.holbegram` (or your actual package)
- Download `google-services.json`
- Place the file in `android/app/`

Then verify Gradle files:

- `android/build.gradle`: presence of `google()` and Google services classpath
- `android/app/build.gradle`: Google services plugin + Firebase BoM

Expected example:

```gradle
plugins {
	id 'com.android.application'
	id 'com.google.gms.google-services'
}

dependencies {
	implementation platform('com.google.firebase:firebase-bom:33.5.1')
}
```

### 5) Add iOS (if needed)

- Add an iOS app in Firebase
- Bundle ID identical to the one configured in Xcode
- Download `GoogleService-Info.plist`
- Add this file to `ios/Runner/` through Xcode

---

## Cloudinary Setup

1. Create a Cloudinary account
2. Retrieve:

- Cloud name
- API key
- API secret

3. Configure these values in your project (environment variables or secure config)

Important:

- Never commit secret keys
- Add sensitive files to `.gitignore`

---

## Run the Application

Start app:

```bash
flutter run
```

Build debug APK:

```bash
flutter build apk --debug
```

Build release APK:

```bash
flutter build apk --release
```

---

## Troubleshooting

### Firebase not initialized error

- Check `Firebase.initializeApp()` call in `main.dart`
- Check Firebase config files are present

### Android build fails

- Check Gradle / Android plugin versions
- Check `minSdkVersion`
- Run:

```bash
flutter clean
flutter pub get
flutter run
```

### Dependency issues

```bash
flutter pub upgrade
```

---

## Manual QA review

When the project is finished:

1. Verify the full flow:
   - signup
   - login
   - upload image
   - data display
2. Verify network errors are handled (app should not crash)
3. Verify form validations
4. Request `Manual QA review` according to Holberton instructions

---

## Useful Resources

- Dart Cheatsheet
- FlutterFire Overview
- Getting started with Firebase on Flutter
- Firebase Auth for Flutter
- Cloud Storage on Flutter
- Image Picker plugin
- Provider package
- Uuid package
- Cached network image
- Flutter staggered grid view
- Flutter pull to refresh

---

## Author

Project completed as part of the Holberton School curriculum by Haris Hammache
