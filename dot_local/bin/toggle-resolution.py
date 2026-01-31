#!/usr/bin/env python3
import subprocess
import re
import sys

def notify(title, message):
    """呼叫 notify-send 顯示桌面通知"""
    try:
        subprocess.run(["notify-send", title, message])
    except:
        pass

def strip_ansi(text):
    """移除 ANSI 顏色跳脫字元"""
    ansi_escape = re.compile(r'\x1B(?:[@-Z\\-_]|\[[0-?]*[ -/]*[@-~])')
    return ansi_escape.sub('', text)

# 1. 取得 kscreen-doctor 輸出
try:
    raw_output = subprocess.check_output(["kscreen-doctor", "-o"], text=True)
    output = strip_ansi(raw_output)
except Exception as e:
    print(f"執行失敗: {e}")
    sys.exit(1)

# 2. 取得螢幕名稱
try:
    screen = output.split('\n')[0].split()[2].strip()
except Exception:
    screen = "eDP-1"

# 3. 解析模式與狀態
res_map = {}
curr_res = None

for part in output.split():
    if ":" in part and "@" in part:
        try:
            # 移除符號
            clean_part = part.replace("!", "").replace("*", "")
            mid_res_part = clean_part.split("@")[0]
            mid = mid_res_part.split(":")[0]
            res = mid_res_part.split(":")[1]
            
            if res not in res_map:
                res_map[res] = mid
            
            if "*" in part:
                curr_res = res
        except:
            continue

# 備援：若沒抓到目前的模式，嘗試從 Geometry 抓
if not curr_res:
    geo_match = re.search(r"Geometry: \d+,\d+ (\d+x\d+)", output)
    curr_res = geo_match.group(1) if geo_match else None

if not curr_res:
    print("失敗: 無法辨識目前解析度模式")
    sys.exit(1)

# 4. 判斷切換目標 (家族規則)
target_res = None
if curr_res == "3840x2400":
    target_res = "1920x1200"
elif curr_res == "1920x1200":
    target_res = "3840x2400"
elif curr_res == "3200x1800":
    target_res = "1920x1080"
elif curr_res == "1920x1080":
    target_res = "3200x1800"
else:
    # Fallback 到 16:9
    target_res = "3200x1800" if not curr_res.startswith("3840") else "1920x1080"

target_id = res_map.get(target_res)

# 如果找不到目標，嘗試在家族內尋找替代品
if not target_id:
    fallback_order = ["1920x1200", "3840x2400", "3200x1800", "1920x1080"]
    for res in fallback_order:
        if res in res_map and res != curr_res:
            target_res = res
            target_id = res_map[res]
            break

if not target_id:
    print(f"失敗: 在系統中找不到解析度 {target_res}")
    sys.exit(1)

# 5. 決定比例
if target_res == "3840x2400":
    target_scale = "2"
    percent = "200%"
elif target_res == "3200x1800":
    target_scale = "1.6666666666666667"
    percent = "167%"
else:
    target_scale = "1"
    percent = "100%"

msg = f"{target_res} ({percent})"

# 6. 執行
cmd = ["kscreen-doctor", f"output.{screen}.mode.{target_id}", f"output.{screen}.scale.{target_scale}"]
result = subprocess.run(cmd, capture_output=True, text=True)

if result.returncode != 0:
    # 修復驅動相衝：嘗試僅切換解析度
    subprocess.run(["kscreen-doctor", f"output.{screen}.mode.{target_id}"])
    notify("解析度切換成功 (排除比例)", msg)
else:
    notify("解析度切換成功", msg)
