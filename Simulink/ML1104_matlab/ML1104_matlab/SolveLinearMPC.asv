%%%%%%%%%%%%%%%%%%%%%%%%%%
function control = SolveLinearMPC(A_k, B_k, C_k, q, r, lower, upper, x0, refs, N_p)

    % 預測steps是N_p
% %     x0=3;
% %     N_p=10;
% %     A_k=10;
% %     B_k=30;
% %     C_k=10;
% %     q=1;r=10;
% %     lower=-16;
% %     upper=16;
% %     refs=0;
    % 設置狀態量是Xn
    Xn = length(x0);
    % refs的維度是[N_p*Xn, 1]
    
    % 求矩陣k
    k = cell(N_p, N_p);
    
    for i = 1:N_p
        for j = 1:N_p
            if i < j
                k{i, j} = B_k*0;
            else
                k{i, j} = A_k^(i-j)*B_k;
            end
        end
    end
    
%     THETA2 = zeros(3*N_p, N_p);
%     for i = 1:N_p
%         t = 1;
%         for j = 1:N_p
%             for l = 1:3
%                 THETA2(t, i) = k{j, i}(l);
%                 t = t + 1;
%             end
%         end
%     end

    THETA = cell2mat(k);  % 將原包數組轉換為基礎數據類型的普通數列
    
    % 求矩陣的M
    m = A_k*x0 + C_k;
    M = cell(N_p,1);
    
    for i = 1 : N_p
        M{i} = m;
        m = A_k * m + C_k;
    end
    
%     M2 = zeros(3*N_p, 1);
%     t = 1;
%     for i = 1 : N_p
%         for j = 1 : 3
%             M2(t, 1) = M{i, 1}(j);
%             t = t + 1;
%         end
%     end

    M = cell2mat(M);
    
    % Q,R
    Q = [];
    R = [];
    
    for i = 1:N_p
        Q = blkdiag(Q, q);  % 從三個大小不同的矩陣創立一個對角矩陣
        R = blkdiag(R, r);  % 同上
    end
    
    Sq = size(q);
    Sr = Sq(1)*N_p;
    Sc = Sq(2)*N_p;
    Q2 = zeros(Sr, Sc);
    for i = 1:Sr
        for j = 1:Sc
            

    ll = repmat(lower, N_p, 1);  % 建立一個所有元素的值均為 10 的 3×2 矩陣。A = repmat(10,3,2)
    uu = repmat(upper, N_p, 1);
    
    H = 2 * ((THETA.')*Q*THETA + R);
    f = (THETA.')*Q*(M-refs);
    
    [control,~,~,~,~] = quadprog(H, f, [],[],[],[],ll, uu);
end