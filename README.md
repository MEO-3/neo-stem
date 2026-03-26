# NEO STEM

Ứng dụng giáo dục STEM tương tác cho học sinh Việt Nam (Lớp 3-9).

20 hiện tượng khoa học từ đời sống thường ngày, học qua 5 bước: Hiện tượng - Câu hỏi - Thí nghiệm - Mô hình - Thách thức.

## Cài đặt

### Cài tự động (Linux / macOS)

```bash
curl -sSL https://raw.githubusercontent.com/MEO-3/neo-stem/main/scripts/install_on_neo.sh | bash
```

Tùy chọn:

```bash
bash scripts/install_on_neo.sh --no-desktop   # Bỏ qua tạo shortcut desktop
bash scripts/install_on_neo.sh --no-venv       # Cài vào system Python
bash scripts/install_on_neo.sh --uninstall     # Gỡ cài đặt
```

### Cài thủ công

```bash
pip install PyQt6
python -m neo_stem.app
```

Hoặc dùng entry point:

```bash
pip install -e .
neostem
```

## Kiến trúc

NEO STEM sử dụng **PyQt6 + QML** với Python backend:

- **QML UI** (`neo_stem/qml/`): Toàn bộ 20 hoạt động với giao diện QML
  - `core/`: Component dùng chung (ActivityBase, NeoBar, NeoBonus, ...)
  - `menu/`: Màn hình điều hướng (MainMenu, QuestionSelector, ...)
  - `activities/`: 20 thư mục hoạt động, mỗi thư mục có 5 bước
- **Python Backend** (`neo_stem/backend/`): QObject bridge classes
  - `progress_backend.py`: Lưu trữ tiến độ (SQLite)
  - `badge_backend.py`: Hệ thống huy hiệu
- **Dữ liệu** (`neo_stem/data/`): Metadata 20 câu hỏi

## Yêu cầu hệ thống

- Python 3.8+
- PyQt6 6.5+

## Nền tảng hỗ trợ

- Linux x86_64 (Ubuntu 22.04+ / Debian 12+)
- Linux ARM64 (Armbian Bookworm / Ubuntu 22.04+)
- macOS 13+
- Windows 10+

## License

MIT - Bình Dân Học STEM & Robot
