#include <stdio.h>
#include <stdlib.h>

int m;
int n;
int k;


int tm;
int tn;
int tk;


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


int main()
{
    /* a pointer to an int */
    int *arr_A[n];

     //input the information of the matrix 
    printf("Please insert the size of the matrix \n");
    
    printf("m\n");
    scanf("%d",&m);

    printf("n\n");
    scanf("%d",&n);

    printf("k\n");
    scanf("%d",&k);

    printf("Please insert the block size of the matrix \n");
    
    printf("tm\n");
    scanf("%d",&tm);

    printf("tn\n");
    scanf("%d",&tn);

    printf("tk\n");
    scanf("%d",&tk);

    int number_A = (n/tn)*(m/tm);
    int number_b = (n/tn)*(m/tm);

  
    arr_A = IP_A();
    for(int i = 0; i < m;i ++)
    {
        for(int j = 0 ;j < n; j++)
        {
            printf("%d,%p",*(arr_A+i*m+ j));
            printf(" ");
        }
        printf("\n");
    }
}
