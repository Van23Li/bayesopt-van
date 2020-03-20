%修改相应代码，搜索：van

close all;
clear, clc;
addpath(genpath('./mlcircus_bayesopt'));
% BO
F = @(x) opt_func(x);
opt = defaultopt;

%van:建议不要使用此功能，不注释的话，相当于你有之前的实验结果，储存在trace.mat里，根据经验，即使使用了依然会重复计算，所以建议一次性跑完所有组实验
% opt.resume_trace = 1;

% opt.grid_size = 20000;

%van:分别为要调的参数的个数，如我要调的是scale_step和search_area_scale两个参数，以及各自的最小值和最大值范围
opt.dims = 2;
opt.mins = [1.0265, 4.365];
opt.maxes = [1.0275, 4.375];

%van:更改为你要调的参数
scale_step = opt.mins(1):0.0001:opt.maxes(1);
search_area_scale = opt.mins(2):0.001:opt.maxes(2);

param_cell = {scale_step, search_area_scale};
opt.grid = permutation_and_combination(param_cell);

opt.parrallel_jobs = 2;

%van:最大迭代次数
opt.max_iters = 100;

opt.save_trace = 1;
[min_sample, min_value, botrace] = bayesopt(F, opt);

rmpath(genpath('./mlcircus_bayesopt'));

function L = opt_func(opt_param)
warning off all;
% Need to change
tracker_name = 'TSD_final';
length_tracker_name = length(tracker_name);

%van：修改为自己的地址
% dataPath = 'D:\Van\Matlab\Data_set\Dataset_UAV123\UAV123\data_seq\UAV123';
dataPath = 'D:\Van\Matlab\Data_set\DTB70';
% annoPath = ['./anno/', 'UAV20L', '/']; % 对应UAV123_10fps
annoPath = ['./anno/', 'DTB70', '/']; % 对应UAV123_10fps UAV20L

evalType= 'OPE'; %'OPE','SRE'
addpath('./util');
addpath(('./rstEval'));
res_name = [tracker_name '_BO'];
resPath = ['./results/results_' res_name '/'];
rp = resPath; % This parameter is necessary but useless
bSaveImage=0; % This parameter is necessary but useless
if ~exist(resPath,'dir')
    mkdir(resPath);
end

dir_info = dir(resPath);

trackers_name = {dir_info.name};
trackers_name(strcmp('.', trackers_name) | strcmp('..', trackers_name) | ...
    ~[dir_info.isdir]) = [];

num_dir = length(trackers_name);
if num_dir == 0
    tune_ind = sprintf('%03d', 1);
else
    last_dir_name = dir_info(end).name;
    tune_ind = sprintf('%03d', num_dir+1);
end

shiftTypeSet = {'left','right','up','down','topLeft','topRight','bottomLeft','bottomRight','scale_8','scale_9','scale_11','scale_12'};
seqs=configSeqs(dataPath);
trackers=configTrackers;
numSeq=length(seqs);
numTrk=length(trackers);

fine_tune = true; % true, false
for idxSeq=1:length(seqs)
% for idxSeq=1:1
    s = seqs{idxSeq};
    
    s.len = s.endFrame - s.startFrame + 1;
    s.s_frames = cell(s.len,1);
    nz	= strcat('%0',num2str(s.nz),'d'); %number of zeros in the name of image
    for i=1:s.len
        image_no = s.startFrame + (i-1);
        id = sprintf(nz,image_no);
        s.s_frames{i} = strcat(s.path,id,'.',s.ext);
    end
    
    img = imread(s.s_frames{1});
    [imgH,imgW,ch]=size(img);
    
    rect_anno = dlmread([annoPath s.name '.txt']);
    numSeg = 20;
    
    [subSeqs, subAnno]=splitSeqTRE(s,numSeg,rect_anno);
    subS = subSeqs{1};
    subSeqs=[];
    subSeqs{1} = subS;
    subA = subAnno{1};
    subAnno=[];
    subAnno{1} = subA;

    for idxTrk=1:numTrk % 只能一个
        t = trackers{idxTrk};
        
        if fine_tune
            t.name = [t.name, '_', tune_ind];
        end
        
        % validate the results
        if exist([resPath t.name '/' s.name '_' t.name '.mat'], 'file')
            load([resPath t.name '/' s.name '_' t.name '.mat']);
            bfail=checkResult(results, subAnno);
            if bfail
                disp(['error in ' s.name ' '  t.name '!']);
            end
            continue;
        end
        
        results = [];
        for idx=1:length(subSeqs)
%             disp([num2str(idxTrk) '_' t.name ', ' num2str(idxSeq) '_' s.name ': ' num2str(idx) '/' num2str(length(subSeqs))])
            if fine_tune
                t.name = trackers{idxTrk}.name;
            end
            
            subS = subSeqs{idx};
            subS.name = [subS.name '_' num2str(idx)];
            funcName = ['res=run_' t.name '(subS, rp, bSaveImage);'];

            try
                if fine_tune
                    subS.scale_step = opt_param(1);
                    subS.search_area_scale = opt_param(2);
                end
                cd(['./trackers/' t.name]);
                addpath(genpath('./'))
                eval(funcName); % 运行主函数
                rmpath(genpath('./'))
                cd('../../');
                
                if isempty(res)
                    results = [];
                    break;
                end
            catch err
                disp('error in running the tracker!');
                rmpath(genpath('./'))
                cd('../../');
                res=[];
                continue;
            end
            res.len = subS.len;
            res.annoBegin = subS.annoBegin;
            res.startFrame = subS.startFrame;
            results{idx} = res;
        end
        
        if fine_tune
            t.name = [t.name, '_', tune_ind];
        end
        
        if(~isdir([resPath t.name '/']))
            mkdir([resPath t.name '/']);
        end
               
        save([resPath t.name '/' s.name '_' t.name '.mat'], 'results');
        
        [precision_at_20pixel, success_AUC] = gen_score(results, annoPath, s);
    end
    precision_on_all_seq(idxSeq) = precision_at_20pixel;
    success_on_all_seq(idxSeq) = success_AUC;
end

avg_precision = mean(precision_on_all_seq);
avg_success = mean(success_on_all_seq);

fid = fopen([resPath 'overall_performance_record.txt'],'a+');
fprintf(fid,'%.4f \t  %.4f \t %.4f \t %.4f\n', opt_param(1), opt_param(2), avg_precision, avg_success);
fclose(fid);
clear fid

coeff = 0.4;
L = 1 - (coeff * avg_precision + (1 - coeff) * avg_success);

rmpath('./util');
rmpath(('./rstEval'));
end