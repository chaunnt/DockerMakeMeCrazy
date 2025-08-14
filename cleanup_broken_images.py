#!/usr/bin/env python3

import os
import sys
from PIL import Image, UnidentifiedImageError

def is_broken_image(filepath):
    try:
        with Image.open(filepath) as img:
            img.verify()  # verify() is better than just opening
        return False
    except (UnidentifiedImageError, IOError, OSError):
        return True

if len(sys.argv) < 2:
    print(f"Usage: {sys.argv[0]} /path/to/image/folder")
    sys.exit(1)

folder = sys.argv[1]

if not os.path.isdir(folder):
    print(f"Error: '{folder}' is not a valid directory.")
    sys.exit(1)

valid_extensions = (".jpg", ".jpeg", ".png", ".gif", ".bmp", ".tiff")

for root, dirs, files in os.walk(folder):
    for file in files:
        if file.lower().endswith(valid_extensions):
            full_path = os.path.join(root, file)
            if is_broken_image(full_path):
                print(f"❌ Deleting broken image: {full_path}")
                os.remove(full_path)
            else:
                print(f"✅ Good image: {full_path}")

