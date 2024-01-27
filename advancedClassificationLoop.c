#include "NumClass.h"
#define TRUE 1 
#define FALSE 0


int power(int n, int p){
    if(p == 0){ return 1;}
         return n*power(n,p-1);
     }

int isPalindrome(int n){
    int currNum = n;
    int currFig = n;
    int counter = 0;
    int modNum = 0;
    modNum = currNum%10;
    while(currNum > 10){

    while (currFig > 0){
     currFig = currFig/10;
     counter++;
    }

    if  (modNum != currFig) return FALSE;
    currNum = currNum - (power(10,counter)*currFig);
    currNum /= 10;
    }

    return TRUE;
}

int isArmstrong(int n){
    if (n < 10) return TRUE;
    int numOfDigits = 0;
    int ogNum = n;
    int ogNum2 = n;
    int modNum = 0;
    while(ogNum > 0){
        ogNum /= 10;
        numOfDigits++;
    }

    int sum = 0;
    while( ogNum2 > 0){
        modNum = ogNum2 % 10;
        sum = sum + power(modNum,numOfDigits);
        ogNum2 /= 10;
    }
    return (sum == n);
}






