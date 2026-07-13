#!/usr/bin/env python3
"""Minimal encoding check for loji-perspective repository.
Rejects commits containing mojibake (corrupted CJK characters)."""

import sys
from pathlib import Path

BAD_MARKERS = [
    "�",      # Unicode replacement character
    "逕ｨ菴",       # Common mojibake pattern 1
    "隶ｰ菴",       # Common mojibake pattern 2
    "銝",          # Common mojibake pattern 3
    "蝵",          # Common mojibake pattern 4
]

ROOT = Path(__file__).resolve().parent.parent
EXTS = {".md", ".json", ".yaml", ".yml", ".txt", ".sh", ".ps1", ".py"}

def check_file(path: Path) -> bool:
    try:
        content = path.read_text(encoding="utf-8")
    except UnicodeDecodeError:
        print(f"FAIL: {path.relative_to(ROOT)} — not valid UTF-8")
        return False

    for marker in BAD_MARKERS:
        if marker in content:
            print(f"FAIL: {path.relative_to(ROOT)} — contains mojibake marker: {repr(marker)}")
            return False
    return True

def main():
    failed = []
    for path in sorted(ROOT.rglob("*")):
        if path.is_file() and path.suffix in EXTS and ".git" not in path.parts:
            if not check_file(path):
                failed.append(path)

    if failed:
        print(f"\n{len(failed)} file(s) with encoding issues.")
        sys.exit(1)
    else:
        print("All files pass encoding check.")
        sys.exit(0)

if __name__ == "__main__":
    main()
