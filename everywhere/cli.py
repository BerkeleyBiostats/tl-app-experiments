
# clusterr pi.r hosts.ini ghap

import sys
import os
import configparser
from fabric.api import *
from fabric.operations import *

def host_type():
	run('ls -al')

def runr(script_name):
	# TODO: this directory is different on different clusters
	with cd('/torquefs'):
		cwd = os.getcwd()
		local_path = os.path.join(cwd, script_name)
		put(local_path, script_name)

		# TODO: generate this dynamically? Or, at least, choose based on cluster
		template_name = 'torque.tmpl'
		local_path_tmpl = os.path.join(cwd, template_name)
		put(local_path_tmpl, template_name)

		run('R -e "install.packages(\'batchtools\', dependencies=TRUE, repos=\'http://cran.rstudio.com/\')"')
		run('rm -rf /torquefs/pitorque')
		output = run('Rscript %s ghap' % script_name)


if __name__ == '__main__':
	
	args = sys.argv

	script_name = args[1]
	hosts_file = args[2]
	target = args[3]
	
	config = configparser.RawConfigParser()
	config.read('hosts.ini')

	# Cheat here and only support GHAP for demo
	username = config.get('ghap', 'username')
	server = config.get('ghap', 'ip')
	password = config.get('ghap', 'password')

	env.hosts = ["%s@%s" % (username, server)]
	env.passwords = {
		"%s@%s:22" % (username, server): password
	}

	execute(runr, script_name)


