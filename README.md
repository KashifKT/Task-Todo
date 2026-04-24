# 📝 Task Todo App 

A production-ready Task Todo application built with Flutter using MVC architecture. The project integrates Firebase services along with REST API (HTTP) integration and Firebase Cloud Messaging (FCM) for push notifications.

---

## 🚀 Features

- 🔐 Firebase Authentication (Login / Register / Logout)
- 📝 Create, Update, Delete Tasks
- ☁️ Cloud Firestore for real-time database
- 🔔 Push Notifications using Firebase Cloud Messaging (FCM)
- 🌐 REST API integration using HTTP package
- 🔄 Real-time sync between local and cloud data
- 🎨 Clean and responsive UI
- 🧠 MVC Architecture for scalable code structure

---

## 🏗️ Architecture (MVC)

```bash
lib/
│
├── models/        # Data models (Task, User, API models)
├── views/         # UI screens (Home, Login, etc.)
├── controllers/   # Business logic & state handling
├── services/      # Firebase + API services (Auth, Firestore, HTTP, FCM)
├── widgets/       # Reusable UI components
└── main.dart      # Entry point
```

---

## 🔥 Backend & Services

### Firebase
- Firebase Authentication
- Cloud Firestore
- Firebase Cloud Messaging (FCM)

### HTTP (REST API)
- Used for external API integration
- Handled via `http` package
- JSON parsing for models
- Error handling for network requests

---

## 📲 FCM (Push Notifications)

- Task update notifications
- Foreground & background message handling
- Device token management
- Topic-based messaging support

---

## 🌐 API Integration (HTTP)

- GET requests → Fetch external data
- POST requests → Send data to server
- PUT / DELETE → Update & remove data
- JSON serialization & deserialization
- Exception handling for network errors

---

## 🛠️ Tech Stack

- Flutter (Dart)
- MVC Architecture
- Firebase Auth
- Cloud Firestore
- Firebase Messaging (FCM)
- HTTP Package (REST API)

---

## 🚀 Getting Started

### 1. Clone Repository
```bash
git clone https://github.com/KashifKT/Task-Todo.git
```

### 2. Navigate Project
```bash
cd task-todo-mvc-firebase-http
```

### 3. Install Dependencies
```bash
flutter pub get
```

### 4. Firebase Setup
- Add `google-services.json` (Android)
- Add `GoogleService-Info.plist` (iOS)
- Enable Auth, Firestore, FCM in Firebase Console

### 5. Run Project
```bash
flutter run
```

---

## 📌 App Flow

1. User authenticates via Firebase  
2. Tasks are created and stored in Firestore  
3. HTTP APIs fetch external or supplementary data  
4. Controller manages all business logic  
5. UI updates in real-time  
6. FCM sends push notifications for task updates  

---

## 📷 Screenshots

<img width="866" height="1298" alt="img_1776960903213" src="https://github.com/user-attachments/assets/4f8d9e45-46e0-4d56-ab4a-22c6b286dd91" />
<img width="866" height="1298" alt="img_1776961035346" src="https://github.com/user-attachments/assets/6d9df4cf-4939-4bd9-b801-b0337577c33b" />
<img width="866" height="1298" alt="img_1776960969784" src="https://github.com/user-attachments/assets/6bfd61cc-e1c9-40c3-835b-a3359e19be0d" />


---

## 🚀 Future Improvements

- 📂 Task categories & filters  
- ⏰ Scheduled notifications  
- 🌙 Dark mode  
- 📊 Analytics dashboard  
- 👥 Multi-user collaboration  
- 🔐 Role-based access system  

---

## 🤝 Contributing

1. Fork the repository  
2. Create a feature branch  
3. Commit changes  
4. Push branch  
5. Open Pull Request  

---

## 📄 License

MIT License

---

## 👨‍💻 Developer

KashifKT
