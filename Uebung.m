clear all;
loadedFile = load('Data/features.mat');
featureTable = loadedFile.features;
featureTableSize = size(featureTable,2);
amountSamples = size(featureTable,1);


% normalize features
featureTable{:,2:featureTableSize} = zscore(featureTable{:,2:featureTableSize});
 
W = ldaWeights(featureTable{:,2 : featureTableSize}, featureTable{:,1});
Scores = featureTable{:,2 : featureTableSize} * W;

function W = ldaWeights(X,L)
Mdl = fitcdiscr(X,L);
[W, LAMBDA] = eig(Mdl.BetweenSigma, Mdl.Sigma); 
lambda = diag(LAMBDA);
[lambda, SortOrder] = sort(lambda, 'descend');
W = W(:, SortOrder);
end
