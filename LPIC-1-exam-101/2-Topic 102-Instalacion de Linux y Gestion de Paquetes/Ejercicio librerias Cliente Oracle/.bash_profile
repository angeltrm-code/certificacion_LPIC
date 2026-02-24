# .bash_profile

# Get the aliases and functions
if [ -f ~/.bashrc ]; then
	. ~/.bashrc
fi

# User specific environment and startup programs

PATH=$PATH:$HOME/bin

#Configuracion de ORACLE
ORACLE_HOME=/usr/lib/oracle/10.2.0.5/client
PATH=$ORACLE_HOME/bin:$PATH
LD_LIBRARY_PATH=$ORACLE_HOME/lib
export ORACLE_HOME
export LD_LIBRARY_PATH
export PATH ORACLE_HOME
unset USERNAME
export LS_COLORS="ow=01;90:di=01;34"


