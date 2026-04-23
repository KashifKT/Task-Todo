# 📝 Task Todo App (Flutter + MVC + Firebase + FCM + HTTP)

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
git clone https://github.com/KashifKT/task-todo-mvc-firebase-http.git
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

Add your app screenshots here

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

Your Name
