#include <stdio.h>
#include <stdlib.h>

int m;
int n;
int k;


int tm;
int tn;
int tk;

int arr_A[m][n];
int arr_B[n][k];

int number_m_A = (m/tm)*(n/tn);
int number_m_B = (n/tn)*(k/tk);

int arr_A_block = [number_m_A][tm][tn];
int arr_B_block = [number_m_B][tn][tk];

void IP()
{
    if(m % tm == 0 && n % tn == 0)
    {
        for(int i = 0; i < number_m_A; i++)
        {
            for(int j = 0; j < number_m_A; j++)
            {
                for(int k = 0; k < m; j++)
                {
                    for(int l = 0; l < n ; k++)
                    {
                        int x = i*k + k;
                        int y = j*l + l;
                        arr_A_block[i][j][k][l] = arr_A[x][y];
                        printf("%d ",arr_A_block[i][j][k][l]);
                    }
                }
                printf("\n");
            }
        }
    }
}



int main()
{

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

    for(int i = 0; i < m; i ++)
    {
        for(int j = 0; j < n; j ++)
        {
            arr_A[i][j] = rand();
        }
    }

    for(int i = 0; i < n; i ++)
    {
        for(int j = 0; j < k; j ++)
        {
            arr_B[i][j] = rand();
        }
    }

     int arr_A_block[][][];

    IP(arr_A,m,n,tm,tn);

}
