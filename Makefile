v_files := $(wildcard ./rtl/*.v)
VERILATOR_FLAGS ?= -Wall -Wno-fatal



# Chisel 测试相关命令
test:
	sbt test
.PHONY: test

# 运行特定测试
# 使用: make test-only TEST=scpu.alu_test
test-only:
	@if [ -z "$(TEST)" ]; then \
		echo "Usage: make test-only TEST=<test_class_name>"; \
		echo "Example: make test-only TEST=scpu.alu_test"; \
		exit 1; \
	fi; \
	sbt "testOnly $(TEST)"
.PHONY: test-only

# 生成波形的测试
# 使用: make test-wave TEST=scpu.alu_test
test-wave:
	@if [ -z "$(TEST)" ]; then \
		echo "Usage: make test-wave TEST=<test_class_name>"; \
		echo "Example: make test-wave TEST=scpu.alu_test"; \
		exit 1; \
	fi; \
	sbt "testOnly $(TEST) -- -DwriteVcd=1"
.PHONY: test-wave

# 查看最新波形
view-wave:
	@./view_wave.sh
.PHONY: view-wave

# 运行测试并自动打开波形
# 使用: make test-and-view TEST=scpu.alu_test
test-and-view:
	@if [ -z "$(TEST)" ]; then \
		echo "Usage: make test-and-view TEST=<test_class_name>"; \
		echo "Example: make test-and-view TEST=scpu.alu_test"; \
		exit 1; \
	fi; \
	sbt "testOnly $(TEST)" && ./view_wave.sh
.PHONY: test-and-view

# 清理波形文件
clean-wave:
	rm -rf test_run_dir
.PHONY: clean-wave

# 清理所有生成的文件
clean-all: clean-wave
	rm -rf target chisel/target generated obj
.PHONY: clean-all
