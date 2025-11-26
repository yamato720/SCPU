# Makefile 多项目管理教程

本文档详细介绍如何使用Makefile管理多个Chisel项目（以2-4译码器和3-8译码器为例）。

## 项目结构

```
ysyx/
├── Makefile                    # 项目构建文件
├── build.sbt                   # SBT配置
├── decoder2to4/
│   ├── generated/              # 2-4译码器生成的Verilog
│   │   ├── Decoder2to4.v
│   │   ├── Decoder2to4.fir
│   │   └── Decoder2to4.anno.json
│   └── README.md
├── decoder3to8/
│   ├── generated/              # 3-8译码器生成的Verilog
│   │   ├── Decoder3to8.v
│   │   ├── Decoder3to8.fir
│   │   └── Decoder3to8.anno.json
│   └── README.md
└── src/
    ├── main/scala/
    │   ├── decoder2to4/
    │   │   ├── Decoder2to4.scala
    │   │   └── Elaborate.scala
    │   └── decoder3to8/
    │       ├── Decoder3to8.scala
    │       └── Elaborate.scala
    └── test/scala/
        ├── decoder2to4/
        │   └── Decoder2to4Test.scala
        └── decoder3to8/
            └── Decoder3to8Test.scala
```

## Makefile 结构解析

### 1. 基本配置

```makefile
# 默认目标：显示帮助信息
.DEFAULT_GOAL := help

# 所有项目列表（方便扩展）
PROJECTS := decoder2to4 decoder3to8
```

**说明：**
- `.DEFAULT_GOAL := help`：直接运行`make`时显示帮助信息
- `PROJECTS`变量：统一管理所有项目，添加新项目只需修改这一行

### 2. 单个项目构建规则

```makefile
# 2-4译码器
decoder2to4:
	@echo "==> 构建 2-4 译码器..."
	sbt "runMain decoder2to4.Elaborate"
	@echo "✓ Verilog 文件已生成到: decoder2to4/generated/Decoder2to4.v"

# 3-8译码器
decoder3to8:
	@echo "==> 构建 3-8 译码器..."
	sbt "runMain decoder3to8.Elaborate"
	@echo "✓ Verilog 文件已生成到: decoder3to8/generated/Decoder3to8.v"
```

**说明：**
- `@echo`：`@`符号隐藏命令本身，只显示输出结果
- `sbt "runMain package.Elaborate"`：运行指定的主程序生成Verilog

### 3. 测试规则

```makefile
# 测试单个项目
test-decoder2to4:
	@echo "==> 测试 2-4 译码器..."
	sbt "testOnly decoder2to4.Decoder2to4Test"

# 测试所有项目
test-all:
	@echo "==> 测试所有译码器..."
	sbt test
```

### 4. 批量操作

```makefile
# 构建所有项目
all: $(PROJECTS)
	@echo "✓ 所有项目构建完成！"
```

**说明：**
- `all: $(PROJECTS)`：依赖于PROJECTS变量中的所有目标
- 自动按顺序构建所有项目

### 5. 清理规则

```makefile
# 清理所有生成的Verilog文件（使用循环）
clean-generated:
	@echo "==> 清理所有生成的 Verilog 文件..."
	@for proj in $(PROJECTS); do \
		rm -rf $$proj/generated/*; \
		echo "  ✓ 已清理 $$proj/generated/"; \
	done
```

**说明：**
- 使用`for`循环遍历所有项目
- `$$proj`：Makefile中使用`$$`表示shell变量

### 6. PHONY声明

```makefile
.PHONY: $(PROJECTS) test-decoder2to4 test-decoder3to8 test-all all compile \
        clean-decoder2to4 clean-decoder3to8 clean-generated clean-all \
        show-decoder2to4 show-decoder3to8 list help
```

**说明：**
- `.PHONY`：声明这些目标不是文件，而是伪目标
- 即使存在同名文件，make也会执行这些目标

## 常用命令速查

### 构建命令

```bash
# 查看帮助（默认命令）
make
make help

# 构建单个项目
make decoder2to4          # 生成2-4译码器
make decoder3to8          # 生成3-8译码器

# 构建所有项目
make all

# 编译所有Scala代码（不生成Verilog）
make compile
```

### 测试命令

```bash
# 测试单个项目
make test-decoder2to4
make test-decoder3to8

# 测试所有项目
make test-all
```

### 清理命令

```bash
# 清理单个项目的生成文件
make clean-decoder2to4
make clean-decoder3to8

# 清理所有生成的Verilog文件
make clean-generated

# 清理所有编译产物（包括SBT缓存）
make clean-all
```

### 查看命令

```bash
# 查看生成的Verilog代码
make show-decoder2to4
make show-decoder3to8

# 列出所有生成的文件
make list
```

## 实战示例

### 示例1：从零开始构建项目

```bash
# 1. 编译所有Scala代码
make compile

# 2. 运行测试确保代码正确
make test-all

# 3. 生成所有Verilog文件
make all

# 4. 查看生成的文件
make list
```

### 示例2：开发单个模块

```bash
# 1. 构建2-4译码器
make decoder2to4

# 2. 查看生成的Verilog
make show-decoder2to4

# 3. 测试功能
make test-decoder2to4
```

### 示例3：清理并重新构建

```bash
# 完整的清理和重新构建流程
make clean-all && make compile && make all
```

## 如何添加新项目

假设要添加一个4-16译码器（decoder4to16），按以下步骤操作：

### Step 1: 更新PROJECTS变量

```makefile
PROJECTS := decoder2to4 decoder3to8 decoder4to16
```

### Step 2: 添加构建规则

```makefile
# 4-16译码器
decoder4to16:
	@echo "==> 构建 4-16 译码器..."
	sbt "runMain decoder4to16.Elaborate"
	@echo "✓ Verilog 文件已生成到: decoder4to16/generated/Decoder4to16.v"
```

### Step 3: 添加测试规则

```makefile
# 测试4-16译码器
test-decoder4to16:
	@echo "==> 测试 4-16 译码器..."
	sbt "testOnly decoder4to16.Decoder4to16Test"
```

### Step 4: 添加清理规则

```makefile
# 清理4-16译码器生成的文件
clean-decoder4to16:
	@echo "==> 清理 decoder4to16 生成文件..."
	rm -rf decoder4to16/generated/*
```

### Step 5: 添加查看规则

```makefile
show-decoder4to16:
	@echo "==> decoder4to16/generated/Decoder4to16.v:"
	@cat decoder4to16/generated/Decoder4to16.v 2>/dev/null || echo "文件不存在，请先运行: make decoder4to16"
```

### Step 6: 更新.PHONY声明

```makefile
.PHONY: $(PROJECTS) test-decoder2to4 test-decoder3to8 test-decoder4to16 test-all \
        all compile clean-decoder2to4 clean-decoder3to8 clean-decoder4to16 \
        clean-generated clean-all show-decoder2to4 show-decoder3to8 \
        show-decoder4to16 list help
```

### Step 7: 更新help信息

在help目标中添加新项目的说明。

## 高级技巧

### 技巧1：并行构建（需要小心依赖）

```bash
# 使用-j参数并行构建（适用于独立的项目）
make -j4 all
```

### 技巧2：静默模式

```bash
# 只显示关键信息，隐藏详细输出
make -s decoder3to8
```

### 技巧3：调试Makefile

```bash
# 显示将要执行的命令但不执行
make -n decoder2to4

# 打印变量值
make -p | grep PROJECTS
```

### 技巧4：条件判断

可以在Makefile中添加条件判断：

```makefile
# 检查文件是否存在
check-decoder2to4:
	@if [ -f decoder2to4/generated/Decoder2to4.v ]; then \
		echo "✓ Decoder2to4.v 已存在"; \
	else \
		echo "✗ Decoder2to4.v 不存在，请运行: make decoder2to4"; \
	fi
```

## Makefile变量详解

### 自动变量

```makefile
example:
	@echo $@  # 目标名称（example）
	@echo $<  # 第一个依赖
	@echo $^  # 所有依赖
	@echo $?  # 比目标新的依赖
```

### 模式规则（Pattern Rules）

可以使用模式规则简化多个类似的目标：

```makefile
# 通用的清理规则（需要谨慎使用）
clean-%:
	@echo "==> 清理 $* 生成文件..."
	@rm -rf $*/generated/*
```

## 常见问题

### Q1: make命令找不到目标

**错误信息：**
```
make: *** No rule to make target 'xxx'.  Stop.
```

**解决方法：**
- 检查目标名称拼写
- 确认目标在Makefile中已定义
- 使用`make help`查看可用目标

### Q2: sbt命令执行失败

**解决方法：**
```bash
# 清理SBT缓存后重试
make clean-all
sbt clean
make compile
```

### Q3: 生成的Verilog文件为空或不正确

**解决方法：**
```bash
# 1. 运行测试检查逻辑
make test-decoder2to4

# 2. 清理重新生成
make clean-decoder2to4
make decoder2to4

# 3. 检查Scala代码
cat src/main/scala/decoder2to4/Elaborate.scala
```

## 完整Makefile模板

以下是支持多项目的完整Makefile模板：

```makefile
# Chisel 多项目 Makefile 模板

.DEFAULT_GOAL := help

# ===== 配置区域 =====
PROJECTS := project1 project2 project3

# ===== 构建规则 =====
project1:
	@echo "==> 构建 project1..."
	sbt "runMain project1.Elaborate"

project2:
	@echo "==> 构建 project2..."
	sbt "runMain project2.Elaborate"

# ===== 批量操作 =====
all: $(PROJECTS)
	@echo "✓ 所有项目构建完成！"

compile:
	sbt compile

# ===== 清理 =====
clean-generated:
	@for proj in $(PROJECTS); do \
		rm -rf $$proj/generated/*; \
	done

clean-all:
	sbt clean
	@for proj in $(PROJECTS); do \
		rm -rf $$proj/generated/*; \
	done

# ===== 帮助 =====
help:
	@echo "可用目标："
	@echo "  all      - 构建所有项目"
	@echo "  compile  - 编译代码"
	@echo "  clean-*  - 清理文件"

.PHONY: $(PROJECTS) all compile clean-generated clean-all help
```

## 总结

### Makefile的优势

1. **统一接口**：一个命令完成复杂操作
2. **自动化**：批量构建多个项目
3. **可维护**：集中管理构建规则
4. **可扩展**：轻松添加新项目

### 最佳实践

1. ✅ 使用`@echo`提供清晰的构建信息
2. ✅ 用变量`PROJECTS`统一管理项目列表
3. ✅ 为所有目标添加`.PHONY`声明
4. ✅ 提供详细的`help`信息
5. ✅ 使用循环处理重复性任务
6. ✅ 添加错误检查和友好提示

### 下一步

- 探索SBT的并行编译选项
- 添加自动化测试报告生成
- 集成持续集成（CI）工具
- 添加代码覆盖率检查

---

**提示：** 运行 `make` 或 `make help` 可随时查看可用命令！

