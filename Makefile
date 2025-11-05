v_files := $(wildcard ./rtl/*.v)
VERILATOR_FLAGS ?= -Wall -Wno-fatal
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
.PHONY: check

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