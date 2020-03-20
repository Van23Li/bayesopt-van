function [precision_at_20pixel, success_AUC] = gen_score(results, annoPath, seq)

thresholdSetOverlap = 0:0.05:1;
thresholdSetError = 0:50;

s = seq;
rect_anno = dlmread([annoPath s.name '.txt']);

anno=rect_anno;
successNumOverlap = zeros(1,length(thresholdSetOverlap));
successNumErr = zeros(1,length(thresholdSetError));

res = results{1};
len = size(anno,1);

[~, ~, errCoverage, errCenter] = calcSeqErrRobust(res, anno);

for tIdx=1:length(thresholdSetOverlap)
    successNumOverlap(1,tIdx) = sum(errCoverage >thresholdSetOverlap(tIdx));
end

for tIdx=1:length(thresholdSetError)
    successNumErr(1,tIdx) = sum(errCenter <= thresholdSetError(tIdx));
end

success = successNumOverlap/(len+eps);
precision = successNumErr/(len+eps);

success_AUC = mean(success);
precision_at_20pixel = precision(21);
