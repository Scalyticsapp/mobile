# SCALYTICS - Smart Scalp Analysis Application

SCALYTICS adalah aplikasi analisis kesehatan kulit kepala berbasis mobile yang dirancang untuk membantu pengguna mengetahui kondisi scalp secara cepat, praktis, dan real-time. Sistem ini mengintegrasikan teknologi Mobile Development, REST API, serta konsep Computer Vision untuk mendeteksi kondisi kulit kepala dan memberikan rekomendasi perawatan yang sesuai.

---

# Fitur Utama

## Authentication System

- Login akun pengguna
- Register akun pengguna
- Google Sign In
- Logout
- Session Management

---

## Scalp Analysis

- Upload gambar kulit kepala
- Scan kondisi scalp
- Analisis kondisi kulit kepala
- Deteksi jenis masalah scalp
- Menampilkan hasil analisis

---

## Recommendation System

- Rekomendasi perawatan scalp
- Daily scalp routine
- Tips kesehatan kulit kepala
- Informasi treatment sesuai hasil analisis

---

## Progress Monitoring

- Riwayat hasil scan
- Monitoring perkembangan scalp
- Statistik progress perawatan
- Detail hasil analisis sebelumnya

---

## User Interface

- Modern UI Design
- Responsive Mobile Interface
- Reusable Widget Components
- Bottom Navigation System
- Clean Architecture Design

---

# Teknologi yang Digunakan

## Frontend Mobile

- Flutter
- Dart
- GetX State Management

---

## Backend

- Node.js
- Express.js
- REST API
- TypeScript

---

## Database & Authentication

- Supabase
- Supabase Authentication

---

## Computer Vision & AI

- Python
- TensorFlow / Keras
- CNN (Convolutional Neural Network)

---

## Library Pendukung

- GetX
- HTTP
- Image Picker
- Flutter Secure Storage
- Supabase Flutter

---

# Struktur Project

```txt
lib/
│
├── controllers/
│   ├── auth_controller.dart
│   ├── dashboard_controller.dart
│   ├── progress_controller.dart
│   ├── result_controller.dart
│   └── scan_controller.dart
│
├── core/
│   ├── bindings/
│   ├── constants/
│   └── theme/
│
├── data/
│   ├── models/
│   ├── repositories/
│   └── services/
│
├── routes/
│
├── views/
│   ├── auth/
│   ├── dashboard/
│   ├── profile/
│   ├── progress/
│   ├── recommendation/
│   ├── result/
│   ├── scan/
│   └── splash/
│
├── widgets/
│
└── main.dart
```

---

# Cara Menjalankan Project

## 1. Clone Repository

```bash
git clone https://github.com/username/scalytics.git
```

---

## 2. Install Dependencies

```bash
flutter pub get
```

---

## 3. Jalankan Project

```bash
flutter run
```

---

# Future Development

- Integrasi AI Scalp Detection
- Real-time Computer Vision Analysis
- Cloud Image Storage
- Scalp Health Tracking
- Personalized Recommendation System

---

# Developer

SCALYTICS Development Team
