
Demonstration CLI for multi-target R scripts
===

The `everywhere` directory demonstrates the design of an R library and Python harness for writing a single R script that can be run locally and on a cluster.

Install:

	pip install fabric

Configure a `hosts.ini` file in the `everywhere` directory

	[ghap]
	ip=...
	username=...
	password=...

Run:

	cd everywhere
	python cli.py pi_everywhere.r hosts.ini ghap

Also try locally:

	Rscript pi_everywhere.r local


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

