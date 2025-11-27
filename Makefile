v_files := $(wildcard ./rtl/*.v)
VERILATOR_FLAGS ?= -Wall -Wno-fatal

all: check

check:
	@for v in $(v_files); do \
		base=$$(basename $$v .v); \
		verilator $(VERILATOR_FLAGS) --cc $$v -Mdir $(obj_dir)/$$base -lint-only; \
		if [ $$? -ne 0 ]; then \
			echo "Linting failed for $$v"; \
			exit 1; \
		else \
			echo "Linting passed for $$v"; \
		fi; \
	done
.PHONY: check all

# Check a specific file: make check-file FILE=<name> (e.g., make check-file FILE=ALU)
check-file:
	@if [ -z "$(FILE)" ]; then \
		echo "Usage: make check-file FILE=<filename> (without .v extension)"; \
		exit 1; \
	fi; \
	if [ ! -f "./rtl/$(FILE).v" ]; then \
		echo "File ./rtl/$(FILE).v not found"; \
		exit 1; \
	fi; \
	verilator $(VERILATOR_FLAGS) --cc ./rtl/$(FILE).v -Mdir obj/$(FILE) -lint-only; \
	if [ $$? -ne 0 ]; then \
		echo "Linting failed for $(FILE).v"; \
		exit 1; \
	else \
		echo "Linting passed for $(FILE).v"; \
	fi
.PHONY: check-file

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
