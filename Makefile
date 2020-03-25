PLAT = _LINUX
MKLROOT = /opt/intel/mkl

CC        = gcc
CFLAGS    = -O3 -ansi -D_SVID_SOURCE# /DMKL_ILP64 -m64 -I${MKLROOT}/include
#BLASLIB   = ./CLAPACK/lsblaspii1.2f_03.00.a
#BLASLIB   = /usr/lib/libblas/libblas.a
#LAPACKLIB = /usr/lib/lapack/liblapack.a
OPENMPLIB = -L/opt/intel/compilers_and_libraries/linux/lib/intel64/
LAPACKLIB = -L${MKLROOT}/lib/intel64 -Wl,--no-as-needed -lmkl_intel_ilp64 -lmkl_intel_thread -lmkl_core -liomp5 -lpthread -lm -ldl
BLASLIB = -L${MKLROOT}/lib/intel64 -Wl,--no-as-needed -lmkl_intel_ilp64 -lmkl_intel_thread -lmkl_core -liomp5 -lpthread -lm -ldl
F2CLIB    = /usr/lib/x86_64-linux-gnu/libgfortran.so.3
LIBS      = $(OPENMPLIB) $(LAPACKLIB) $(BLASLIB) $(F2CLIB) -lm
OBJS      = ica.o interfc.o r250.o randlcg.o dsum.o #memap.o

ica_linux: Makefile.linux ica.h memap.h $(OBJS)
	$(CC) -o ica_linux $(OBJS) $(LIBS)

ica.o: Makefile.linux ica.h memap.h ica.c
	$(CC) -c ica.c $(CFLAGS)

interfc.o: Makefile.linux ica.h memap.h interfc.c
	$(CC) -c interfc.c $(CFLAGS)

memap.o: Makefile.linux memap.h memap.c
	$(CC) -c memap.c $(CFLAGS)

r250.o: Makefile.linux r250.h r250.c
	$(CC) -c r250.c $(CFLAGS)

randlcg.o: Makefile.linux randlcg.h randlcg.c
	$(CC) -c randlcg.c $(CFLAGS)

dsum.o: Makefile.linux dsum.c
	$(CC) -c dsum.c $(CFLAGS)

clean:
	rm -f *.o
