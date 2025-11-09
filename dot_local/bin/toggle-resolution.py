#!/usr/bin/env python3
import subprocess
import re

def notify(title, message):
    """呼叫 notify-send 顯示桌面通知"""
    subprocess.run(["notify-send", title, message])

# 取得 kscreen-doctor 輸出
output = subprocess.check_output(["kscreen-doctor", "-o"], text=True)

# 取得主螢幕名稱
match_output = re.search(r"Output: \d+ (\S+)", output)
screen = match_output.group(1) if match_output else "eDP-1"

# 取得帶 * 的模式（當前模式）
match_mode = re.search(r"(\d+x\d+@\d+\*)", output)
current_mode = match_mode.group(1) if match_mode else ""

# 取得 Geometry（邏輯解析度）
match_geom = re.search(r"Geometry: \S+ (\d+)x(\d+)", output)
geom_width, geom_height = (int(match_geom.group(1)), int(match_geom.group(2))) if match_geom else (0,0)

# 計算縮放
mode_width = int(current_mode.split('x')[0]) if current_mode else geom_width
current_scale = mode_width // geom_width if geom_width else 1

print(f"偵測：目前模式={current_mode}, Geometry={geom_width}x{geom_height}, 縮放={current_scale}")

# 切換解析度/縮放
if current_mode.startswith("3840x2400") and current_scale == 2:
    new_mode = "1920x1200"
    new_scale = 1
    subprocess.run(["kscreen-doctor", f"output.{screen}.mode.7", f"output.{screen}.scale.{new_scale}"])
else:
    new_mode = "3840x2400"
    new_scale = 2
    subprocess.run(["kscreen-doctor", f"output.{screen}.mode.1", f"output.{screen}.scale.{new_scale}"])

# 顯示通知
notify("解析度切換完成", f"目前模式: {new_mode}, 縮放: {new_scale * 100}%")
