# Path to your oh-my-zsh configuration.
export ZSH=$HOME/.oh-my-zsh

# Set to the name theme to load.
# Look in ~/.oh-my-zsh/themes/
export ZSH_THEME="robbyrussell"

# Set to this to use case-sensitive completion
# export CASE_SENSITIVE="true"

# Comment this out to disable weekly auto-update checks
# export DISABLE_AUTO_UPDATE="true"

# Uncomment following line if you want to disable colors in ls
# export DISABLE_LS_COLORS="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(git)

source $ZSH/oh-my-zsh.sh

# Customize to your needs...
export TERM="screen-256color"

export EC2_PRIVATE_KEY=$HOME/aws_keys/pk-K5XOCT24OQBJJMJNZD7XN7RJFFGD4USW.pem
export EC2_CERT=$HOME/aws_keys/cert-K5XOCT24OQBJJMJNZD7XN7RJFFGD4USW.pem

export JAVA_HOME=/usr/lib/jvm/java-6-sun/
export JDK_HOME=/usr/lib/jvm/java-6-sun/

export EDITOR=vim
alias t="TERM=screen-256color tmux -2 -u"
