v_files := $(wildcard ./rtl/*.v)
VERILATOR_FLAGS ?= -Wall -Wno-fatal
check:
	@for v in $(v_files); do \
		base=$$(basename $$v .v); \
		verilator $(VERILATOR_FLAGS) --cc $$v --exe $$c -Mdir $(obj_dir)/$$base -lint-only; \
		if [ $$? -ne 0 ]; then \
			echo "Linting failed for $$v"; \
			exit 1; \
		else \
			echo "Linting passed for $$v"; \
		fi; \
	done
.PHONY: check