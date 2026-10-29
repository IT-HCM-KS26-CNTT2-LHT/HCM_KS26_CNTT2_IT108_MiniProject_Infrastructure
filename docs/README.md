# HỆ THỐNG QUẢN TRỊ HẠ TẦNG & NHẬT KÝ KỸ THUẬT

## Giới thiệu

Hệ thống quản lý hạ tầng cho Startup **GreenTech**. Hệ thống làm hai việc chính:

- Tự động **lọc lỗi nghiêm trọng** (`CRITICAL`, `ERROR 404`, `TIMEOUT`) từ file log để báo cáo cho quản lý.
- Quản lý **100 trạm cảm biến IoT** (CPU, RAM, SSD) bằng bảng Excel có VLOOKUP.

Cấu trúc dự án (kebab-case, không dấu, không dấu cách):

```text
CNTT01_TinHocCoBan_MiniProject_GreenTech/
├── docs/        README.md, srs-he-thong.docx
├── scripts/     auto_report.bat, auto_report.sh
├── data/        log-he-thong.log, quan-ly-thiet-bi.xlsx
├── backup/      bao-cao-su-co.txt
├── .env         cấu hình GIẢ LẬP (file ẩn)
└── .gitignore
```

## Cài đặt

**Bước 1. Tạo cây thư mục bằng 1 dòng lệnh.**

Windows PowerShell:

```powershell
mkdir greentech-system\docs, greentech-system\scripts, greentech-system\data, greentech-system\backup
```

**Bước 2. Tạo file ẩn `.env` bằng đường dẫn tương đối.**

```bash
cd greentech-system                       # đi vào thư mục dự án
echo "DB_PASSWORD=DemoPassword@123" > .env   # > ghi đè, tạo file mới
echo "APP_ENV=development" >> .env           # >> ghi nối, giữ dòng cũ
cd data                                   # vào thư mục con
cd ..                                     # lùi 1 cấp về thư mục gốc
ls -la                                    # xem cả file ẩn (PowerShell: Get-ChildItem -Force)
```

> Ký hiệu: `.` là thư mục hiện tại, `..` là thư mục cha, `~` là thư mục Home.

**Bước 3 (tuỳ chọn).** Bảo vệ mật khẩu: đời thật phải ghi `.env` vào `.gitignore`. Trong bài này `.env` chỉ chứa dữ liệu **giả** nên mình để dòng đó ở dạng chú thích.

## Cách chạy script lọc log

Windows (CMD), đứng ở thư mục gốc:

```bat
scripts\auto_report.bat
```

macOS / Linux:

```bash
bash scripts/auto_report.sh
```

Sau đó mở `backup/bao-cao-su-co.txt` để xem báo cáo. Lệnh lọc cốt lõi:

```bat
type log-he-thong.log | findstr "CRITICAL ERROR TIMEOUT" >> bao-cao-su-co.txt
```

- `type` đọc file log, `|` (pipe) chuyển kết quả sang `findstr` để lọc, không tạo file trung gian.
- `>` tạo báo cáo mới có tiêu đề (ghi đè); `>>` ghi nối kết quả lọc vào sau tiêu đề.

### 4 bước thẩm định script do AI viết

| Bước | Làm gì | Áp dụng cho dự án này |
|------|--------|-----------------------|
| 1. Soi | Tìm lệnh nguy hiểm | Tìm `del /f /s /q`, `rm -rf`: script không có |
| 2. Dry-run | Chạy thử không xóa thật | Script chỉ đọc log và ghi báo cáo |
| 3. Sandbox | Thử trong thư mục giả | Chạy thử với log mẫu 400 dòng |
| 4. Chạy kèm log | Ghi lại để kiểm tra | `scripts\auto_report.bat >> audit.log 2>&1` |

## Tính năng

- [x] Khởi tạo cây thư mục bằng 1 lệnh
- [x] Lọc `CRITICAL`, `ERROR`, `TIMEOUT` từ file log lớn
- [x] Báo cáo sự cố tự động ghi vào `backup/`
- [x] Đối soát 100 trạm bằng `VLOOKUP` và `TRIM`
- [x] Tài liệu SRS có mục lục tự động

## Phụ thuộc

- Windows CMD (có sẵn `type`, `findstr`) hoặc bash (có sẵn `grep`)
- Microsoft Excel (hoặc Google Sheets) để mở `quan-ly-thiet-bi.xlsx`
- Microsoft Word để mở `srs-he-thong.docx`
- Git để đưa lên GitHub

## Checklist kiểm tra thiết bị

- [x] Có đủ 4 thư mục `docs`, `scripts`, `data`, `backup`
- [x] Có file `.env` (xem bằng `ls -la`)
- [x] `auto_report` chạy không báo lỗi
- [ ] Cột `ten_thiet_bi` trong Excel không có `#N/A`
- [ ] Mục lục trong file Word hiển thị đủ
- [ ] Mỗi trạm ngoài trang trại có đủ thông tin CPU, RAM, SSD

## Bảng thông số phần cứng (trích)

| Mã linh kiện | Tên thiết bị | Đơn giá (VND) | Lưu trữ |
|--------------|--------------|--------------:|:-------:|
| LK001 | Mini PC Intel N100 8GB | 4,200,000 | SSD |
| LK003 | Raspberry Pi 4B 4GB | 1,500,000 | SSD |
| LK006 | Mini PC Celeron J4125 | 3,900,000 | HDD |
| LK009 | Thin Client J1900 | 2,100,000 | HDD |

Đủ 10 linh kiện và 100 trạm nằm trong `data/quan-ly-thiet-bi.xlsx`.

## Thời gian tải log (bẫy Mbps và MB/s)

Chữ **b** nhỏ là bit, chữ **B** hoa là Byte. 1 Byte = 8 bit nên **MB/s = Mbps ÷ 8**.
Ví dụ: 80 Mbps = 10 MB/s.

| Dung lượng log | Tốc độ mạng | Quy đổi | Thời gian tải |
|---------------:|------------:|--------:|--------------:|
| 500 MB | 50 Mbps | 6.25 MB/s | 80 giây |
| 500 MB | 80 Mbps | 10 MB/s | 50 giây |
| 500 MB | 100 Mbps | 12.5 MB/s | 40 giây |

## Lỗi thường gặp

| Lỗi | Thường do | Cách xử lý |
|-----|-----------|------------|
| Command not found | Sai chính tả, chưa cài | Kiểm tra lại tên lệnh |
| No such file or directory | Sai đường dẫn, đứng sai thư mục | Gõ `pwd`, dùng phím Tab |
| Permission denied | Thiếu quyền | Kiểm tra thư mục, cấp đúng quyền |
| File already exists | Trùng tên | Đổi tên hoặc kiểm tra file cũ |

## Prompt mẫu để nhờ AI viết script

```text
Bối cảnh: Tôi là DevOps ở startup, có file log 500MB trên Windows.
Nhiệm vụ: Viết script .bat lọc dòng CRITICAL, ERROR, TIMEOUT.
Yêu cầu: Dùng pipe, ghi nối bằng >>, đường dẫn tương đối, có comment, KHÔNG dùng lệnh xóa.
Không cần: Giải thích dài dòng.
```
