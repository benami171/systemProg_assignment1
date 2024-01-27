CC = gcc
AR = ar
FLAGS = -Wall -g
HEADER = NumClass.h

MAIN_SOURCE = main.c
BASIC_CLASS_SOURCE = basicClassification.c
LOOP_CLASS_SOURCE = advancedClassificationLoop.c
RECURSION_CLASS_SOURCE = advancedClassificationRecursion.c

MAIN_OBJECT = $(MAIN_SOURCE:.c=.o)
BASIC_CLASS_OBJECT = $(BASIC_CLASS_SOURCE:.c=.o)
LOOP_CLASS_OBJECT = $(LOOP_CLASS_SOURCE:.c=.o)
RECURSION_CLASS_OBJECT = $(RECURSION_CLASS_SOURCE:.c=.o)

LOOP_LIB = libclassloops.a
RECURSION_LIB = libclassrec.a
LOOP_SHARED_LIB = libclassloops.so
RECURSION_SHARED_LIB = libclassrec.so

MAIN_STATIC = mains
MAIN_DYNAMIC_LOOP = maindloop
MAIN_DYNAMIC_RECURSION = maindrec

.PHONY:clean all

all: loops recursives recursived loopd mains maindloop maindrec


loops: libclassloops.a

libclassloops.a: $(BASIC_CLASS_OBJECT) $(LOOP_CLASS_OBJECT)
	$(AR) -rcs libclassloops.a $(BASIC_CLASS_OBJECT) $(LOOP_CLASS_OBJECT)


recursives: libclassrec.a

libclassrec.a: $(RECURSION_CLASS_OBJECT) $(BASIC_CLASS_OBJECT)
	$(AR) -rcs libclassrec.a $(RECURSION_CLASS_OBJECT) $(BASIC_CLASS_OBJECT)

recursived: libclassrec.so

libclassrec.so: $(RECURSION_CLASS_OBJECT) $(BASIC_CLASS_OBJECT)
	$(CC) -shared -o libclassrec.so $(RECURSION_CLASS_OBJECT) $(BASIC_CLASS_OBJECT)

loopd: libclassloops.so

libclassloops.so: $(LOOP_CLASS_OBJECT) $(BASIC_CLASS_OBJECT)
	$(CC) -shared -o libclassloops.so $(LOOP_CLASS_OBJECT) $(BASIC_CLASS_OBJECT)


mains: $(MAIN_OBJECT) libclassrec.a
	$(CC) $(FLAGS) -o mains $(MAIN_OBJECT) libclassrec.a

maindloop: $(MAIN_OBJECT) loopd
	$(CC) $(FLAGS) -o maindloop $(MAIN_OBJECT) ./libclassloop.so

maindrec: $(MAIN_OBJECT) 
	$(CC) $(FLAGS) -o maindrec $(MAIN_OBJECT) ./libclassrec.so

main.o: main.c NumClass.h
	$(CC) $(FLAGS) -c main.c

basicClassification.o: basicClassification.c NumClass.h
	$(CC) $(FLAGS) -fPIC -c basicClassification.c

advancedClassificationLoop.o: advancedClassificationLoop.c NumClass.h
	$(CC) $(FLAGS) -fPIC -c advancedClassificationLoop.c

advancedClassificationRecursion.o: advancedClassificationRecursion.c NumClass.h
	$(CC) $(FLAGS) -fPIC -c advancedClassificationRecursion.c


clean:
	rm -f *.o *.a *.so mains maindloop maindrec
