# MusicApp

MusicApp คือ แอปจาก flutter ที่ให้ผู้ใช้ฟังเพลงหรือ สร้าง playlist ส่วนตัวได้จาก API Jamendo

## ฟีเจอร์ (Features)
- playlist จาก API Jamendo
- สามารถกดข้ามเพลง / หยุดเพลง
- มีหลอดสำหรับปรับเวลาเพลง
- เล่นเพลงตามคิวในplaylist / เลือกเพลงใน playlist
- สร้างหรือลบ playlist ของตัวเอง / ลบเพลงบางรายการของplaylist ตัวเอง

## วิธีติดตั้ง (Installation)
Clone Repository
```
https://github.com/Narongchai70/Music_App.git
```
Install Dependencies
```
flutter pub get
```
## Technologies Used (เทคโนโลยีที่ใช้)
- GetX – State Management & Navigation  
- GetStorage – Local Key-Value Storage  
- Dio – HTTP Requests  
- Just Audio – Audio Playback  

## โครงสร้างโปรเจกต์ (Project Structure)
```
lib/
│
├── main.dart                          # Entry point
├── app_binding.dart                   # Initial bindings
│
├── controller/
│   └── player_controller.dart         # Global player controller
│
├── data/
│   ├── models/                        # Data model classes (e.g., Track, Playlist)
│   ├── providers/                     # API or data source layer (e.g., Jamendo API)
│   └── repositories/                  # Business logic layer
│
├── ui/
│   ├── custom_playlist/
│   │   ├── controller/                # Controller สำหรับ custom playlist
│   │   ├── widget/                    # UI components (e.g., list item, bottom sheet)
│   │   └── custom_playlist_page.dart # หน้าหลักของ custom playlist
│   │
│   ├── my_playlist/
│   │   ├── controller/                # Controller สำหรับ static + custom playlist
│   │   ├── widget/                    # แยกเป็น PlaylistItem, MiniPlayer, etc.
│   │   └── my_playlist.dart           # หน้า Playlist รวมทั้งหมด
│   │
│   ├── tracklist/
│   │   ├── controller/                # สำหรับ track list ต่อ playlist/tag
│   │   ├── widget/                    # Components เช่น TrackListItem
│   │   └── playlist_tracks_page.dart # หน้ารายชื่อเพลงใน playlist
│   │
│   └── widget/                        # Widgets ที่ใช้ร่วมกัน เช่น SnackbarCustom
│       └── snackbar_custom.dart
```
