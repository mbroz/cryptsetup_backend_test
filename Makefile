TARGET=tst
LIBTARGET=crypto_test

CPPFLAGS=-DENABLE_AF_ALG -DDEFAULT_VERITY_HASH=\"sha256\" -DDEFAULT_PLAIN_HASH=\"sha256\" -DDEFAULT_LUKS1_HASH=\"sha256\"
CFLAGS=-O3 -march=native -g -Wall
LDLIBS=

SOURCES=argon2_generic.c base64.c cipher_check.c cipher_generic.c \
crc32.c crypto_cipher_kernel.c crypto_storage.c pbkdf_check.c utf8.c \
memutils.c \
$(wildcard argon2/*.c argon2/blake2/*.c)

TARGET_SOURCES=crypto-vectors.c

# select which crypto-library backend to use
include Makefile.openssl
#include Makefile.gcrypt
#include Makefile.nettle
#include Makefile.nss
#include Makefile.mbedtls
#include Makefile.kernel

CPPFLAGS+=$(CPPFLAGS_BACKEND)
CFLAGS+=$(CFLAGS_BACKEND)
LDLIBS+=$(LDLIBS_BACKEND)
SOURCES+=$(SOURCES_BACKEND)

all: $(TARGET)

$(TARGET): $(TARGET_SOURCES:.c=.o) $(LIBTARGET).a
	$(CC) -o $@ $^ $(LDLIBS)

$(LIBTARGET).a: $(SOURCES:.c=.o)
	$(AR) csrD $@ $^

clean:
	rm -f *.o argon2/*.o argon2/blake2/*.o *~ core $(TARGET) $(LIBTARGET).a

.PHONY: clean
