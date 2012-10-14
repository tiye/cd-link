
PS1='\[\033[01;34m\]➤➤ \[\033[00m\]'

function l(){
  ls -CF $1 $2;
  str1="\033[36m ∮ $[$(ls -l | wc -l) - 1] \033[0m";
  str2="\033[01;35m`pwd`\033[00m"
  echo -e $str1 $str2;
}

function c(){
  cd $1;
  l;
}

function g(){
  str=`/home/chen/code/cd-link/main.coffee $1 $2`
  if [[ $str =~ ^goto ]];
  then
    c ${str:(6)}
  else
    echo -e ${str:(6)}
  fi;
}