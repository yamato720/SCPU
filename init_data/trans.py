#!/usr/bin/env python3
"""
RISC-V 指令转换工具：生成 Chisel BRAM 初始化文件

功能：
1. 将 32 位 RISC-V 指令（十六进制）转换为字节序列
2. RISC-V 使用小端序（Little-Endian）：低字节在前
3. 生成适用于 Chisel loadMemoryFromFileInline 的 hex 文件格式
4. BRAM 字节编址：每行一个字节（2位十六进制）

使用方法：
1. 在 instructions 列表中添加指令（32位十六进制，无需0x前缀）
2. 运行脚本：python trans.py
3. 生成的文件位于当前目录，文件名由 output_file 指定

示例：
    指令 0x0C800093 (ADDI x1, x0, 200) 转换为小端序：
    地址 0: 93
    地址 1: 00
    地址 2: 80
    地址 3: 0C
"""

import os

# ============ 配置区域 ============

# 指令列表：在此添加 RISC-V 指令（32位十六进制，一行一条）
# 格式：不带0x前缀，大写或小写均可
instructions = """
0C800093
07F00113
F8000193
0FF00213
00007297
C6728293
FFFF8337
00010397
FE338393
40000413
FFF00493
00208023
003080A3
00408123
00509223
00609323
00709523
0080A623
0090A823
00008503
00108583
0020C603
00409683
00609703
00A0D783
00C0A803
0100A883
00000013
00000013
"""

# 输出文件名
output_file = "program.hex"

# ============ 转换逻辑 ============

def instruction_to_bytes(inst_hex):
    """
    将32位指令转换为小端序字节列表
    
    Args:
        inst_hex: 32位十六进制字符串（如 "0C800093"）
    
    Returns:
        list: 4个字节的列表，小端序 [byte0, byte1, byte2, byte3]
    
    示例：
        0x0C800093 -> [0x93, 0x00, 0x80, 0x0C]
    """
    # 移除可能的空格和0x前缀
    inst_hex = inst_hex.strip().replace("0x", "").replace("0X", "")
    
    # 确保是8位十六进制（补齐前导零）
    inst_hex = inst_hex.zfill(8)
    
    # 提取4个字节（每2位十六进制 = 1字节）
    byte3 = inst_hex[0:2]  # 最高字节
    byte2 = inst_hex[2:4]
    byte1 = inst_hex[4:6]
    byte0 = inst_hex[6:8]  # 最低字节
    
    # RISC-V 小端序：低字节在前
    return [byte0, byte1, byte2, byte3]

def generate_hex_file(instructions_text, output_path):
    """
    生成 Chisel BRAM 初始化文件
    
    Args:
        instructions_text: 指令文本（每行一条32位十六进制指令）
        output_path: 输出文件路径
    """
    # 解析指令列表
    inst_list = []
    for line in instructions_text.strip().split('\n'):
        line = line.strip()
        # 跳过空行和注释
        if line and not line.startswith('#') and not line.startswith('//'):
            inst_list.append(line)
    
    # 转换为字节序列
    byte_list = []
    for inst in inst_list:
        bytes_le = instruction_to_bytes(inst)
        byte_list.extend(bytes_le)
    
    # 写入文件（每行一个字节）
    with open(output_path, 'w') as f:
        for i, byte in enumerate(byte_list):
            f.write(f"{byte}\n")
    
    # 输出统计信息
    num_instructions = len(inst_list)
    num_bytes = len(byte_list)
    print(f"✓ 转换完成！")
    print(f"  指令数量: {num_instructions}")
    print(f"  字节数量: {num_bytes}")
    print(f"  输出文件: {output_path}")
    print(f"\n前几条指令预览:")
    for i, inst in enumerate(inst_list[:5]):
        addr = i * 4
        bytes_le = instruction_to_bytes(inst)
        print(f"  地址 0x{addr:03X}: 0x{inst} -> [{bytes_le[0]} {bytes_le[1]} {bytes_le[2]} {bytes_le[3]}]")
    if num_instructions > 5:
        print(f"  ... (共 {num_instructions} 条指令)")

# ============ 主程序 ============

if __name__ == "__main__":
    # 切换到脚本所在目录
    script_dir = os.path.dirname(os.path.abspath(__file__))
    os.chdir(script_dir)
    
    # 生成 hex 文件到当前目录
    generate_hex_file(instructions, output_file)
    
    # 复制到 Chisel main 资源目录
    chisel_main_resource_dir = "../chisel/src/main/resources/init_data"
    if not os.path.exists(chisel_main_resource_dir):
        os.makedirs(chisel_main_resource_dir)
    chisel_main_output = os.path.join(chisel_main_resource_dir, output_file)
    generate_hex_file(instructions, chisel_main_output)
    print(f"\n✓ 已同步到 Chisel main 资源目录: {chisel_main_output}")
    
    # 复制到 Chisel test 资源目录
    chisel_test_resource_dir = "../chisel/src/test/resources/init_data"
    if not os.path.exists(chisel_test_resource_dir):
        os.makedirs(chisel_test_resource_dir)
    chisel_test_output = os.path.join(chisel_test_resource_dir, output_file)
    generate_hex_file(instructions, chisel_test_output)
    print(f"✓ 已同步到 Chisel test 资源目录: {chisel_test_output}")