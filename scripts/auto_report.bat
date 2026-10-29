@echo off
REM ==================================================
REM  HEADER: auto_report.bat - Robot loc log GreenTech
REM  Chay: o thu muc goc du an, go  scripts\auto_report.bat
REM ==================================================

REM COMMENTS (ghi chu cho nguoi doc):
REM  - %~dp0 la thu muc chua file .bat nay (scripts\).
REM  - ..  la lui 1 cap. Day la DUONG DAN TUONG DOI, copy sang may khac van chay.
REM  - [AUDIT] Script chi DOC log va GHI bao cao. KHONG co lenh xoa nao.
REM    Neu AI goi y del /f /s /q thi DUNG LAI: soi, dry-run, thu trong sandbox.
set "LOG=%~dp0..\data\log-he-thong.log"
set "BACKUP=%~dp0..\backup"
set "OUT=%BACKUP%\bao-cao-su-co.txt"

if not exist "%LOG%" (
    echo [LOI] Khong tim thay file log: %LOG%
    pause
    exit /b 1
)
if not exist "%BACKUP%" mkdir "%BACKUP%"

REM ECHO thong bao:
echo === DANG LOC LOG ===

REM Mot dau lon hon: tao bao cao MOI co tieu de, ghi de noi dung cu
echo === BAO CAO SU CO GREENTECH === > "%OUT%"
echo Ngay chay: %date% %time% >> "%OUT%"

REM LENH LOC: type doc file, pipe (|) chuyen sang findstr loc dong loi.
REM findstr "A B C" nghia la tim dong chua A hoac B hoac C.
REM Hai dau lon hon: ghi NOI them, giu tieu de o tren
type "%LOG%" | findstr "CRITICAL ERROR TIMEOUT" >> "%OUT%"

echo === XONG ===
echo Bao cao nam o: %OUT%
pause
