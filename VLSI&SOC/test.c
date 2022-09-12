#include <stdio.h>

/* function to generate and return random numbers */
int * getRandom( ) {

   static int  r[2][2];
   int i;

   /* set the seed */
   srand( (unsigned)time( NULL ) );
  
   for ( i = 0; i < 2; ++i) {
      for(int j = 0;j < 2;j++)
      {
      	 r[i][j] = rand();
         printf( "r[%d] = %d\n", i, r[i][j]);
      }
     
   }

   return r;
}


int m = 2;
int n = 2;

int * IP_A()
{

    int arr[m][n];

    srand( (unsigned)time( NULL ) );

    for(int i = 0; i < m; i ++)
    {
        for(int j = 0; j < n; j ++)
        {
            arr[i][j] = rand();
        }
    }

        for(int i = 0; i < m; ++i)
    {
        for(int j = 0; j < n; j ++)
        {
            printf("%d address:%p ",arr[i][j]);
        }
        printf("\n");
    }
    return arr;
}
/* main function to call above defined function */
int main () {

   /* a pointer to an int */
   int *p;
   int i;

   p = getRandom();
	
   /*for ( i = 0; i < 10; i++ ) {
      printf( "*(p + %d) : %d\n", i, *(p + i));
   }*/
    for ( i = 0; i < m; i++ ) {
        for(int j = 0;j < n;j++)
      printf( "*(p + (%d,%d) : %d\n", i,j, *(p + i*10+j));
    }

   return 0;
}
 
