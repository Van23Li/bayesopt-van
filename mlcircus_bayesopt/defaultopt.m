function opt = defaultopt()
    opt.grid_size = 20000; % Size of grid to select candidate hyperparameters from.
    opt.max_iters = 1000; % Maximum number of function evaluations.
    opt.meanfunc = {@meanConst}; % Constant mean function.
    opt.covfunc = {@covSEard}; % Squared Exponential kernel with ARD.
    opt.hyp = -1; % Set hyperparameters using MLE.
	opt.save_trace = false;
	opt.trace_file = 'trace.mat';
