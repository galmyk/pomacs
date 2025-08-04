FC := gfortran

APP := pom2k

FFLAGS  := -std=legacy -O0 -g -I. -I/usr/include -lnetcdff

.PHONY: all
all: $(APP)

.PHONY: run
run: $(APP)
	./$< | tee pom2k.out

$(APP): src/pom2k.f src/pom2k.c src/pom2k.n grid params fort.40
	$(FC) $(FFLAGS) $< -o $@

grid:
	echo "      parameter(IM=41, JM=61, KB=16)" > $@

params:
	echo "      IPROBLEM =  3"     > $@
	echo "      days     =  0.50" >> $@
	echo "      prtd1    =  0.25" >> $@
	echo "      dte      = 12.0"  >> $@

fort.40: IC.dat
	cp $< $@

.PHONY: clean
clean:
	rm -f $(APP) grid params fort.* pom2k.out
