clc;
clear all; close all;
for L = 2:10
    for f1 = 0:2^L
        for f2 = 0:2^L
            for f3 = 0:2^L
                for f4 = 0:2^L
                    if()
                end
            end
        end
    end

end

%%
function b=cor(f1,f2) %計算correaltion值
if (length(f1) ~= length(f2))
    return;
else    
    b=[];
    for i=0:length(f1)-1
        a=0;
        for j=i+1:length(f2)
            if f1(j)==f2(j-i)
                a=a+1;
            else
                a=a-1;
            end
        end
        b=[b,a];
    end
end
end

function c=tcor(f) %判斷用correaltion值
    b=[];
    for i=0:10
        a=0;
        for j=i+1:length(f)
            if f(j)==f(j-i)
                a=a+1;
            else
                a=a-1;
            end
        end
        b=[b,a];
    end
    c=b(2:11);
end

function f_out=d2b(num,f_in) %十進位轉二進位矩陣
    L=strlength(dec2bin(num));
    a=dec2bin(num);
    for i=1:L
        b=a(1,i);
        c=eval(b);
        f_in(length(f_in)-i+1)=c;
    end
    f_out=f_in;   
end