#!/bin/bash
# HEADER: auto_report.sh - Robot loc log GreenTech (macOS/Linux)
# Chay: bash scripts/auto_report.sh
# COMMENTS: [AUDIT] Script chi doc log va ghi bao cao, KHONG co lenh xoa.
DIR="$(cd "$(dirname "$0")" && pwd)"
LOG="$DIR/../data/log-he-thong.log"
OUT="$DIR/../backup/bao-cao-su-co.txt"
mkdir -p "$DIR/../backup"

echo "=== DANG LOC LOG ==="
echo "=== BAO CAO SU CO GREENTECH ===" > "$OUT"     # > tao bao cao moi
echo "Ngay chay: $(date)" >> "$OUT"
grep -E "CRITICAL|ERROR|TIMEOUT" "$LOG" >> "$OUT"    # >> ghi noi them
echo "=== XONG === Bao cao: backup/bao-cao-su-co.txt"
