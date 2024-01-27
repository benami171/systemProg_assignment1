#include "NumClass.h"
#define TRUE 1
#define FALSE 0

int factorial(int n){
    if ( n==0|| n==1){
        return 1;
    } else {
        return n*factorial(n-1);
    }
}


int isStrong(int n){
    int ogNumber = n;
    int sum = 0;
    while (n > 0){
        int digit = n % 10;
        sum += factorial(digit);
        n = n/10;

    }

    return (sum == ogNumber);
}


int isPrime(int number){
    if(number == 1){return TRUE;}
    for (int i = 2; i*i <= number; i++)
    {
        if(number % i == 0 && i != number){
            return FALSE;
        }
    }
    return TRUE;
}
