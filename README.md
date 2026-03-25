# NEO STEM

Ứng dụng giáo dục STEM tương tác cho học sinh Việt Nam (Lớp 3-9).

20 hiện tượng khoa học từ đời sống thường ngày, học qua 5 bước: Hiện tượng - Câu hỏi - Thí nghiệm - Mô hình - Thách thức.

## Chạy nhanh (PyQt5)

```bash
pip install PyQt5
python -m neo_stem.app
```

Hoặc dùng entry point:

```bash
pip install -e .
neostem
```

## Trạng thái migration

- Đang chuyển từ Qt6/QML + C++ sang PyQt5 Widgets.
- Đã hoàn thiện UI cho Q1–Q6 theo nội dung gốc.

## Yêu cầu hệ thống (PyQt5)

- Python 3.8+
- PyQt5 5.15+

## Bản Qt6/QML (legacy)

Nếu cần build bản QML/C++ gốc:

```bash
git clone https://github.com/tuanln/NEO_STEM.git
cd NEO_STEM
bash install-armbian.sh   # Linux
# hoặc: brew install qt@6 && mkdir build && cd build && cmake .. && make  # macOS
```

## License

MIT - Bình Dân Học STEM & Robot
