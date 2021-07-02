# Friendly Chat
## Getting Started
This project was developed for android using flutter and firebase. It is an application that requires users to log in and be able to message other users that are registered.

### Resources used in guiding the development of this project:
- [FlutterFire Overview](https://firebase.flutter.dev/docs/overview/)
- [A Chat Application — Flutter & Firebase](https://medium.com/flutter-community/a-chat-application-flutter-firebase-1d2e87ace78f)
- [Building Chat App in Flutter with Firebase](https://medium.com/flutter-community/building-chat-app-in-flutter-with-firebase-888b6222fe20)

## Guidelines
Work through a Firebase chat application in the language of your choice!

## 

## Firebase & Cloud Firestore
#### About Firestore
- Cloud Firestore stores user's unique user id, first name, last name, user name, registration time, and user role.
- It also stores content of user's message, time of message sent, the user id of who the message is from, and another user id of who the message is to.
- Firebase Authentication should be able to accept email and password

#### For Login and Sign Up 
- When creating an account, use any email, if it doesn't go through then email is already taken. 
- For already created account, use email and password provided below to sign in
- Email: test@test.com 
- Password: 12qwaszx 

## Dependencies and Plugins
## Google and Firebase:
Make sure google-services.json file is downloaded and added to android/app folder
Inside 'build.gradle' file under the 'android/app' folder, add these implementations in the 'dependencies' section:

    //implementation "org.jetbrains.kotlin:kotlin-stdlib-jdk7:$kotlin_version"
    // Google Sign In SDK
    implementation 'com.google.android.gms:play-services-auth:19.0.0'
    
    // Firebase SDK
    implementation platform('com.google.firebase:firebase-bom:26.6.0')
    implementation 'com.google.firebase:firebase-database-ktx'
    implementation 'com.google.firebase:firebase-storage-ktx'
    implementation 'com.google.firebase:firebase-auth-ktx'

    // Firebase UI Library
    implementation 'com.firebaseui:firebase-ui-auth:7.2.0'
    implementation 'com.firebaseui:firebase-ui-database:7.2.0'
    
Inside the 'build.gradle' file under the 'android' folder, add these to the 'dependencies' section:

    classpath 'com.android.tools.build:gradle:4.1.2'
    classpath "org.jetbrains.kotlin:kotlin-gradle-plugin:$kotlin_version"
    classpath 'com.google.gms:google-services:4.3.8'
