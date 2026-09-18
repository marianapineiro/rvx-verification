# ==============================================================================
# Makefile for Synopsys VCS Simulation
# ==============================================================================

VCS          = vcs
VCS_FLAGS    = -full64 -sverilog +v2k -kdb -timescale=1ns/1ps -notice -debug_access+all
FILELIST     = filelist.f
SIMV         = simv_rvx

.PHONY: all prepare compile run clean

all: compile run

prepare:
	@echo "Linking test hex programs and reference signatures..."
	@ln -sf ../dut/rvx/hardware/tests/core/unit_tests/programs/*.hex .
	@ln -sf ../dut/rvx/hardware/tests/core/unit_tests/references/*.hex .

compile: prepare
	$(VCS) $(VCS_FLAGS) -f $(FILELIST) -o $(SIMV)

run: compile
	./$(SIMV)

clean:
	rm -rf simv* csrc *.daidir ucli.key *.vpd *.fsdb verdiLog novas.* *.hex *.log kdb.vc*
