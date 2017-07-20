
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
