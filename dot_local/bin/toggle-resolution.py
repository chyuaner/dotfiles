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

# 1. 取得 kscreen-doctor 輸出
try:
    output = subprocess.check_output(["kscreen-doctor", "-o"], text=True)
except Exception as e:
    print(f"執行失敗: {e}")
    sys.exit(1)

# 2. 取得螢幕名稱與目前狀態
try:
    # 取得第一行第三個單字作為螢幕名稱 (例如 eDP-1)
    screen = output.split('\n')[0].split()[2].strip()
except Exception as e:
    print(f"失敗: 無法解析螢幕名稱\n{output}")
    sys.exit(1)

# 3. 解析所有模式與目前狀態
# 3. 解析模式與目前狀態
# 取得目前使用的 ID 與解析度 (最後帶有 *)
curr_match = re.search(r"(\d+):(\d+x\d+)@[^*]*\*", output)
if not curr_match:
    print("失敗: 無法辨識目前解析度模式")
    sys.exit(1)

curr_id, curr_res = curr_match.groups()

# 取得 4K 與 1200p 的模式 ID
id_4k = None
id_1200p = None

for mid, res in re.findall(r"(\d+):(\d+x\d+)@", output):
    if res == "3840x2400":
        id_4k = mid
    if res == "1920x1200":
        id_1200p = mid

# 4. 切換邏輯
# 如果目前解析度是 4K (3840x2400)，則切換往 1200p
if curr_res == "3840x2400" and id_1200p:
    target, scale, msg = id_1200p, "1", "1200p (100%)"
else:
    # 否則（目前在 1200p 或其他模式）切換往 4K
    target, scale, msg = id_4k, "2", "4K (200%)"

if not target:
    print(f"失敗: 找不到目標模式 (3840x2400={id_4k}, 1920x1200={id_1200p})")
    sys.exit(1)

# 5. 執行指令
subprocess.run([
    "kscreen-doctor", 
    f"output.{screen}.mode.{target}", 
    f"output.{screen}.scale.{scale}"
])

# 6. 顯示通知
notify("解析度切換完成", f"已切換至 {msg}")
