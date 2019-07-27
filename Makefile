TARGET=tst
#CPPFLAGS=-DHAVE_ARGON2_H -DENABLE_AF_ALG
CPPFLAGS=-DUSE_INTERNAL_ARGON2 -DENABLE_AF_ALG -DGCRYPT_REQ_VERSION=\"1.8.0\" -DHAVE_DECL_GCRY_CIPHER_MODE_XTS
CFLAGS=-O3 -march=native -g -Wall
#LDLIBS=-lcrypto -lssl -largon2
LDLIBS=-lgcrypt -lpthread

SOURCES=$(wildcard *.c argon2/*.c argon2/blake2/*.c)
OBJECTS=$(SOURCES:.c=.o)

all: $(TARGET)

$(TARGET): $(OBJECTS)
	$(CC) -o $@ $^ $(LDLIBS)

clean:
	rm -f *.o argon2/*.o argon2/blake2/*.o *~ core $(TARGET)

.PHONY: clean
