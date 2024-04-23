CPPFLAGS_BACKEND=-DUSE_INTERNAL_ARGON2 -DHAVE_DECL_NSS_GETVERSION
CFLAGS_BACKEND=-I/usr/include/nss -I/usr/include/nspr
LDLIBS_BACKEND=-lnss3 -lnssutil3 -lpthread
SOURCES_BACKEND=crypto_nss.c pbkdf2_generic.c
