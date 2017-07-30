library(batchtools)

args = commandArgs(trailingOnly=TRUE)

makeClusterRegistry = function(target) {
	if (target == 'local'){
		return(makeRegistry(file.dir = NA, seed = 1))
	} else if (target == 'ghap'){
		reg = makeRegistry(file.dir = '/torquefs/pitorque', seed = 1)
		reg$cluster.functions = makeClusterFunctionsTORQUE(template="/torquefs/torque.tmpl", scheduler.latency = 1, fs.latency = 65)
		saveRegistry(reg=reg)
		return(reg)
	} else {
		print('Unrecognized target')
	}
}

target = args[1]

reg = makeClusterRegistry(target)

piApprox = function(n) {
  nums = matrix(runif(2 * n), ncol = 2)
  d = sqrt(nums[, 1]^2 + nums[, 2]^2)
  4 * mean(d <= 1)
}

batchMap(fun = piApprox, n = rep(1e5, 10))

submitJobs(resources = list(walltime = 3600, memory = 1024, ncpus=1))
waitForJobs()
mean(sapply(1:10, loadResult))
reduceResults(function(x, y) x + y) / 10