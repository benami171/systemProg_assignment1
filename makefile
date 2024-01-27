CC = gcc
AR = ar
CFLAGS = -Wall -g
LDFLAGS = -Wall -g
LIBS = -lm -fPIC

# Source files
MAIN_SOURCE = main.c
BASIC_CLASS_SOURCE = basicClassification.c
LOOP_CLASS_SOURCE = advancedClassificationLoop.c
RECURSION_CLASS_SOURCE = advancedClassificationRecursion.c

# Header file
HEADER = NumClass.h

# Object files
MAIN_OBJECT = $(MAIN_SOURCE:.c=.o)
BASIC_CLASS_OBJECT = $(BASIC_CLASS_SOURCE:.c=.o)
LOOP_CLASS_OBJECT = $(LOOP_CLASS_SOURCE:.c=.o)
RECURSION_CLASS_OBJECT = $(RECURSION_CLASS_SOURCE:.c=.o)

# Libraries
LOOP_LIB = libclassloops.a
RECURSION_LIB = libclassrec.a
LOOP_SHARED_LIB = libclassloops.so
RECURSION_SHARED_LIB = libclassrec.so

# Executables
MAIN_STATIC = mains
MAIN_DYNAMIC_LOOP = maindloop
MAIN_DYNAMIC_RECURSION = maindrec

.PHONY:clean all

all: loops recursives recursived loopd mains maindloop maindrec


loops: $(LOOP_LIB)

$(LOOP_LIB): $(BASIC_CLASS_OBJECT) $(LOOP_CLASS_OBJECT)
	$(AR) -rcs $(LOOP_LIB) $(BASIC_CLASS_OBJECT) $(LOOP_CLASS_OBJECT)


recursives: $(RECURSION_LIB)

$(RECURSION_LIB): $(RECURSION_CLASS_OBJECT) $(BASIC_CLASS_OBJECT)
	$(AR) -rcs $(RECURSION_LIB) $(RECURSION_CLASS_OBJECT) $(BASIC_CLASS_OBJECT)

loopd: $(LOOP_SHARED_LIB)

$(LOOP_SHARED_LIB): $(LOOP_CLASS_OBJECT) $(BASIC_CLASS_OBJECT)
	$(CC) -shared -o $(LOOP_SHARED_LIB) $(LOOP_CLASS_OBJECT) $(BASIC_CLASS_OBJECT) $(LIBS)

recursived: $(RECURSION_SHARED_LIB)

$(RECURSION_SHARED_LIB): $(RECURSION_CLASS_OBJECT) $(BASIC_CLASS_OBJECT)
	$(CC) -shared -o $(RECURSION_SHARED_LIB) $(RECURSION_CLASS_OBJECT) $(BASIC_CLASS_OBJECT) $(LIBS)

mains: $(MAIN_OBJECT) $(RECURSION_LIB)
	$(CC) $(LDFLAGS) -o mains $(MAIN_OBJECT) $(RECURSION_LIB)

maindloop: $(MAIN_OBJECT) loopd
	$(CC) $(LDFLAGS) -o maindloop $(MAIN_OBJECT) -L. -lclassloops

maindrec: $(MAIN_OBJECT) $(RECURSION_SHARED_LIB)
	$(CC) $(LDFLAGS) -o maindrec $(MAIN_OBJECT) -L. -lclassrec

clean:
	rm -f *.o *.a *.so mains maindloop maindrec
