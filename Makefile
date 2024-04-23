TARGET=tst

CPPFLAGS=-DENABLE_AF_ALG -DDEFAULT_VERITY_HASH=\"sha256\" -DDEFAULT_PLAIN_HASH=\"sha256\" -DDEFAULT_LUKS1_HASH=\"sha256\"
CFLAGS=-O3 -march=native -g -Wall
LDLIBS=

SOURCES=argon2_generic.c base64.c cipher_check.c cipher_generic.c \
crc32.c crypto_cipher_kernel.c crypto_storage.c crypto-vectors.c \
pbkdf_check.c utf8.c \
$(wildcard argon2/*.c argon2/blake2/*.c)

# select which crypto-library backend to use
include Makefile.openssl
#include Makefile.gcrypt
#include Makefile.nettle
#include Makefile.nss
#include Makefile.kernel

CPPFLAGS+=$(CPPFLAGS_BACKEND)
CFLAGS+=$(CFLAGS_BACKEND)
LDLIBS+=$(LDLIBS_BACKEND)
SOURCES+=$(SOURCES_BACKEND)

all: $(TARGET)

$(TARGET): $(SOURCES:.c=.o)
	$(CC) -o $@ $^ $(LDLIBS)

clean:
	rm -f *.o argon2/*.o argon2/blake2/*.o *~ core $(TARGET)

.PHONY: clean
