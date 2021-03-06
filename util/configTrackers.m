% 续在最后往下添加，尽量不要删除前面的组合，常用的归纳为一组。
% 例如 trackers_common，trackers_hand_crafted，trackers_deep…
% 自己的组合就例如 trackers_ICRA19_LFL （trackers+期刊会议+年份+作者+其他），
% 也可以利用 trackers = [trackers_common, trackers_ICRA19_LFL] 进行组合。
%
% 新建 trackers_ICRA19_LFL_video 用以表示要绘制边框的跟踪器组合。
%
% 避免混乱出现下次找不到
%
% by lfl

function trackers=configTrackers

trackers_all = {
    struct('name','KCF_LinearHog','namePaper','DCF'),...
    struct('name','KCF_GaussHog','namePaper','KCF'),...
    struct('name','DSST','namePaper','DSST'),...
    struct('name','CoKCF','namePaper','CoKCF'),...
    struct('name','BACF','namePaper','BACF'),...
    struct('name','SAMF','namePaper','SAMF'),...
    struct('name','SAMF_CA','namePaper','SAMF\_CA'),...
    struct('name','Staple','namePaper','Staple'),...
    struct('name','Staple_CA','namePaper','Staple\_CA'),...
    struct('name','SRDCF','namePaper','SRDCF'),...
    struct('name','SRDCFdecon','namePaper','SRDCFdecon'),...
    struct('name','CF2','namePaper','CF2'),...
    struct('name','MCCT','namePaper','MCCT'),...
    struct('name','MCCT_H','namePaper','MCCT\_H'),...
    struct('name','CCOT','namePaper','CCOT'),...
    struct('name','CSRDCF','namePaper','CSRDCF'),...
    struct('name','STRCF','namePaper','STRCF'),...
    struct('name','DeepSTRCF','namePaper','DeepSTRCF'),...
    struct('name','ECO_gpu','namePaper','ECO'),...
    struct('name','ECO_HC','namePaper','ECO-HC'),...
    struct('name','TADT','namePaper','TADT'),...
    struct('name','IBCCF','namePaper','IBCCF'),...
    struct('name','UDT','namePaper','UDT'),...
    struct('name','fDSST','namePaper','fDSST'),...
    struct('name','KCC','namePaper','KCC'),...
    struct('name','UDTplus','namePaper','UDT+'),...
    struct('name','MCPF','namePaper','MCPF'),...
    };   

trackers_Test = {
    struct('name','RIA_v011','namePaper','RIA_v011'),...
%     struct('name','RIA_v011_1','namePaper','RIA\_v011\_1'),...
%     struct('name','RIA_v011_2','namePaper','RIA\_v011\_2'),...
%     struct('name','RIA_v011_3','namePaper','RIA\_v011\_3'),...
%     struct('name','RIA_v011_4','namePaper','RIA\_v011\_4'),...
%     struct('name','RIA_v011_5','namePaper','RIA\_v011\_5'),...
%     struct('name','RIA_v011_6','namePaper','RIA\_v011\_6'),...
%     struct('name','RIA_v011_7','namePaper','RIA\_v011\_7'),...
%     struct('name','RIA_v011_8','namePaper','RIA\_v011\_8'),...
%     struct('name','RIA_v011_9','namePaper','RIA\_v011\_9'),...
%     struct('name','RIA_v011_10','namePaper','RIA\_v011\_10'),...
%     struct('name','RIA_v011_11','namePaper','RIA\_v011\_11'),...
%     struct('name','RIA_v011_12','namePaper','RIA\_v011\_12'),...
%     struct('name','RIA_v011_13','namePaper','RIA\_v011\_13'),...
%     struct('name','RIA_v011_14','namePaper','RIA\_v011\_14'),...
%     struct('name','RIA_v011_15','namePaper','RIA\_v011\_15'),...
%     struct('name','RIA_v011_16','namePaper','RIA\_v011\_16'),...
%     struct('name','RIA_v011_17','namePaper','RIA\_v011\_17'),...
%     struct('name','RIA_v011_18','namePaper','RIA\_v011\_18'),...
%     struct('name','RIA_v011_19','namePaper','RIA\_v011\_19'),...
%     struct('name','RIA_v011_20','namePaper','RIA\_v011\_20'),...
    };

trackers_Plot = {
%     struct('name','RIA_v011','namePaper','RIA_v011'),...
    struct('name','RIA_v011_1','namePaper','RIA\_v011\_1'),...
    struct('name','RIA_v011_2','namePaper','RIA\_v011\_2'),...
    struct('name','RIA_v011_3','namePaper','RIA\_v011\_3'),...
%     struct('name','RIA_v011_4','namePaper','RIA\_v011\_4'),...
%     struct('name','RIA_v011_5','namePaper','RIA\_v011\_5'),...
%     struct('name','RIA_v011_6','namePaper','RIA\_v011\_6'),...
%     struct('name','RIA_v011_7','namePaper','RIA\_v011\_7'),...
%     struct('name','RIA_v011_8','namePaper','RIA\_v011\_8'),...
%     struct('name','RIA_v011_9','namePaper','RIA\_v011\_9'),...
%     struct('name','RIA_v011_10','namePaper','RIA\_v011\_10'),...
%     struct('name','RIA_v011_11','namePaper','RIA\_v011\_11'),...
%     struct('name','RIA_v011_12','namePaper','RIA\_v011\_12'),...
%     struct('name','RIA_v011_13','namePaper','RIA\_v011\_13'),...
%     struct('name','RIA_v011_14','namePaper','RIA\_v011\_14'),...
%     struct('name','RIA_v011_15','namePaper','RIA\_v011\_15'),...
%     struct('name','RIA_v011_16','namePaper','RIA\_v011\_16'),...
%     struct('name','RIA_v011_17','namePaper','RIA\_v011\_17'),...
%     struct('name','RIA_v011_18','namePaper','RIA\_v011\_18'),...
%     struct('name','RIA_v011_19','namePaper','RIA\_v011\_19'),...
%     struct('name','RIA_v011_20','namePaper','RIA\_v011\_20'),...
    };

trackers_ICRA19_hc = {
    struct('name','KCF_GaussHog','namePaper','KCF'),...
    struct('name','DSST','namePaper','DSST'),...
    struct('name','BACF','namePaper','BACF'),...
    struct('name','SAMF','namePaper','SAMF'),...
    struct('name','Staple','namePaper','Staple'),...
    struct('name','Staple_CA','namePaper','Staple\_CA'),...
    struct('name','SRDCF','namePaper','SRDCF'),...
    struct('name','SRDCFdecon','namePaper','SRDCFdecon'),...
    struct('name','MCCT_H','namePaper','MCCT\_H'),...
    struct('name','CSRDCF','namePaper','CSR-DCF'),...
    struct('name','STRCF','namePaper','STRCF'),...
    struct('name','ECO_HC','namePaper','ECO-HC'),...
    struct('name','fDSST','namePaper','fDSST'),...
    struct('name','KCC','namePaper','KCC'),...
    struct('name','BiCF','namePaper','\bf{BiCF}'),...
    };   

trackers_Test191203 = {
    ...struct('name','TSD_HC','namePaper','TSD_HC'),...
    struct('name','TSD_final','namePaper','run_TSD_final'),...
}; 

trackers = trackers_Test191203; % trackers_Plot trackers_Test