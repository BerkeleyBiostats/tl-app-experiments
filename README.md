
Batchtools on Savio
===

Create

	pi.R
	batchtools.slurm.tmpl

Replace the hardcoded paths (e.g. /home/marcpare/...)

Install

	load r
	R
	install.packages('batchtools')

Then,

	Rscript pi.R


Batchtools on GHAP
===

	cd /torquefs
	rm -rf pitorque # complains if this already exists

Create

	pitorque.R
	torque.tmpl

Install

	R
	install.packages('batchtools', dependencies=TRUE, repos='http://cran.rstudio.com/')

Run,

	Rscript pitorque.R

Misc

	qstat -q # list queues

