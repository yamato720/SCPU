#!/bin/bash
# 快速查看最新生成的波形文件

echo "正在查找最新的 VCD 波形文件..."

LATEST_VCD=$(find test_run_dir -name "*.vcd" -type f -printf '%T@ %p\n' 2>/dev/null | sort -n | tail -1 | cut -f2- -d" ")

if [ -z "$LATEST_VCD" ]; then
    echo "❌ 没有找到 VCD 文件！"
    echo ""
    echo "请先运行测试生成波形："
    echo "  sbt test"
    echo ""
    echo "或者查看文档了解如何生成波形："
    echo "  cat doc/chisel/VERILOG_TESTBENCH_TO_CHISEL.md"
    exit 1
fi

echo "✅ 找到波形文件: $LATEST_VCD"
echo ""

# 检查是否安装了 gtkwave
if command -v gtkwave &> /dev/null; then
    echo "🚀 正在打开 GTKWave..."
    gtkwave "$LATEST_VCD" &
else
    echo "⚠️  未检测到 GTKWave"
    echo ""
    echo "请安装 GTKWave："
    echo "  sudo pacman -S gtkwave    # Arch Linux"
    echo "  sudo apt install gtkwave  # Ubuntu/Debian"
    echo "  brew install gtkwave      # macOS"
    echo ""
    echo "或者手动打开文件："
    echo "  $LATEST_VCD"
fi

