function [ Y, L ] = runMultiLayer( X, W, V )
%RUNMULTILAYER Calculates output and labels of the net
%   Inputs:
%               X  - Features to be classified (matrix)
%               W  - Weights of the hidden neurons (matrix)
%               V  - Weights of the output neurons (matrix)
%
%   Output:
%               Y = Output for each feature, (matrix)
%               L = The resulting label of each feature, (vector) 

% Calculate net output
H=tanh(V*X);
H(end,:)=1;
Y = W*H; 
   
% Calculate classified labels

[~, L] = max(Y,[],1);
L=L.';

end

