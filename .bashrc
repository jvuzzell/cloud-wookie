# .bashrc
# This file is executed by bash for non-login shells.

# Source the global definitions (if any)
if [ -f /etc/bashrc ]; then
    . /etc/bashrc
fi

export ENV_CONFIG_PATH="./env_config.json"

# Check if the JSON configuration file exists
if [ ! -f "$ENV_CONFIG_PATH" ]; then
    echo "Configuration file not found: $ENV_CONFIG_PATH"
    exit 1
fi

current_dir=`pwd`
export LIBRARY_DIR="$current_dir/library"
export COMMAND_DIR="$current_dir/library/commands" 

# Check if the set_environment.sh file exists
if [ -f $LIBRARY_DIR/commands/set_environment.sh ]; then
    # Terraform Deployment Environment Setup
    source $LIBRARY_DIR/commands/set_environment.sh
    echo "Environment variables configured."
    echo "----"
fi

# Aliases for Terraform Deployment Scripts
alias deploy_env="$COMMAND_DIR/deploy_environment.sh"
alias destroy_env="$COMMAND_DIR/destroy_environment.sh"

# Utilities 
cloudwookiee.help(){
  declare -F | grep 'cloudwookiee' | awk '{printf "> %s\n" , $3}'
}

alias cloudwookiee=cloudwookiee.help

cloudwookiee.deploy_env() {
    if [ "$#" -ne 2 ]; then
        echo ""
        echo "Usage: cloudwookiee.deploy_env <project_directory> <environment_name>"
        echo ""
        return 1
    fi
    deploy_env "$1" "$2"
}

cloudwookiee.destroy_env() {
    if [ "$#" -ne 2 ]; then
        echo ""
        echo "Usage: cloudwookiee.destroy_env <project_directory> <environment_name>"
        echo ""
        return 1
    fi
    destroy_env "$1" "$2"
}

cloudwookiee.test_deploy() {
    test_deploy
}

# Display available commands
echo " "
echo "
 ██████╗██╗      ██████╗ ██╗   ██╗██████╗      
██╔════╝██║     ██╔═══██╗██║   ██║██╔══██╗     
██║     ██║     ██║   ██║██║   ██║██║  ██║     
██║     ██║     ██║   ██║██║   ██║██║  ██║     
╚██████╗███████╗╚██████╔╝╚██████╔╝██████╔╝     
 ╚═════╝╚══════╝ ╚═════╝  ╚═════╝ ╚═════╝      
                                               
██╗    ██╗ ██████╗  ██████╗ ██╗  ██╗██╗███████╗
██║    ██║██╔═══██╗██╔═══██╗██║ ██╔╝██║██╔════╝
██║ █╗ ██║██║   ██║██║   ██║█████╔╝ ██║█████╗  
██║███╗██║██║   ██║██║   ██║██╔═██╗ ██║██╔══╝  
╚███╔███╔╝╚██████╔╝╚██████╔╝██║  ██╗██║███████╗
 ╚══╝╚══╝  ╚═════╝  ╚═════╝ ╚═╝  ╚═╝╚═╝╚══════╝"
echo " "
echo "Cloudwookiee is loaded into your terminal."
echo "The following commands are available:"
echo " "
                                               
cloudwookiee
echo " "
echo " "