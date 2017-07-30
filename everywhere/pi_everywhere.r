

library(batchtools)
# library(clusters)

makeClustersRegistry = function (local = NULL, savio = NULL, ghap = NULL) {

	args = commandArgs(trailingOnly = TRUE)

	print(args)

	# reg = makeRegistry(
	# 	file.dir = '/global/home/users/marcpare/pi', 
	# 	seed = 1
	# )

	reg = makeRegistry(
		file.dir = NA,
		seed = 1
	)

	return(reg)
}

reg = makeClustersRegistry(

	# Maybe even provide defaults for this e.g. /tmp, ~
	local=list(
		file.dir = '/global/home/users/marcpare/pi', 
		seed = 1
	),

	# Can override settings like...
	savio=list(
		scheduler.latency=2
	)

)

# Handled by makeClustersRegistry
# reg = makeRegistry(
# 	file.dir = '/global/home/users/marcpare/pi', 
# 	seed = 1
# )

# reg$cluster.functions = makeClusterFunctionsSlurm(
# 	template="/global/home/users/marcpare/batchtools.slurm.tmpl",
#   	clusters = NULL, 
#   	array.jobs = TRUE, 
#   	scheduler.latency = 1,
#   	fs.latency = 65
#  ) 
# saveRegistry(reg=reg)

piApprox = function(n) {
  nums = matrix(runif(2 * n), ncol = 2)
  d = sqrt(nums[, 1]^2 + nums[, 2]^2)
  4 * mean(d <= 1)
}
piApprox(1000)


batchMap(fun = piApprox, n = rep(1e5, 10))

names(getJobTable())

clusterSubmitJobs(
	resources = list(
		walltime = 3600, 
		memory = 1024, 
		ncpus=1, 
		partition='savio2' # this gets added when CLI arg is savio
)

submitJobs()

waitForJobs()

mean(sapply(1:10, loadResult))
reduceResults(function(x, y) x + y) / 10








