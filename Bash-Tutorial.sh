#!/usr/bin/env bash

# What is your current Bash version?
echo $BASH_VERSION

# Defining variables
myname="Hans Schmid"
echo "Hello, $myname_lst"

# Referencing variables
echo $myname

echo "$myname"

# This is a literal string. Substitution won't happen.
echo '$myname'

# `pwd` is *NOT* an external command. It's built-in!
type pwd

echo $(pwd)

echo $PWD   # the same

echo `pwd`

# Bash keywords
type if then elif else fi time for in until while do done case esac coproc select function { } [[ ]] !

# `which` is an external program.
type which

type -p which

function success {
    echo "I am successful!"
    return 0
}

success() {
    echo "I am successful!"
    return 0
}

function printme {
    echo "You gave me $# argument(s)!"
    echo -n $1
}

printme
printme 'Hello'
printme 'Hello' 'World'

function add {
    # $((...)) to calculate mathematical expressions
    sum=$(( $1 + $2 ))
    echo $sum
}

add 1 2

result=$(add 1 2)
echo $result

echo $sum

function add_local {
    local sum=$(($1+$2))
    echo -n $sum
}

add_local 5 6

echo $sum

function add_by_ref {
    declare -n add_ref=$3
    add_ref=$(( $1 + $2 )) 
}

add_by_ref 4 5 myAddRefResult

echo $myAddRefResult

function add_subshell (
    # `sum` is a global variable
    sum=$(( $1 + $2 ))
    echo $sum 
)

add_subshell 2 3

echo $sum

function factorial {
    if [ $1 -le 1 ]; then
        echo -n 1
    else
        echo -n $(( $(factorial $(( $1 - 1 ))) * $1))
    fi 
}

factorial 5

factorial 10

# declare array
declare -a pioneers

declare -p pioneers

# make pioneers vanish in the void
unset pioneers

pioneers[0]='Ken Thompson'

declare -p pioneers

unset pioneers

pioneers=('Ken Thompson' 'Brian Kernighan' 'Dennis Ritchie')

declare -p pioneers

pioneers[20]='Douglas McIlroy'

declare -p pioneers

echo $pioneers

echo $pioneers[1]

echo ${pioneers[1]}

echo ${pioneers[@]}

echo ${pioneers[*]}

declare -p pioneers

unset pioneers

pioneers=('Ken Thompson' 'Brian Kernighan' 'Dennis Ritchie' [20]='Douglas McIlroy')

pioneers+=('Linus Torvals' 'Richard Stallman')

declare -p pioneers

unset pioneers

pioneers=('Ken Thompson' 'Brian Kernighan' 'Dennis Ritchie' [20]="Douglas McIlroy")

declare -p pioneers

pioneers=("${pioneers[@]}" 'Joe Ossanna' 'Linus Torvalds')

# Douglas McIlroy has now index 3!
declare -p pioneers

pioneers=(${pioneers[@]} 'Richard Stallman')

# Every word is now a separate entry in the array.
declare -p pioneers

unset pioneers

pioneers=(Ken Brian Dennis Douglas)

pioneers2=(${pioneers[@]:1:2})

declare -p pioneers2

pioneers2=${pioneers[@]:1:2}

declare -p pioneers2

pioneers2=(${pioneers[@]::2})

declare -p pioneers2

pioneers2=(${pioneers[@]:2})

declare -p pioneers2

pioneers=(Ken Brian Dennis Douglas)

echo -n ${!pioneers[@]}

pioneers=(Ken Brian Dennis Douglas [10]=Joe)

echo -n ${!pioneers[@]}

pioneers=('Ken Thompson' 'Brian Kernighan' 'Dennis Ritchie' [20]="Douglas McIlroy")

unset pioneers[1]

declare -p pioneers

echo -n ${#pioneers[@]}

echo -n ${#pioneers[*]}

# This will get the size of an element.
echo -n 'Length of the third element:' ${#pioneers[2]}

i=1
for item in "${pioneers[@]}"; do  # Note the quotes!
    echo $((i++)). $item
done

# When we use "${pioneers[*]}" we get only one value which is the whole array.
i=1
for item in "${pioneers[*]}"; do
    echo $((i++)). $item
done

# Looping through the indices.
for index in "${!pioneers[@]}"; do
    echo -e 'Index: '$index'\t'${pioneers[$index]}
done

files=(/etc/[abcdefg]*.conf)

declare -p files

i=1
for file in "${files[@]}"; do
    echo $((i++)). $file
done

unset pioneers

cat pioneers.txt

# Load array from file using command substitution.
pioneers=( $(cat pioneers.txt) )

declare -p pioneers

for pioneer in "${pioneers[@]}"; do
    echo $pioneer
done

mapfile -t pioneers < pioneers.txt # -t strips newline

declare -p pioneers

mapfile -t < pioneers.txt

declare -p MAPFILE

declare -A proglangs=([Python]="Guido van Rossum" [Ruby]="Yukihiro Matsumoto" [C++]="Bjarne Stroustrup")

declare -p proglangs

echo -n ${!proglangs[@]}

echo ${proglangs[Python]}

proglangs[Erlang]="Joe Armstrong"

declare -p proglangs

proglangs+=([Javascript]="Brendan Eich" [Perl]="Larry Wall")

declare -p proglangs

# keys
echo -n ${!proglangs[@]}

# size of dictionary
echo -n ${#proglangs[@]}

# remove an entry
unset proglangs[Javascript]

echo -n ${#proglangs[@]}

echo -n ${!proglangs[@]}

i=1
for proglang in "${proglangs[@]}"; do
    echo $((i++)). $proglang
done

for key in ${!proglangs[@]}; do
    echo -e $key'\t'${proglangs[$i]}
done

calculation='2 * 3'
echo "$calculation"         # prints 2 * 3
echo $calculation           # prints 2, the list of files in the current directory, and 3
echo "$(($calculation))"    # prints 6

c=3
echo "formatted text: $(printf "a + b = %04d" "${c}")" # “formatted text: a + b = 0003”

# echo "$(mycommand "$arg1" "$arg2")"

for day in Mon Tue Wed Thu Fri; do
    echo "Weekday: $day"
done

weekdays="Mon Tue Wed Thu Fri"
for day in $weekdays; do  # no double quotes here; weekdays is already double quoted
    echo "Weekday: $day"
done

weekdays="Mon Tue Wed Thu Fri"
for day in "$weekdays"; do
    echo "Weekday: $day"
done

for username in $(awk -F: '{print $1}' /etc/passwd); do
    echo "Username: $username"
done

for item in /tmp/*; do
    echo "$item"
done

for item in /tmp/d*; do
    echo "$item"
done

for day in Mon Tue Wed Thu Fri; do
    if [ $day == "Thu" ]; then
        break;
    fi
    echo "Weekday: $day"
done

for day in Mon Tue Wed Thu Fri Sat Sun; do
    echo -n "$day"
    if [ $day == "Sat" -o $day == "Sun" ]; then
        echo " (WEEKEND)"
        continue;
    fi
    echo " (weekday)"
done

for num in {1..10}; do
    echo "Number: $num"
done

for num in {1..10..2}; do
    echo "Number: $num"
done

for (( i=1; i <= 5; i++ )); do
    echo "Random number $i: $((RANDOM%100))"
done

i=0
for (( ; ; )); do
    echo "Number: $((i++))"
    [ $i -gt 10 ] && break
    sleep $(( RANDOM % 2 ))
done

for ((i=1, j=10; i <= 5 ; i++, j=j+5)); do
    echo "Number $i: $j"
done

type true

i=0
while true; do
    echo "Number: $((i++))"
    [ $i -gt 10 ] && break
    sleep $(( RANDOM % 2 ))
done

i=1
while [ $i -le 5 ]; do
  echo "$((i++)) time(s)"
done

i=1
until [ $i -gt 5 ]; do
    echo "$((i++)) time(s)."
done

NOW=$(date +"%a")
case $NOW in
    Mon)
        echo "FULL backup!";;
    Tue|Wed|Thu|Fri)
        echo "PARTIAL backup!";;
    Sat|Sun)
        echo "NO backup!";;
    *) ;;
esac

cd 01

ls *

ls *.txt

ls F*

ls file*.txt

ls file?.txt # file.txt is not returned

ls file??.txt

ls file[abc].txt

ls file[0-9].txt

# not numbers from 0 to 99. But characters from 0 to 9 and 9!!!
ls file[0-99].txt

ls file[0-9a].txt

ls file[a-z9].txt

ls file[123456789abc].txt

# the same
ls file[1-9a-c].txt

ls | grep 'file[^a-z]*'

ls | grep '^file[^a-z]*' # alphafiles is filtered out.

ls | grep '^file[!a-z]*' # Same as previous but maybe not so confusing.

ls file[!a-z].txt

# Does not work (and screws up the kernel)
# ls file[a-z!].txt

ls file[a-z\!].txt

ls file[a-z^].txt

ls file[\!].txt # Match only exclamation mark.

ls file[\^].txt # Match only caret.

ls file[-abc].txt # Matches also a hyphen.

ls file[abc-].txt # Matches also a hyphen.

ls file[-].txt # Matches a single hyphen.

ls file-.txt # The same as the previous one.

ls file[[abc].txt # Matches [. Put it as the first character in the character set.

ls file[]abc].txt # Brackets lose their special meaning when they are used first in a character set.

ls 'file*.txt'

ls file[*abc].txt # Character sets give you more flexibility.

ls file[ABC].txt

ls file[A-Z].txt # The output depends on your collate settings.

locale # On my machine it is set to C: LC_COLLATE=C. Which does what you expect.

cd Collate; cat file.txt

sort file.txt # With LC_COLLATE=C you get first numbers, then uppercase letters, then lowercase letters.

LC_COLLATE="en_US.UTF-8" sort file.txt # Uppercase and lowercase letters are intermingled

LC_COLLATE=C sort file.txt # Uppercase and lowercase letters are separate.

# On my box with Oh My Bash globasciiranges is set.
shopt -p globasciiranges

cd ../alphafiles

ls

# Let's use a character set with a character class.
# Upper case characters.
ls [[:upper:]] # Does actually not what was expected. Should print: A  B  Ç   Y  Z


# Lower case characters.
ls [[:lower:]] # Does actually not what was expected. Should print: á c x

# Numbers
ls [[:digit:]]

# Upper and lower case
ls [[:alpha:]]

# Upper and lower case plus numbers
ls [[:alnum:]]

# Space, tabs and newlines
ls [[:space:]]

# Printable characters not including spaces
ls [[:graph:]]

# Printable characters including spaces
ls [[:print:]]

# Punctuation
ls [[:punct:]]

# Non-printable control characters
ls [[:cntrl:]]

# Hexadecimal characters
ls [[:xdigit:]]

ls [[:digit][:space:]]

# Character class negation
ls [![:digit:][:space:]]

cd ..

pwd

ls file[[:alnum:]].txt

ls file[[:alnum:][:punct:]].txt

ls file[![:alnum:][:punct:]].txt

ls file[![:alnum:][:space:]].txt

ls file[![:alnum:]].txt

shopt -p nullglob # nullglob is not set

shopt -u nullglob # If there are no *.bin files in the directory
# it will be set to '*.bin' and found to 1
# which in our application case is wrong.
found=0
for i in *.bin; do
    echo $i
    found=1
done
echo $found

shopt -s nullglob # If there are no *.bin files we don't enter the for-loop. This is what we want!
found=0
for i in *.bin; do # pattern is set to null. For-loop is not entered.
    echo $i
    found=1
done
shopt -u nullglob # Immediately deactivate this option! It can break some tools and even shell scripts!
echo $found

shopt -p failglob

shopt -s failglob # If there are no *.bin files an error is displayed.
found=0
for i in *.bin; do # Error is displayed and the code is not executed.
    echo $i
    found=1
done
shopt -u failglob # Immediately deactivate this option! It can break some tools and even shell scripts!
echo $found

shopt -p dotglob

shopt -u dotglob

ls *

shopt -s dotglob

ls * # .hiddenfile is displayed

shopt -p globstar

shopt -s globstar

ls ** # recurses into subdirectories

shopt -s globstar
for i in **; do
    echo $i
done

shopt -s globstar
for i in **/*.txt; do
    echo $i
done

cat nocasematch.sh

. ./nocasematch.sh # case insensitive string comparisons because of shopt -s nocasematch

cd upper*

shopt -s nocaseglob

cd upper*

pwd # now it worked

cd ../../02/globfiles

shopt -s extglob

ls photo@(.jpg)

ls photo.jpg # trivially the same

ls photo@(.jpg|.png)

ls photo?(.jpg|.png)

ls photo+(.jpg|.png)

ls photo*(.jpg|.png)

ls photo!(.jpg|.png)

ls photo!(?(.jpg|.png)) # The inverse of ls photo(?(.jpg|.png))

ls !(+(photo|file)*+(.jpg|.gif))

shopt -p extglob # On my box extended globs are activated by default. If not add them to your ~/.bashrc file.

cd ..
pwd

cp -Rf goldenfiles/ testfiles

cd testfiles
# Now you can play around to your delight!

# ls

cd 02/testfiles

# ls  @(Archive|Backup)*@(.gz|.xz)

# ls  @(Archive|Backup)-!(2019)*@(.gz|.xz) | sort
# Records from 2019 will still be shown as the asterisk is greedy and matching everything

# We need something more specific so the asterisk does not match everything.
# ls  @(Archive|Backup)-!(2019)-[0-9][0-9]-*@(.gz|.xz) | sort
# You cannot do this with a standard glob!

for i in *; do echo ${i#*.}; done | sort -u # Finding the file extensions using substring removal and unique sort

# ls -1 @(Archive|Backup)-[0-9][0-9][0-9][0-9]-[0-9][0-9]-@([0-9]|[0-9][0-9])@(@(.bak|.tar)?(.bz2|.gz|.xz)|.tgz)

# ls -1 !(*@(Archive|Backup)-[0-9][0-9][0-9][0-9]-[0-9][0-9]-@([0-9]|[0-9][0-9])@(@(.bak|.tar)?(.bz2|.gz|.xz)|.tgz)*)
# These files shouldn't be there.

ls -1 @(Archive|Backup)-[0-9][0-9][0-9][0-9]-[0-9][0-9]@(@(.bak|.tar)?(.bz2|.gz|.xz)|.tgz)

for i in @(Archive|Backup)-[0-9][0-9][0-9][0-9]-[0-9][0-9]@(@(.bak|.tar)?(.bz2|.gz|.xz)|.tgz); do
    echo $i
done

for i in @(Archive|Backup)-[0-9][0-9][0-9][0-9]-[0-9][0-9]@(@(.bak|.tar)?(.bz2|.gz|.xz)|.tgz); do
    echo ${i%%.*}
done

for i in @(Archive|Backup)-[0-9][0-9][0-9][0-9]-[0-9][0-9]@(@(.bak|.tar)?(.bz2|.gz|.xz)|.tgz); do
    echo ${i%%.*}-1.
done

for i in @(Archive|Backup)-[0-9][0-9][0-9][0-9]-[0-9][0-9]@(@(.bak|.tar)?(.bz2|.gz|.xz)|.tgz); do
    echo ${i%%.*}-1.${i#*.}
done

for i in @(Archive|Backup)-[0-9][0-9][0-9][0-9]-[0-9][0-9]@(@(.bak|.tar)?(.bz2|.gz|.xz)|.tgz); do
    mv -v $i ${i%%.*}-1.${i#*.}
done

mkdir compressed

# mv @(Archive|Backup)*@(@(.bak|.tar)?(.bz2|.gz|.xz)|.tgz) compressed

ls -1 compressed | wc -l

cd ..

rm -Rf testfiles

# cp -Rf goldenfiles/ testfiles
# Now you can play again

cd ../03

touch file{1,2,4}.txt
rm file3.txt 

ls

ls file{1..4}.txt

echo file{1..4}.txt

echo {1..10}

echo {a..c}{10..99}

echo {a,b,c}{d,e,f}

echo {1..100..2} # odd numbers

echo {2..100..2} # even numbers

echo {0002..1000..2} # padded numbers

echo {a..z}

echo {a..z..2}

echo {10..0} # count down

echo file{,.bak}

echo /this/is/a/long/path/file{,.bak} # gives you source and destination for cp or mv

mkdir bracefiles

cd bracefiles

touch Backup-201{1..9}-{0{0..9},1{1,2}}-{1..30}.{tar,bak}.{gz,xz,bz2}

ls -1 | wc -l

# \cp means we use the unaliased version of cp
# On my box cp is aliased to 'cp -iv'
for i in Backup*{0..30..7}.tar.bz2; do
    \cp -vf $i{,.bak}
done    

ls *.bak

mkdir -p 20{20..25}/{01..12}

tree -d

mkdir -p {sales,production,development,engineering}/{manager,employee{01..10}}

tree -d

echo {w,t,}h{e{n{,ce{,forth}},re{,in,fore,with{,al}}},ither,at}

cd 04

# Pattern Matching with Globs
cat globfiles.sh

# Pattern matching with Regular Expresssions
# NOTE: You cannot place quotes around the REs: [[ $FILE =~ "^Backup.*tar.gz$" ]] does not work!!!
cat regexfiles.sh

# Globs are much faster.
time ./globfiles.sh > /dev/null

# Regexes are easier to create and read and more powerful.
time ./regexfiles.sh > /dev/null

# Return code = 0
[[ abcdef =~ b.d ]]

declare -p BASH_REMATCH

# Return code = 1
[[ xyz =~ b.d ]]

declare -p BASH_REMATCH

 [[ "abcdef" =~ (b)(.)(d)e ]]

# BASH_REMATCH[0] contains the entire matching pattern
declare -p BASH_REMATCH

echo -n ${BASH_REMATCH[0]}

KEEP_BASH_REMATCH=("${BASH_REMATCH[@]}")

echo ${KEEP_BASH_REMATCH[@]}

declare -p KEEP_BASH_REMATCH

cat sales.csv

# Finding Visa card numbers & print them
# Adding hyphens every four digits for easier reading
for line in $(cat sales.csv); do
    if [[ $line =~ .*[Vv]isa.*  ]]; then
        if [[ $line =~ [0-9]{16} ]]; then
            echo ${BASH_REMATCH[0]} | sed -E 's/([0-9]{4})([0-9]{4})([0-9]{4})([0-9]{4})/\1-\2-\3-\4/'
        fi
        
    fi
done

cd ../05

ls

head -n 20 words.txt

tail -n 20 words.txt

wc -l words.txt

# Search for words with three double s'es.
grep -E '(ss).*\1.*\1' words.txt

# GNU tools rely on greedy matching!
grep -E 'a.*a' words.txt | wc -l

grep -E 'a.*a' words.txt | tail

# If we want only words that start and end with an a we can use the -x option.
grep -E -x 'a.*a' words.txt | head

# Use anchors to achieve the same. (But more portable.)
grep -E '^a.*a$' words.txt | head

grep -E -o 'a.*a' words.txt | head

# Relying only on the return value of pattern matching
# If your data to match is already in your script use Bash pattern matching.
# Grep pattern matching was the only option before there was support for regexes in Bash.
if grep -E -q '^schmid.*' /etc/passwd; then
    echo 'Schmid somehow exists as a user account.'
fi

# Multiline matches
cat multiline.txt

 grep -o -E '{([^}]*)}' multiline.txt

# For mulitline matches we need PCREs
# -z replaces newline by NULL
grep -o -z -P '{([^}]*)}' multiline.txt

# the z option is necessary in multiline pattern matching
grep -o -P '{([^}]*)}' multiline.txt

cat photofiles.txt

# Grep is greedy
grep -o '^(https.*.jpg' photofiles.txt

# Using PCREs.
# The question mark introduces a non-greedy match.
grep -o -P '(https).*?.jpg' photofiles.txt

# Finding telephone numbers
grep -E -o '([+][0-9][0-9]?-)?[(]?[0-9]{3}[)]?-[0-9]{3}-[0-9]{4}' contacts.csv
# Handles telephone numbers of the forms:
# 908-870-5536
# (510)-503-7169
# +1-510-993-3758
# +1-(510)-503-7169

cd 06

cat passwd

sed -n '/root/p' passwd

sed -n '/^root/p' passwd

sed -n 's/^root/toor/p' passwd

sed -n 's/^root/toor/p' passwd # -n and /p are a good combination!

sed 's/^root/toor/' passwd

# replace UIDs < 1000 with uid
sed -E 's/:([0-9][0-9]{0,2}):/:uid:/' passwd

# Remove UIDs < 1000
sed -E 's/:([0-9][0-9]{0,2})://' passwd

cat phonenumbers.txt

# Put parens around whole match (&)
sed -E 's/[0-9]{3}/(&)/' phonenumbers.txt

# Using backreferences
sed -E 's/([0-9]{3})([0-9]{3})([0-9]{4})/(\1)\2-\3/' phonenumbers.txt

cat IPaddresses.csv

cd 06

# Finding IP addresses
sed -E -n '/((1?[0-9][0-9]?|2[0-4][0-9]|25[0-5])\.){3}(1?[0-9][0-9]?|2[0-4][0-9]|25[0-5])/p' IPaddresses.csv | tail

sed -E -n '/((1?[0-9][0-9]?|2[0-4][0-9]|25[0-5])\.){3}(1?[0-9][0-9]?|2[0-4][0-9]|25[0-5])/p' IPaddresses.csv | tail | sed 's/,.*//g'

# Using grep with EXACTLY the same regex!
grep -E -o '((1?[0-9][0-9]?|2[0-4][0-9]|25[0-5])\.){3}(1?[0-9][0-9]?|2[0-4][0-9]|25[0-5])' IPaddresses.csv | tail

# Using Bash with EXACTLY the same regex!

function findIPs {
for i in $(cat IPaddresses.csv); do
    if [[ $i =~  ((1?[0-9][0-9]?|2[0-4][0-9]|25[0-5])\.){3}(1?[0-9][0-9]?|2[0-4][0-9]|25[0-5]) ]]; then
        echo ${BASH_REMATCH[0]}
    fi
done
}

findIPs | tail

# My shell uses vi mode
set | grep SHELLOPT

# list keybindings
bind -P

# Executing a background job
find / -ctime -1 > /tmp/changed-file-list.txt &

# List all jobs. Execute this command in a real shell!
jobs

wc -l /tmp/changed-file-list.txt

# Suspend current job with CTRL-Z and put it in the background with 'bg'
# Move a job in the foreground with 'fg'
# Detach job from shell with 'disown'. Disown job #3:
# disown 3
# Immediately detach it when putting it in the background:
# curl -s http://192.168.0.47:22000/play/sundtek.m3u | grep 22000 | dmenu -i -l 10 | xargs -r mpv & disown

alias

show_options

alias imbeggingyou='sudo'

xbps-install foo

imbeggingyou xbps-install foo

alias cp

# Backslash alias to access original command
\cp -r /tmp/.ICE-unix /tmp/.ICE-unix.foo

unalias imbeggingyou

imbeggingyou xbps-install foo

USERNAME=schmidh

echo -n $USERNAME

echo -n ${USERNAME}

echo -n $USERNAMEhome

# When concattenating values use braces
echo -n ${USERNAME}home

# Variables are case-sensitive
echo -n $username

USERNAME = schmidh

USERNAME= schmidh

USERNAME =schmidh

states="CA NY UT TX"

# no quotes around $states
for i in $states; do
    echo $i
done

# With quotes it is regarded as one word
for i in "$states"; do
    echo $i
done

# Print the shell's PID
echo $$

# Use $$ to Create Temporary Files and Directories
touch /tmp/temp$$.log

ls /tmp/temp*

# Create temporary directory
mkdir /tmp/temp.$$

# Cleanup
rm /tmp/temp$$.log
rm -rf /tmp/temp.$$

ls /tmp/temp*

echo $_

# Not quoting
# Multiple spaces betweenarguments are treated as just one single space!
echo Hello World!
echo Hello     World!

# Preserving multiple spaces
echo "Hello    World!"
echo 'Hello    World!'

# Double quotes allow variable substitution.
username="Hans Schmid"
echo -n "I am $username!"

username='Hans Schmid'
echo -n "I am $username!"

username="Hans Schmid"
echo -n 'I am $username!'

# Double Quotes Inside Double Quotes. (Execute in a real shell.)
# echo "Hello \"World!\""

echo 'this has "double quotes" in it'

echo This will not expand \$dollar.
echo "This will not expand \$dollar."
echo 'This will not expand $dollar.'

total=3
let total=total+2
echo $total
total="Some string value"
echo $total

# Declaring a variable as integer doesn't allow
# to assign other type's values.
declare -i total
total=3
let total=total+2
echo $total
total="Some string value"
echo $total

# You can't reassign a read-only value
declare -r iamreadonly='I am read-only'
iamreadonly='Believe me - I am read-only!'

# To export a variable to a subshell or child process, use declare -x.
# Note: You can also use the export command for this.
declare -x global=world

# **Note**: This is a one way process, i.e the parent shell can send the value to the
# child process, but any changes made to it in the child will not be sent back to the
# parent. The child process has its own copy of the variable.

# Bash supports arithmetic expressions using the let command in scripts.
# Note: when using let the variable on the right side of the = doesn't
# really need to have a $ in front of it.
total=3
let total=total+7
let total=$total+4
echo $total

# ((expression))
# Both of the following examples work exactly the same.
let total=total+5
((total=total+9))
echo $total

# However, within the (( )) you can have spaces.
# Improved readability!
(( total = total + 7 ))
echo $total

# (( )) allows you to use pre- and post- increment/decrement.
(( total = 0 ))
(( total = total + 3 ))
(( total++ ))
(( total-- ))
(( ++total ))
echo $total

# All three achieve the same.
let total=total+2
((total=total+2))
total=`expr $total + 2`
echo $total

type -p expr

total=100
if [ $total -eq 100 ]; then
    echo "Equal"
fi

state="California"
[ "$state" == "California" ] && echo "State is California!"
[ "$state" \< "Indiana" ] && echo "California comes before Indiana!" # escape <, >

# city was never defined, actually. Same as city=''
[ -z "$city" ] && echo "-z: city is null"

[ ! -n "$city" ] && echo "-n: city is empty"

city="Los Angeles"
[ ! -z "$city" ] && echo "! -z: city is not null"

# When you are referencing a variable, you should always double quote it!!!
city='Vegas'                                 # this is not a reference, we can use literal
[ ! -z $city ]   && echo "1. City is not null"
city="Las Vegas"
[ ! -z $city ]   && echo "2. City is not null" # will cause an error
city="Las Vegas"
[ ! -z "$city" ] && echo "3. City is not null" # use double quotes

type -t test
type -t [

# `test` and `[` are the same.
total=100
if test $total -eq 100; then
    echo "Equal"
fi

if [ $total -eq 100 ]; then
    echo "Equal"
fi

# `if`, `elif`, `else`, `fi`
if [ $total -eq 100 ]; then
    echo "total is equal to 100"
elif [ $total -lt 100 ]; then
    echo "total is less than 100"
else
    echo "total is greater than 100"
fi

total=0

if (( total=total + 0 )); then
    echo "I'm a zero!"
else
    echo "OOPS! I'm not a zero!"
fi

[ -e /etc/ ] && echo "/etc directory exists"
[ -e /etc/passwd ] && echo "/etc/passwd regular file exists"
[ -e /dev/sda1 ] && echo "/dev/sda1 block device file exists"
[ -e /dev/tty1 ] && echo "/dev/tty1 character device file exists"
[ -e /etc/rc.local ] && echo "/etc/rc.local symbolic link file exists"

[ -d /etc/ ] && echo "/etc exists and it is a directory"
[ -f /etc/passwd ] && echo "/etc/passwd exists and it is a regular file"
[ -b /dev/sda1 ] && echo "/dev/sda1 exists and it is a block device"
[ -c /dev/tty1 ] && echo "/dev/tty1 exists and it is a character device"
[ ! -h /etc/rc.local ] && echo "/etc/rc.local exists but is not asymbolic link"

echo "1. type -p"
type -p ls # ls has been aliased; type -p does not work
echo "2. which is a bitch"
which ls

filename='/usr/bin/ls'
[ -r $filename ] && echo "You have read permission on $filename";
[ -w $filename ] && echo "You have write permission on $filename";
[ -x $filename ] && echo "You have execute permission on $filename";

filename='/tmp/file1'
[ -s /etc/passwd ] && echo "/etc/passwd is not empty"
touch "$filename"
[ ! -s /tmp/file1 ] && echo "/tmp/file1 is empty!"

# and with -a
state="CA"
capital="Sacramento"
[ $state == "CA" -a "$capital" == "Sacramento" ] && echo "California's capital is Sacramento!"

# or with -o
fruit="Orange"
[ "$fruit" == "Apple" -o "$fruit" == "Orange" ] && echo "$fruit is a fruit."

# negate with !
fruit="Egg"
[ ! "$fruit" == "Apple" -a ! "$fruit" == "Orange" ] && echo "$fruit is not a fruit."
# This does not work; needs [[ ]] (see belowe) 
# [ ! ( "$fruit" == "Apple" -o "$fruit" == "Orange" ) ] && echo "$fruit is not a fruit."

name="bond"
# 1. You can use pattern matching in [[ ]]
[ $name = bon* ] && echo "1.1. Good Morning, Mr. Bond"      # does not work with basic test
[[ $name = bon* ]] && echo "1.2. Good Morning, Mr. Bond"

# 2. You can use || && inside [[ ]]
[[ $name = super || $name = bon* ]] && echo "2. Good Morning, Mr. Hero"

# 3. You can use =~ for regular expression inside [[ ]]
[[ $name =~ ^b ]] && echo "3. Mr. $name, your name starts with "b""

i=1
for item in /etc/*.conf; do
    [[ $item =~ ^/etc/s.* ]] && echo "Config file $((i++)): $item"
done

i=1
for item in ~/Pictures/*; do
    [[ $item = *.jpg ]] && echo "Image $((i++)): $item"
done

# Input Redirection Using <
cat < /etc/passwd

# Output Redirection Using >
ls -l > /tmp/output.txt
cat /tmp/output.txt

# Append Using >>
ls -l ~/Temp/ >> /tmp/output.txt
cat /tmp/output.txt

# Error Redirection
# Using output redirection >, we can send the output of any command to a file.
# However, when the command displays an error, that doesn't go to the redirected file.
ls -l /etc/doesnotexist.conf > /tmp/output1.txt
cat /tmp/output1.txt

# We have to redirect the error messages.
ls -l /etc/doesnotexist.conf &>> /tmp/output1.txt      # append mode (>>)
ls -l /etc/doesnotexist.conf  >> /tmp/output1.txt 2>&1 # the same

cat /tmp/output1.txt

# pipes only the standard output, not the error:
ls -l /etc/doesnotexists.conf | wc

# pipes both standard output and error
ls -l /etc/doesnotexists.conf 2>&1 | wc

# |& is an easier way is to do the same
ls -l /etc/doesnotexists.conf |& wc

cat > /tmp/cities.txt <<EOF
Los Angeles
    Las Vegas
    San Francisco
Santa Monica
EOF

cat /tmp/cities.txt

# remove leading tabs with <<-EOF
# Note: <<-EOF removes only leading tabs and not leading spaces.
# Do this in a real shell with tabs. This kernel replaces tabs with spaces.
cat >> /tmp/cities.txt <<-EOF
Los Angeles
    Las Vegas
    San Francisco
Santa Monica
EOF

cat /tmp/cities.txt

rm /tmp/cities.txt

cat >> /tmp/newfile.txt <<< this-is-good

cat /tmp/newfile.txt

# Do this in a real shell
# wc -l <(ls /etc/; cat /etc/passwd; echo "Hello World")

# using diff to compare the output of two ls commands
# diff <(ls) <(ls -a)
# As we explained above, each <( ) creates a /dev/fd/xx file. If you add an
# echo command in front of the above diff statement, you can see that it
# is really doing the diff between the two /dev/fd/xx streams that contain
# the output of the corresponding ls commands.
# echo diff -w <(ls) <(ls -a)

# using diff to compare two directory listings
# diff <(ls /etc/) <(ls /backup/etc)

ls -l /etc/passwd /etc/junk

# Ignore the standard output.
ls -l /etc/passwd /etc/junk > /dev/null

# Ignore the standard error.
ls -l /etc/passwd /etc/junk 2> /dev/null

# Ignore both standard output and standard error.
ls -l /etc/passwd /etc/junk &> /dev/null

file=/tmp/tmpfile.txt
touch $file
[ -e $file ] && { rm $file || echo "Unable to delete $file"; }

# View Shell Variables
set

# Set Shell Options
set -o noglob

# Unset Shell Options
set +o noglob

# set --help
set -o noglob
set -f         # one character option; see "set --help"

# view all the current shell options that are set
echo $-

# unset option
set +o noglob
set +f         # one character option

coproc CUSTOM { ls -l; sleep 2; cat /etc/passwd; sleep 2; }
echo "CUSTOM_PID=$CUSTOM_PID"
echo "CUSTOM[0]=${CUSTOM[0]}"
echo "CUSTOM[1]=${CUSTOM[1]}"

echo $PASSWD

# show all environment variables
export

# show all environment variables
# same as above
declare -x

# create an environment variable use "export" or "declare -x"
export PASSWD=/etc/passwd
declare -x PASSWD=/etc/passwd   # the same

# erase environment variable
unset PASSWD

# See all OS signals
man 7 signal

trap 'echo Debugging day=$day i=$i' DEBUG

i=1
for day in Mon Tue Wed Thu Fri; do
    echo "Weekday $((i++)) : $day"
    if [ $i -eq 3 ]; then
        break;
    fi
done

declare -l small
small="THIS IS ACTUALLY ALL LOWER CASE!"
echo $small

declare -c capital
capital="this is small and BIG!"
echo $capital   # First letter is upper case the rest lower case

echo "Wrapper for tar command"
echo " Doing some pre processing"
exec "/bin/tar" "$@"
echo " Doing some post processing"   # This will never be executed!

# This is a single line comment
echo "This is a partial line comment"   # This is a partial line comment

# The word COMMENT is arbitrarily chosen
: <<COMMENT
-------------------------------------------
This is a multi-line comment
-------------------------------------------
COMMENT

# Comment large blocks of code temporarily
: <<TEMP
for i in "${array[@]}"; do
    echo $i
done
TEMP

# You can use a real shell to try out this example.
function function1 {
    caller
}

function function2 {
    caller 0
}

function1
function1
function2
function2

city1="Los Angeles"
city2="San Francisco"
city3="New York"
echo "${!city*}"

for varname in ${!city*}; do
    echo $varname
done

# define a pointer to a variable name
city_in_california="Los Angeles"
echo "1. $city_in_california"
pointer=${!city_in_california}          # expand "city_in_california; there is only one"
echo "2. $pointer"
var=${!pointer}                         # expand "pointer"
echo "3. $var"

echo "To Lowercase"
string="A FEW WORDS"
echo "1. ${string} -> ${string,}"
echo "2. ${string} -> ${string,,}"
echo "3. ${string} -> ${string,,[AEIUO]}"   # lowercase only vowels
echo "-----------------------"
echo "To Uppercase"
string="a few words"
echo "4. ${string} -> ${string^}"
echo "5. ${string} -> ${string^^}"
echo "6. ${string} -> ${string^^[aeiou]}"      # uppercase only vowels
echo "-----------------------"
echo "Toggle Case"
string="A Few Words"
echo "7. ${string} -> ${string~~}"
string="A FEW WORDS"
echo "8. ${string} -> ${string~}"
string="a few words"
echo "9. ${string} -> ${string~}"

#       01234567890
#       09876543210
string="A Few Words"
echo "1. ${string:6}"
echo "2. ${string:0:5}"
echo "3. ${string:3}"
echo "4. ${string::-6}"

city="Los Angeles"
echo "${city/Angeles/Altos}"
echo "${city/e/E}"
echo "${city//e/E}"               # global replacement
echo "${city/Los /}"              # delete substring
echo "${city/#Los/City of Los}"   # prefix find and replace
echo "${city/%Angeles/Altos}"     # suffix find and replace

basename /usr/local/share/doc/foo/foo.txt

dirname /usr/local/share/doc/foo/foo.txt

dirname /usr/local/share/doc/foo

basename /usr/local/share/doc/foo/

MYVAR=foodforthought.jpg

# chop off longest substring from the beginning
echo ${MYVAR##*fo}

# chop off shortest substring from the beginning
echo ${MYVAR#*fo}

# chop from the end
MYFOO="chickensoup.tar.gz"
echo ${MYFOO%%.*}
echo ${MYFOO%.*}

MYFOOD="chickensoup"
echo ${MYFOOD%%soup}    # the asterisk is not necessary

EXCLAIM=cowabunga
echo ${EXCLAIM:0:3}
echo ${EXCLAIM:3:7}

function check_file_extension {
    if [ "${1##*.}" = "tar" ]; then
        echo This appears to be a tarball.
    else
        echo At first glance, this does not appear to be a tarball.
    fi
}

check_file_extension file.tar
check_file_extension file.tgz

file="mydocument.txt"
echo "$file -> ${file%.txt}"      # use string substitution to remove file extensions
echo ${file%.txt}.doc
for file in file1.txt file2.txt file3.txt; do
    echo mv $file ${file%.txt}.doc
done

# RANDOM
# Reading a file

type -t getopts
