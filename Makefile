FC := gfortran

APP := pom2k

FFLAGS  := -std=legacy -O0 -g -I. -I/usr/include -lnetcdff

.PHONY: all
all: $(APP)

.PHONY: run
run: $(APP)
	./$< | tee pom2k.out

$(APP): src/pom2k.f src/pom2k.c src/pom2k.n grid params
	$(FC) $(FFLAGS) $< -o $@

grid:
	echo "      parameter(IM=65, JM=49, KB=21)" > $@

params:
	echo "      IPROBLEM = 1"       > $@
	echo "      days     = 0.025"  >> $@
	echo "      prtd1    = 0.0125" >> $@
	echo "      dte      = 6.0"    >> $@

.PHONY: clean
clean:
	rm -f $(APP) grid params fort.* pom2k.out
