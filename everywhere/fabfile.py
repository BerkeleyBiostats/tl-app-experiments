import sys
import configparser
from fabric.api import run, env, execute

def host_type():
	run('ls -al')

if __name__ == '__main__':
	
	print(sys.argv)

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

	execute(host_type)



# # NEXT: copy file in cli arg to server
# # THEN: run it
# # THEN: emit its outputs

# # MAYBE: wrap as a pip package that Jeremy can run?

# pip install clusterr

# clusterr pi.r ghap

# (if not in env)
# Prompt username
# Prompt password

# clusterr pi.r hosts.ini ghap