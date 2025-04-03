# 📂 Offline File Transfer App (Flutter + WebRTC)

This project is a **Flutter-based Offline File Transfer App** that enables seamless file sharing between devices without an internet connection. It utilizes **WebRTC (RTCDataChannel)** for peer-to-peer communication and **QR codes** for easy connection setup.

---

## 🚀 Features
- 📡 **Offline file transfer** (No internet required)
- 🔗 **Peer-to-peer connection** using WebRTC
- 📷 **QR code-based pairing** for easy connection
- 📂 **Supports file sharing** between devices (Phone-to-Phone, Phone-to-PC, PC-to-PC)
- 💻 **Cross-platform compatibility** (Android, iOS, Windows, macOS, Linux)

---

## 📦 Dependencies

Before running the project, install the following dependencies in your `pubspec.yaml`:

```yaml
dependencies:
  flutter:
    sdk: flutter
  flutter_webrtc: ^0.9.29  # WebRTC support
  qr_flutter: ^4.1.0       # QR code generation
  file_picker: ^6.0.0      # File selection
```

Run:
```sh
flutter pub get
```

---

## 🛠️ Setup & Installation

### **1️⃣ Clone the Repository**
```sh
git clone https://github.com/yourusername/offline-file-transfer.git
cd offline-file-transfer
```

### **2️⃣ Run the App**
#### Android / iOS
```sh
flutter run
```
#### Windows / macOS / Linux
```sh
flutter run -d <platform>
```

> 📌 Make sure you have WebRTC permissions enabled (Microphone, Camera, Network access)

---

## 🔧 How It Works

### **📌 Step 1: Establish Connection**
1. One device creates a **WebRTC Peer Connection**
2. A **QR Code** with connection details is generated
3. The second device scans the QR code

### **📌 Step 2: Send File**
1. Select a file using the built-in **File Picker**
2. The file is split into **binary chunks** and sent via **RTCDataChannel**
3. The receiver gets the data and reconstructs the file

---

## 📝 Code Overview

### **📂 `main.dart` (Core Logic)**

- **`_initializeConnection()`** → Creates a WebRTC connection & Data Channel
- **`sendFile()`** → Picks a file and sends it over WebRTC
- **`onMessage()`** → Handles incoming file data
- **QR Code generation** → Displays connection info as QR

```dart
RTCDataChannelInit dataChannelInit = RTCDataChannelInit();
dataChannel = await peerConnection!.createDataChannel("fileChannel", dataChannelInit);

dataChannel!.onMessage = (RTCDataChannelMessage message) {
  print("📂 Received File Data: ${message.text}");
};
```

---

## 🔍 Troubleshooting

**1️⃣ App doesn't connect?**  
✅ Ensure both devices are on the **same network (Hotspot or Wi-Fi)**

**2️⃣ File transfer fails?**  
✅ Check **WebRTC permissions** (Camera, Microphone, Network)

**3️⃣ QR Code not scanning?**  
✅ Try **increasing QR Code size** for better readability

---

## 🤝 Contributing
Want to improve the app? Feel free to fork and submit a PR! 🛠️
```sh
git checkout -b feature-branch
git commit -m "Add new feature"
git push origin feature-branch
```

---

## 📜 License
MIT License - Free to use and modify 🎉

---

### 🎯 **Future Enhancements**
✅ File Transfer Progress Bar
✅ Bluetooth-based file sharing
✅ Web App Support
✅ UI/UX Improvements

💡 Got ideas? Let’s discuss! 🚀