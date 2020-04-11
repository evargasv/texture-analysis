function [ organ_acc ] = classify( X_train, Y_train, X_test, Y_test )
%CLASSIFY Summary of this function goes here
%   Detailed explanation goes here

    % number of classes
    N = 4;

    %% TRAIN

    % train svm
     %Mdl = fitcecoc(X_train,Y_train);
    % fit tree
%     Mdl = fitctree(X_train,Y_train);
    
    % random forest
    Mdl = TreeBagger(50,X_train,Y_train)
    
%     % Compute the in-sample classification error
%     isLoss = resubLoss(Mdl)
%     % Cross validate Mdl using 10-fold cross validation
%     CVMdl = crossval(Mdl);
%     % Estimate the generalization error.
%     oosLoss = kfoldLoss(CVMdl)

    %% TEST

    % predict
    predicted_organs = predict(Mdl,X_test);
    
    gt = cellstr(num2str(Y_test));
    %gt = Y_test;
    
    % confusion matrix
    C = confusionmat(gt,predicted_organs);
    disp(C)
    % normalisation
    sum_col = sum(C,2);
    norm = repmat(sum_col,1,N);
    C = C ./ norm;
    C(isnan(C(:))) = 0;
    % accuracy
    a = trace(C)/N;
    % plot the confusion matrix
    imagesc(C)
    
    organ_acc = [C(1,1);C(2,2);C(3,3);C(4,4)];
    organ_acc = organ_acc * 100;

end

