# NEO STEM - Tài liệu Kiến trúc & Hướng dẫn Triển khai

> **Phiên bản:** 1.0.0
> **Tổ chức:** Bình Dân Học STEM & Robot
> **Ngày cập nhật:** 2026-02-23

---

## 1. Tổng quan sản phẩm

**NEO STEM** là ứng dụng giáo dục tương tác dành cho học sinh Việt Nam (**Lớp 3-9, 8-15 tuổi**), giúp khám phá kiến thức STEM thông qua **20 hiện tượng khoa học** từ đời sống thường ngày.

### Đối tượng & Phân loại cấp độ

| Cấp độ | Nhãn | Lớp | Tuổi | Số hoạt động |
|--------|------|-----|------|:---:|
| Cơ bản | `basic` | Lớp 3-5 | 8-11 | 10 |
| Nâng cao | `intermediate` | Lớp 5-6 | 10-12 | 4 |
| THCS | `advanced` | Lớp 6-9 | 11-15 | 6 |

### Đặc điểm chính

- 20 hoạt động giáo dục theo phương pháp 5 bước khoa học
- **3 cấp độ** phù hợp từ tiểu học đến THCS
- Hệ thống gamification: 300 sao + 29 huy hiệu
- Giao diện cảm ứng tối ưu cho trẻ em
- Lưu trữ tiến độ offline bằng SQLite
- Hỗ trợ đa ngôn ngữ (Tiếng Việt mặc định)

---

## 2. Stack Công nghệ

| Thành phần       | Công nghệ               | Phiên bản   |
|-------------------|--------------------------|-------------|
| Framework UI      | Qt Quick / QML           | Qt 6.5+     |
| Ngôn ngữ backend  | C++ 17                   | gcc/clang   |
| Build system      | CMake                    | 3.16+       |
| Database          | SQLite (LocalStorage)    | 3.x         |
| UI Controls       | Qt Quick Controls 2      | -           |
| Multimedia        | Qt Multimedia            | -           |
| Style             | Qt Quick Basic style     | -           |

### Các module Qt sử dụng

```
Qt6::Quick           - Engine QML chính
Qt6::QuickControls2  - Thành phần giao diện (Button, Popup, StackView...)
Qt6::Multimedia      - Âm thanh, hiệu ứng audio
Qt6::Sql             - SQLite driver (khởi tạo DB trong C++)
```

---

## 3. Cấu trúc thư mục

```
NEO_STEM/
├── CMakeLists.txt                  # Build configuration
├── ARCHITECTURE.md                 # Tài liệu này
├── src/
│   ├── main.cpp                    # Entry point (C++)
│   │
│   ├── core/                       # UI Components dùng chung
│   │   ├── NeoConstants.qml        # [Singleton] Hằng số, dữ liệu, màu sắc
│   │   ├── ProgressTracker.qml     # [Singleton] CRUD tiến độ → SQLite
│   │   ├── BadgeSystem.qml         # [Singleton] Logic mở khóa huy hiệu
│   │   ├── ActivityBase.qml        # Lớp cơ sở cho 20 hoạt động
│   │   ├── NeoBar.qml              # Thanh điều hướng trên cùng
│   │   ├── NeoBonus.qml            # Popup thưởng khi hoàn thành bước
│   │   ├── NeoScore.qml            # Hiển thị sao (★★★)
│   │   ├── NeoAudio.qml            # Quản lý âm thanh
│   │   ├── PhenomenonViewer.qml    # Bước 1: Xem hiện tượng + hotspot
│   │   ├── DrivingQuestionBoard.qml# Bước 2: Bảng câu hỏi note dính
│   │   ├── DQBItem.qml             # Note đơn trên bảng câu hỏi
│   │   ├── InvestigationBase.qml   # Bước 3: Khung thí nghiệm
│   │   ├── ModelBuilder.qml        # Bước 4: Drag-drop mô hình
│   │   ├── ProblematizeChallenge.qml # Bước 5: Trắc nghiệm thách thức
│   │   ├── TouchButton.qml         # Nút bấm tối ưu cảm ứng (48px+)
│   │   ├── DragItem.qml            # Item kéo-thả
│   │   ├── DropZone.qml            # Vùng thả
│   │   ├── ParticleEffects.qml     # Hiệu ứng hạt (bọt, hơi, lấp lánh)
│   │   ├── ThermometerWidget.qml   # Widget nhiệt kế
│   │   └── SliderControl.qml       # Thanh trượt điều khiển
│   │
│   ├── menu/                       # Màn hình điều hướng
│   │   ├── MainMenu.qml            # [Root Window] Splash + StackView
│   │   ├── QuestionSelector.qml    # Chọn câu hỏi (4 nhóm chủ đề)
│   │   ├── StepSelector.qml        # Chọn bước trong 1 câu hỏi
│   │   ├── ProfileScreen.qml       # Hồ sơ + thống kê + huy hiệu
│   │   └── SettingsScreen.qml      # Cài đặt ngôn ngữ, reset dữ liệu
│   │
│   └── activities/                 # 20 hoạt động giáo dục
│       ├── q1_rice_cooker/         # Nồi cơm điện
│       │   ├── Q1RiceCooker.qml    # Activity wrapper (extends ActivityBase)
│       │   ├── Step1Phenomenon.qml # Bước 1: Quan sát
│       │   ├── Step2DQB.qml        # Bước 2: Câu hỏi
│       │   ├── Step3Investigation.qml # Bước 3: Thí nghiệm
│       │   ├── Step4Model.qml      # Bước 4: Mô hình
│       │   └── Step5Problematize.qml # Bước 5: Thách thức
│       ├── q2_dalat_fog/           # Sương mù Đà Lạt
│       ├── ...                     # (q3 → q20, cấu trúc tương tự)
│       └── q20_water_xylophone/    # Chai nước xylophone
│
├── translations/                   # File dịch
│   ├── neostem_vi.ts               # Tiếng Việt
│   └── neostem_en.ts               # Tiếng Anh
│
└── build/                          # Thư mục output (CMake)
```

---

## 4. Kiến trúc phần mềm

### 4.1 Sơ đồ tổng quan

```
┌─────────────────────────────────────────────────────────┐
│                    main.cpp (C++)                        │
│  ┌─────────────┐  ┌──────────────┐  ┌───────────────┐  │
│  │ QGuiApp     │  │ SQLite Init  │  │ QML Engine    │  │
│  │ + Font      │  │ 3 tables     │  │ → MainMenu    │  │
│  └─────────────┘  └──────────────┘  └───────────────┘  │
└─────────────────────────┬───────────────────────────────┘
                          │ load
┌─────────────────────────▼───────────────────────────────┐
│              MainMenu.qml (ApplicationWindow)            │
│                                                          │
│  ┌────────────────────────────────────────────────────┐  │
│  │               StackView (Navigation)                │  │
│  │                                                      │  │
│  │  ┌──────────┐  ┌────────────────┐  ┌────────────┐  │  │
│  │  │ Splash   │→ │QuestionSelector│→ │StepSelector│  │  │
│  │  │ Screen   │  │ (4 nhóm)      │  │ (5 bước)   │  │  │
│  │  └──────────┘  └────────────────┘  └─────┬──────┘  │  │
│  │                                          │          │  │
│  │  ┌──────────┐  ┌────────────────┐  ┌─────▼──────┐  │  │
│  │  │ Profile  │  │   Settings     │  │ Activity   │  │  │
│  │  │ Screen   │  │   Screen       │  │ (Q1-Q20)   │  │  │
│  │  └──────────┘  └────────────────┘  └────────────┘  │  │
│  └────────────────────────────────────────────────────┘  │
└──────────────────────────────────────────────────────────┘

┌──────────────────────────────────────────────────────────┐
│                  Singletons (Global State)                │
│                                                          │
│  NeoConstants          ProgressTracker      BadgeSystem  │
│  ├─ colors             ├─ saveProgress()    ├─ check()   │
│  ├─ questions[20]      ├─ getProgress()     ├─ unlock()  │
│  ├─ badges[29]         ├─ getTotalStars()   └─ icons     │
│  ├─ stepNames[5]       ├─ saveDQBNote()                  │
│  └─ typography         └─ resetAll()                     │
└──────────────────────────────────────────────────────────┘
```

### 4.2 Luồng Activity (Chi tiết)

```
QXActivity.qml (extends ActivityBase)
│
├── questionId, questionTitle, drivingQuestion
├── stepComponents: [5 URLs tới Step*.qml]
│
└── ActivityBase.qml
    ├── NeoBar         ← Điều hướng (Home/Back/Help/Stars)
    ├── Loader         ← Load động Step QML theo currentStep
    │   ├── Step1Phenomenon.qml   → PhenomenonViewer
    │   ├── Step2DQB.qml          → DrivingQuestionBoard
    │   ├── Step3Investigation.qml→ InvestigationBase
    │   ├── Step4Model.qml        → ModelBuilder
    │   └── Step5Problematize.qml → ProblematizeChallenge
    │
    ├── NeoBonus (popup)  ← Hiển thị khi hoàn thành bước
    │
    └── onStepDone(stars):
        ├── ProgressTracker.saveStepProgress()
        ├── BadgeSystem.checkBadges()
        └── Auto-advance hoặc backToMenu
```

### 4.3 Mô hình dữ liệu

```sql
-- Bảng 1: Tiến độ học tập (max 100 rows = 20 câu × 5 bước)
CREATE TABLE progress (
    question_id INTEGER NOT NULL,     -- 1-20
    step_id     INTEGER NOT NULL,     -- 0-4
    stars       INTEGER DEFAULT 0,    -- 0-3
    completed   INTEGER DEFAULT 0,    -- 0/1
    data        TEXT,                 -- JSON mở rộng
    PRIMARY KEY (question_id, step_id)
);

-- Bảng 2: Huy hiệu (max 29 rows)
CREATE TABLE badges (
    badge_id    TEXT PRIMARY KEY,     -- "first_step", "master_q1"...
    unlocked    INTEGER DEFAULT 0,    -- 0/1
    unlock_date TEXT                  -- ISO 8601
);

-- Bảng 3: Bảng câu hỏi phụ (max 160 rows = 20 × 8 notes)
CREATE TABLE dqb_state (
    question_id INTEGER NOT NULL,
    note_id     INTEGER NOT NULL,
    text        TEXT,
    answered    INTEGER DEFAULT 0,
    PRIMARY KEY (question_id, note_id)
);
```

**Lưu trữ kép:**
- `main.cpp` tạo DB bằng `Qt6::Sql` tại `QStandardPaths::AppDataLocation`
- `ProgressTracker.qml` sử dụng `Qt.labs.LocalStorage` (SQLite riêng QML)
- Cả hai tạo cùng schema, đảm bảo DB luôn sẵn sàng

---

## 5. Phương pháp giáo dục: 5 bước

| Bước | Tên                 | Component                  | Mô tả                              | Sao |
|------|---------------------|----------------------------|-------------------------------------|-----|
| 0    | Hiện tượng Neo      | `PhenomenonViewer`         | Quan sát, chạm hotspot khám phá     | 1-3 |
| 1    | Bảng câu hỏi       | `DrivingQuestionBoard`     | Đặt ≥3 câu hỏi phụ trên note dính  | 1-3 |
| 2    | Thí nghiệm         | `InvestigationBase`        | Mô phỏng, ghi dữ liệu, kết luận   | 1-3 |
| 3    | Xây dựng mô hình   | `ModelBuilder`             | Kéo-thả sắp xếp mô hình           | 1-3 |
| 4    | Thách thức          | `ProblematizeChallenge`    | Trắc nghiệm 4 đáp án (A/B/C/D)    | 1-3 |

**Tổng điểm:** 15 sao/câu hỏi × 20 câu hỏi = **300 sao tối đa**

---

## 6. 20 Hoạt động giáo dục

### Nhóm 1: Nước & Nhiệt (Lớp 3-5)

| ID | Hoạt động           | Hiện tượng                           | Kiến thức          | Cấp độ |
|----|---------------------|--------------------------------------|--------------------|:------:|
| Q1 | Nồi cơm điện       | Nắp nồi rung, có hơi nước           | Chuyển thể, bay hơi| Cơ bản |
| Q2 | Sương mù Đà Lạt    | Sương sáng sớm, tan trưa            | Chu trình nước     | Cơ bản |
| Q4 | Giọt nước trên ly đá| Giọt nước bám ngoài ly              | Ngưng tụ           | Cơ bản |
| Q5 | Muối biển           | Phơi nắng lấy muối                  | Bay hơi            | Cơ bản |
| Q17| Kem tan chảy        | Kem tan nhanh ngoài nắng             | Nóng chảy          | Cơ bản |

### Nhóm 2: Ánh sáng & Âm thanh (Lớp 4-7)

| ID | Hoạt động           | Hiện tượng                           | Kiến thức          | Cấp độ |
|----|---------------------|--------------------------------------|--------------------|:------:|
| Q6 | Cầu vồng           | Cầu vồng sau mưa                    | Khúc xạ, quang phổ | **THCS** |
| Q7 | Pha mặt trăng      | Hình dạng thay đổi mỗi đêm          | Phản xạ ánh sáng   | Cơ bản |
| Q8 | Tiếng trống         | Đập trống phát tiếng vang            | Sóng âm            | Cơ bản |
| Q13| Bóng đèn            | Bóng đèn sáng khi bật               | Điện → quang       | Cơ bản |
| Q20| Chai nước xylophone | Gõ chai nước khác mực nghe khác nhau | Tần số âm          | Cơ bản |

### Nhóm 3: Lực & Điện từ (Lớp 4-8)

| ID | Hoạt động           | Hiện tượng                           | Kiến thức          | Cấp độ |
|----|---------------------|--------------------------------------|--------------------|:------:|
| Q9 | Quạt điện           | Quạt quay khi cắm điện              | Mạch điện          | Cơ bản |
| Q10| Nam châm            | Hút sắt, không hút nhôm             | Từ tính            | Nâng cao |
| Q11| Xe đạp xuống dốc   | Xe nhanh hơn khi xuống dốc          | Thế năng/động năng | **THCS** |
| Q18| Bóng bay heli       | Bóng bay lên trời                   | Lực đẩy Archimedes | **THCS** |

### Nhóm 4: Sự sống & Hóa học (Lớp 4-9)

| ID | Hoạt động           | Hiện tượng                           | Kiến thức          | Cấp độ |
|----|---------------------|--------------------------------------|--------------------|:------:|
| Q3 | Rừng ngập mặn      | Cây sống trong nước mặn             | Thẩm thấu          | **THCS** |
| Q12| Lá cây xanh        | Lá xanh, hoa nhiều màu              | Quang hợp, sắc tố  | Nâng cao |
| Q14| Rỉ sét              | Sắt rỉ ngoài mưa                    | Oxy hóa            | **THCS** |
| Q15| Cá thở dưới nước   | Cá sống dưới nước                   | Hô hấp, mang cá    | Cơ bản |
| Q16| Nước ngọt có ga    | Bọt phun khi mở chai                | Áp suất, độ tan khí| Nâng cao |
| Q19| Đom đóm            | Phát sáng trong đêm                 | Phát quang sinh học | Nâng cao |

---

## 7. Hệ thống Gamification

### 7.1 Huy hiệu (29 loại)

| Loại             | Badge ID       | Điều kiện mở khóa                         |
|------------------|----------------|-------------------------------------------|
| Bước đầu tiên    | `first_step`   | Hoàn thành bất kỳ bước nào               |
| Nhà thám hiểm    | `explorer`     | Hoàn thành bước Hiện tượng               |
| Bậc thầy câu hỏi | `question_master` | Hoàn thành bước Bảng câu hỏi          |
| Nhà khoa học nhí | `young_scientist` | Hoàn thành bước Thí nghiệm             |
| Kiến trúc sư     | `architect`    | Hoàn thành bước Xây dựng mô hình         |
| Người thách thức | `challenger`   | Hoàn thành bước Thách thức               |
| Bậc thầy Q1-Q20  | `master_q1..20`| Hoàn thành đầy đủ 5/5 bước câu hỏi      |
| Hoàn hảo         | `perfect`      | Đạt 300/300 sao                          |
| Tự lực cánh sinh | `self_reliant` | 3 sao trên tất cả 5 bước của 1 câu hỏi  |
| Trí tuệ thám dò  | `adventurer`   | Hoàn thành tất cả 20 bước Hiện tượng     |

---

## 8. Hướng dẫn Build trên macOS (Development)

### Yêu cầu

```bash
# Cài Qt6 qua Homebrew
brew install qt@6 cmake

# Hoặc dùng Qt Online Installer
# https://www.qt.io/download-qt-installer
```

### Build

```bash
cd /path/to/NEO_STEM
mkdir -p build && cd build
cmake .. -DCMAKE_PREFIX_PATH=$(brew --prefix qt@6)
make -j$(sysctl -n hw.ncpu)
```

### Chạy

```bash
./build/neostem
```

---

## 9. Triển khai trên Linux Armbian (ARM, 2GB RAM)

### 9.1 Yêu cầu phần cứng tối thiểu

| Thông số       | Yêu cầu tối thiểu          | Khuyến nghị              |
|----------------|----------------------------|--------------------------|
| CPU            | ARM Cortex-A53 (aarch64)   | Cortex-A72 hoặc cao hơn |
| RAM            | 2 GB                       | 2 GB (đủ dùng)          |
| Storage        | 500 MB trống               | 2 GB trống              |
| Display        | Framebuffer hoặc X11/Wayland| HDMI/LCD với touchscreen |
| OS             | Armbian Bookworm (Debian 12)| Armbian 24.x+           |

### 9.2 Cài đặt Dependencies trên Armbian

```bash
# Cập nhật hệ thống
sudo apt update && sudo apt upgrade -y

# Cài đặt Qt6 development packages
sudo apt install -y \
    qt6-base-dev \
    qt6-declarative-dev \
    qt6-multimedia-dev \
    qml6-module-qtquick \
    qml6-module-qtquick-controls \
    qml6-module-qtquick-layouts \
    qml6-module-qtquick-window \
    qml6-module-qt-labs-localstorage \
    qml6-module-qtquick-particles \
    qt6-qml-dev \
    libqt6sql6-sqlite \
    libqt6multimedia6 \
    cmake \
    g++ \
    make

# Nếu Qt6 không có trong repo mặc định, thêm backports:
# sudo apt install -y -t bookworm-backports qt6-base-dev ...
```

### 9.3 Build Native trên Armbian

```bash
# Clone hoặc copy source code
# scp -r NEO_STEM/ user@armbian-ip:~/

cd ~/NEO_STEM
mkdir -p build && cd build

# Configure với tối ưu cho ARM + RAM thấp
cmake .. \
    -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_CXX_FLAGS="-O2 -march=native"

# Build (dùng 1-2 job để tránh hết RAM trên 2GB)
make -j2

# Nếu hết RAM khi build, giảm xuống 1 job:
# make -j1
```

### 9.4 Cross-Compile từ máy host (Tùy chọn nâng cao)

Nếu build native quá chậm, có thể cross-compile từ x86_64:

```bash
# Trên máy host (Ubuntu/Debian x86_64)
sudo apt install -y gcc-aarch64-linux-gnu g++-aarch64-linux-gnu

# Cần Qt6 cross-compiled cho aarch64
# Xem: https://doc.qt.io/qt-6/configure-linux-device.html

# CMake toolchain file (toolchain-aarch64.cmake):
cat > toolchain-aarch64.cmake << 'EOF'
set(CMAKE_SYSTEM_NAME Linux)
set(CMAKE_SYSTEM_PROCESSOR aarch64)
set(CMAKE_C_COMPILER aarch64-linux-gnu-gcc)
set(CMAKE_CXX_COMPILER aarch64-linux-gnu-g++)
set(CMAKE_FIND_ROOT_PATH /path/to/qt6-aarch64-sysroot)
set(CMAKE_FIND_ROOT_PATH_MODE_PROGRAM NEVER)
set(CMAKE_FIND_ROOT_PATH_MODE_LIBRARY ONLY)
set(CMAKE_FIND_ROOT_PATH_MODE_INCLUDE ONLY)
EOF

cmake .. -DCMAKE_TOOLCHAIN_FILE=toolchain-aarch64.cmake
make -j$(nproc)

# Copy binary sang Armbian
scp neostem user@armbian-ip:~/NEO_STEM/
```

### 9.5 Tối ưu cho 2GB RAM

#### Cấu hình swap (khuyến nghị)

```bash
# Tạo 1GB swap file
sudo fallocate -l 1G /swapfile
sudo chmod 600 /swapfile
sudo mkswap /swapfile
sudo swapon /swapfile

# Thêm vào fstab để tự động mount
echo '/swapfile none swap sw 0 0' | sudo tee -a /etc/fstab
```

#### Biến môi trường tối ưu QML

```bash
# Thêm vào ~/.bashrc hoặc script khởi chạy
export QT_QUICK_BACKEND=software          # Nếu không có GPU driver
export QSG_RENDER_LOOP=basic              # Giảm RAM cho render loop
export QT_QPA_PLATFORM=eglfs              # Fullscreen không cần X11
# Hoặc: export QT_QPA_PLATFORM=linuxfb   # Fallback nếu không có EGL
# Hoặc: export QT_QPA_PLATFORM=xcb       # Nếu chạy trên X11

# Giới hạn QML cache
export QML_DISK_CACHE_PATH=/tmp/qmlcache
```

#### Tối ưu hệ thống

```bash
# Giảm swappiness (ưu tiên RAM)
echo 'vm.swappiness=10' | sudo tee -a /etc/sysctl.conf
sudo sysctl -p

# Tắt các service không cần
sudo systemctl disable bluetooth
sudo systemctl disable cups
sudo systemctl disable ModemManager
```

### 9.6 Chạy ứng dụng

#### Chế độ 1: Fullscreen trên Framebuffer (Kiosk mode - khuyến nghị)

```bash
# Không cần X11/Desktop Environment
export QT_QPA_PLATFORM=eglfs
export QT_QPA_EGLFS_PHYSICAL_WIDTH=800
export QT_QPA_EGLFS_PHYSICAL_HEIGHT=480

cd ~/NEO_STEM
./build/neostem
```

#### Chế độ 2: Trên X11/Desktop

```bash
export QT_QPA_PLATFORM=xcb
export DISPLAY=:0

cd ~/NEO_STEM
./build/neostem
```

#### Chế độ 3: Trên Wayland

```bash
export QT_QPA_PLATFORM=wayland
cd ~/NEO_STEM
./build/neostem
```

### 9.7 Auto-start khi khởi động (Kiosk)

```bash
# Tạo systemd service
sudo tee /etc/systemd/system/neostem.service << 'EOF'
[Unit]
Description=NEO STEM Education App
After=multi-user.target

[Service]
Type=simple
User=neostem
Environment=QT_QPA_PLATFORM=eglfs
Environment=QSG_RENDER_LOOP=basic
WorkingDirectory=/home/neostem/NEO_STEM
ExecStart=/home/neostem/NEO_STEM/build/neostem
Restart=on-failure
RestartSec=5

[Install]
WantedBy=multi-user.target
EOF

# Kích hoạt
sudo systemctl daemon-reload
sudo systemctl enable neostem.service
sudo systemctl start neostem.service

# Kiểm tra trạng thái
sudo systemctl status neostem.service
```

### 9.8 Cài đặt Touchscreen (nếu có)

```bash
# Kiểm tra touchscreen
sudo apt install -y evtest
sudo evtest  # Chọn touch device

# Cài tslib cho calibration
sudo apt install -y libts-bin
sudo ts_calibrate

# Cấu hình biến môi trường
export QT_QPA_EVDEV_TOUCHSCREEN_PARAMETERS=/dev/input/eventX
# Thay eventX bằng device thực tế
```

---

## 10. Troubleshooting

### Lỗi thường gặp trên Armbian

| Lỗi | Nguyên nhân | Giải pháp |
|------|-------------|-----------|
| `Could not find Qt6` | Thiếu Qt6 dev packages | `sudo apt install qt6-base-dev` |
| `module "QtQuick" is not installed` | Thiếu QML modules | Cài `qml6-module-qtquick*` |
| `Cannot create EGL display` | Không có GPU driver | Dùng `QT_QPA_PLATFORM=linuxfb` |
| `Out of memory` khi build | RAM không đủ | Dùng `make -j1` + thêm swap |
| `QSQLITE driver not loaded` | Thiếu SQLite plugin | `sudo apt install libqt6sql6-sqlite` |
| Font emoji không hiển thị | Thiếu font emoji | `sudo apt install fonts-noto-color-emoji` |
| Touchscreen không phản hồi | Chưa cấu hình input | Cài `evtest`, cấu hình evdev |

### Kiểm tra Qt6 đã cài đầy đủ

```bash
# Liệt kê QML modules đã cài
qml6 -list-modules 2>/dev/null || ls /usr/lib/*/qt6/qml/

# Kiểm tra phiên bản Qt
qmake6 --version

# Test chạy Qt app đơn giản
cat > /tmp/test.qml << 'EOF'
import QtQuick
import QtQuick.Controls
ApplicationWindow {
    visible: true; width: 400; height: 300
    Text { anchors.centerIn: parent; text: "Qt6 OK!"; font.pixelSize: 32 }
}
EOF
qml6 /tmp/test.qml
```

---

## 11. Thông số hiệu năng dự kiến

| Thông số            | macOS (M1)   | Armbian ARM (2GB) |
|---------------------|--------------|-------------------|
| Thời gian khởi động | ~1s          | ~3-5s             |
| RAM sử dụng         | ~80-120 MB   | ~60-100 MB        |
| Kích thước binary   | ~4 MB        | ~3-5 MB           |
| SQLite DB           | < 1 MB       | < 1 MB            |
| FPS UI              | 60 fps       | 30-60 fps         |

---

## 12. Đường dẫn dữ liệu

| Platform | Đường dẫn DB |
|----------|-------------|
| macOS    | `~/Library/Application Support/BinhDanHocSTEM/NEO_STEM/neostem.db` |
| Linux    | `~/.local/share/BinhDanHocSTEM/NEO_STEM/neostem.db` |
| QML LocalStorage | `~/.local/share/BinhDanHocSTEM/NEO_STEM/QML/OfflineStorage/` |

---

## 13. License & Credits

- **Phát triển:** Bình Dân Học STEM & Robot
- **Framework:** Qt 6 (LGPL v3 / Commercial)
- **Target:** Giáo dục phi lợi nhuận cho trẻ em Việt Nam
