# Compiler and simulator
IVERILOG = iverilog
VVP = vvp
GTKWAVE = gtkwave

# Flags
IVERILOG_FLAGS = -g2012 -Wall

# Source files - MATCHING YOUR ACTUAL FILES
SRC = 	PC.v \
	instruction_memory.v \
	adder4.v \
	control_unit.v \
	alu_control.v \
	alu.v \
	reg_file.v \
	imm_gen.v \
	data_memory.v \
	alu_src_mux.v \
	writeback_mux.v \
	pc_mux.v \
	branch_adder.v \
	branch_and.v \
	processor.v \
	testbench.v

# Output files
OUTPUT = riscv_sim.vvp
WAVEFORM = waveform.vcd

# Target to compile all files
all: compile run view

# Compile
compile: $(SRC)
	@echo "Compiling RISC-V processor..."
	$(IVERILOG) $(IVERILOG_FLAGS) -o $(OUTPUT) $(SRC)
	@echo "Compilation successful!"

# Run simulation
run: $(OUTPUT)
	@echo "Running simulation..."
	$(VVP) $(OUTPUT)
	@echo "Simulation complete!"

# View waveform
view:
	@if [ -f $(WAVEFORM) ]; then \
		$(GTKWAVE) $(WAVEFORM); \
	else \
		echo "Waveform file not found. Run 'make run' first."; \
		exit 1; \
	fi

# Clean generated files
clean:
	rm -f $(OUTPUT) $(WAVEFORM)
	@echo "Cleaned!"

# Compile and run only
sim: compile run

# Compile with specific test
test-%: $(SRC)
	$(IVERILOG) $(IVERILOG_FLAGS) -DTEST=$* -o $(OUTPUT) $(SRC)
	$(VVP) $(OUTPUT)
	$(GTKWAVE) $(WAVEFORM)

# Check what files are present
check:
	@echo "Checking required files..."
	@for f in $(SRC); do \
		if [ -f $$f ]; then \
			echo "  ✓ $$f"; \
		else \
			echo "  ✗ $$f (MISSING)"; \
		fi \
	done

.PHONY: all compile run view clean sim check