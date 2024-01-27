#include "NumClass.h"
#define TRUE 1 
#define FALSE 0
int power(int n, int p){
    if(p == 0){ return 1;}
         return n*power(n,p-1);
     }


int isPalindrome(int n){
    if(n==reverse(n)){return TRUE;}
    return FALSE;
}

int reverse(int num){

    int reversedNum = 0;

    while (num > 0) {
        reversedNum = reversedNum * 10 + num % 10;
        num /= 10;
    }

    return reversedNum;
} 

int isArmstrong(int n){ 
    int counter = 0;
    int currFig = n;

    while (currFig > 0){
     currFig = currFig/10;
     counter++;
    }
    int ans = isArmstrongHelper(n,counter);
    if (ans != n) return FALSE;
    return TRUE;
}

int isArmstrongHelper(int n, int numOfDigits){
    if (n == 0) {return n;
    } 
    return (isArmstrongHelper(n/10,numOfDigits) + power(n%10,numOfDigits));
}




