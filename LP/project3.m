function project3()

    % Part 1
    function [Solution,BasicVar,Status] = AxEqualsb(A, b, c, BasicVariables)
        [rows, ~] = size(b);
        if (all(b >= 0) && rank(A)==rows)
            [Solution,BasicVar,Status]=basicsimplex(A,b,c,BasicVariables);
        else
            disp('b must be nonnegative and rank(A) == size of b');
        end
    end
    function [Solution,BasicVar,Status] = AxSmallerThanb(A_hat, b_hat, c_hat)
        [rows, ~] = size(b_hat);
        if (all(b_hat >= 0) && rank(A_hat)==rows)
            I = eye(rows);
            c_new = [c_hat;zeros(rows,1)];
            A_new = [A_hat I];
            [~, A_cols] = size(A_hat);
            BasicVariables = (A_cols+1):(rows+A_cols);
            [Solution,BasicVar,Status]=basicsimplex(A_new,b_hat,c_new,BasicVariables);     
        else
            disp('b_hat must be nonnegative and rank(A) == size of b_hat');
        end
    end
    function [Solution,BasicVar,Status] = AxGreaterThanb(A_tilda, b_tilda, c_tilda)
        [rows, ~] = size(b_tilda);
        if (all(b_tilda >= 0) && rank(A_tilda)==rows)
            I = eye(rows);
            A_phaseII = [A_tilda -I];
            c_phaseII = [c_tilda;zeros(rows, 1)];
            A_phaseI = [A_phaseII I];
            [~, A_cols] = size(A_tilda);
            PhaseI_BasicVariables = (A_cols+1+rows):(2*rows+A_cols);
            c_phaseI = [zeros(A_cols+rows, 1);ones(rows, 1)];
            [SolutionI,BasicVarI,StatusI]=basicsimplex(A_phaseI,b_tilda,c_phaseI,PhaseI_BasicVariables);
            if (StatusI==0)
                % Phase II
                [Solution,BasicVar,Status]=basicsimplex(A_phaseII,b_tilda,c_phaseII,BasicVarI);
            else
                Solution=SolutionI;
                BasicVar=BasicVarI;
                Status=StatusI;
            end
        else
            disp('b_tilda must be nonnegative and rank(A) == size of b_tilda');
        end
    end
    
    % Part 2 testing
    A = [[1,0,1];[0,1,1]];
    b = [1;2];
    c = [-1;-1;-3];
    
    [Solution,BasicVar,Status] = AxEqualsb(A, b, c, [1, 2])
    [Solution,BasicVar,Status] = AxSmallerThanb(A, b, c)
    [Solution,BasicVar,Status] = AxGreaterThanb(A, b, c)
    
    % Part 3 Apple stock vs Dow Jones Index
    Apple = readtable('APPL_DATA.csv');
    Apple = flipud(Apple);
    Apple = Apple(1:253,[1,4]);
    Apple = table2array(Apple(:,2));
    DowJones = readtable('Dow_Jones.csv');
    DowJones = DowJones(:,1:2);
    DowJones = table2array(DowJones(:,2));

    DowJones = str2double(DowJones);

    X = transpose(DowJones)
    Y = transpose(Apple)
    n = 253;

    % L1 Regression
    [RegressionModel]=L1_MultilinearRegression(X,Y);
    %
    % Least square
    %
    Xhat=X-mean(X,2)*ones(1,n);
    Yhat=Y-mean(Y);
    Coef_LSQ=inv(Xhat*Xhat')*Xhat*Yhat';
    Intersect_LSQ=mean(Y)-Coef_LSQ'*mean(X,2);
    Prediction=Coef_LSQ'*X+Intersect_LSQ;
    %
    figure;
    plot(Y,RegressionModel.Prediction,'o','MarkerSize',[8],'MarkerFaceColor','r','MarkerEdgeColor','r');
    hold on
    plot(Y,Prediction,'o','MarkerSize',[8],'MarkerFaceColor','b','MarkerEdgeColor','b');
    %
    figure;
    plot(Y'-RegressionModel.Prediction,'o','MarkerSize',[8],'MarkerFaceColor','r','MarkerEdgeColor','r');
    hold on
    plot(Y-Prediction,'o','MarkerSize',[8],'MarkerFaceColor','b','MarkerEdgeColor','b');

    RegressionModel.SRE
    sum(abs(Y-Prediction))
end