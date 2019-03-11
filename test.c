#include <stdio.h>
#include <sys/mman.h>
#include "crypto_backend.h"

static int benchmark_callback(uint32_t time_ms, void *usrptr)
{
	printf("*");
	fflush(stdout);
	return 0;
}

int main (int argc, char *argv[])
{
	uint32_t iter, mem;
	int r;

	if (crypt_backend_init(NULL)) {
		printf("Cannot initialise crypto backend.\n");
		return 1;
	}

	if (mlockall(MCL_CURRENT | MCL_FUTURE) == -1)
		printf("Cannot lock memory with mlockall.\n");

	printf("# Backend: %s\n", crypt_backend_version());

	r = crypt_pbkdf_perf("argon2i", NULL, "test", 4,
		"\x00\x01\x02\x03\x04\x05\x06\x07\x08\x09\x0a\x0b\x0c\x0d\x0e\x0f", 16,
		32, 10000, 1024 *1024, 4, &iter, &mem, &benchmark_callback, NULL);

	if (!r)
		printf("\nBenchmark %u iterations, %u memory.\n", iter, mem);

	if (munlockall() == -1)
		printf("Cannot unlock memory with munlockall.\n");

	return 0;
}
