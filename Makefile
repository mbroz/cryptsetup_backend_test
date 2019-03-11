TARGET=tst
CPPFLAGS=-DHAVE_ARGON2_H -DENABLE_AF_ALG
CFLAGS=-O0 -g -Wall
LDLIBS=-lcrypto -lssl -largon2
#CC=gcc-Wall

SOURCES=$(wildcard *.c)
OBJECTS=$(SOURCES:.c=.o)

all: $(TARGET)

$(TARGET): $(OBJECTS)
	$(CC) -o $@ $^ $(LDLIBS)

clean:
	rm -f *.o *~ core $(TARGET)

.PHONY: clean
