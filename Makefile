BIN_FILES  =  practica

#cambiar el PATH
INSTALL_PATH = $(HOME)/simgrid-4.1

CC = gcc

CPPFLAGS = -I$(INSTALL_PATH)/include -I/usr/local/include/ -g -Wall


NO_PRAYER_FOR_THE_WICKED =	-w -O3 -g   


LDFLAGS = -L$(INSTALL_PATH)/lib/
LDLIBS = -lm -lsimgrid -rdynamic $(INSTALL_PATH)/lib/libsimgrid.so -Wl,-rpath,$(INSTALL_PATH)/lib


all: CFLAGS=$(NO_PRAYER_FOR_THE_WICKED)
all: $(BIN_FILES)
.PHONY : all

practica: practica.o  rand.o
	$(CC) $(LDFLAGS) $^ $(LDLIBS) -o $@

%.o: %.c
	$(CC) $(CPPFLAGS) $(CFLAGS) -c $<

clean:
	rm -f $(BIN_FILES) *.o

.SUFFIXES:
.PHONY : clean
