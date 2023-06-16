.POSIX:
.SUFFIXES:

FC      = gfortran
FFLAGS  = -O3 -ffast-math
AR      = ar
ARFLAGS = rcs
TARGET  = liblucifer.a
OBJ     = lucifer.o
TEST    = luctest

.PHONY: all clean test

all: $(TARGET)
test: $(TEST)

$(TARGET):
	$(FC) $(FFLAGS) -c src/lucifer.f
	$(AR) $(ARFLAGS) $(TARGET) $(OBJ)

$(TEST): $(TARGET)
	$(FC) $(FFLAGS) -o $(TEST) test/luctest.f $(TARGET)

clean:
	if [ `ls -1 *.o 2>/dev/null | wc -l` -gt 0 ]; then rm *.o; fi
	if [ -e $(TARGET) ]; then rm $(TARGET); fi
	if [ -e $(TEST) ]; then rm $(TEST); fi
