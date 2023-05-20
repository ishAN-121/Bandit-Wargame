## Level 0
 `ssh bandit0@bandit.labs.overthewire.org -p 2220`

 ssh connects to the remote server om port 2220 with username bandit0.


## Level 0 to 1

`ls -a` shows all the file in the current directory.

`cat readme` reads the file to give us the password - NH2SXQwcBdpmTEzi3bvBHMM9H66vVXjL

exit command to leave the server

## Level 1 to 2

`ssh bandit1@bandit.labs.overthewire.org -p 2220`

`ls -a` to list all files.

password is in - file but we cannot use cat on - directly as it is a special character.

So we have to use `cat  ./-` i.e. write the whole path to make sure - is a file.

password - rRGizSaX8Mk1RTb1CNQoXTcYZWU6lgzi

exit

## Level 2 to 3
`ssh bandit2@bandit.labs.overthewire.org -p 2220` to log in.

`ls`
`cat "spaces in this filename" ` as there are space in the filename we use     "filename"

password - aBZ0W5EmUfAf7kHTQeOwd8bauFJ2lAiG

exit

## Level 3 to 4

`ssh bandit3@bandit.labs.overthewire.org -p 2220` to log in.

`cd` to move to inhere directory.

`ls -a` to show all files including hidden file as password is in hidden file.

`cat .hidden` to get the password.

password - 2EW7BBsr6aMMoJ2HjW067dm8EgX26xNe

exit

## Level 4 to 5

`ssh bandit4@bandit.labs.overthewire.org -p 2220` to log in.

`cd inhere` to move to inhere directory

`ls -ah` to show all human readable files,

there are 10 files seen as human readable.

`file ./` helps to find the type of all the files. We use ./  since all the filenames start with  - .

-file 07 is of ASCII text so we do **cat ./-file07** to get password.

lrIWWI6bB37kxfiCQZqUdOIYfr6eEeqR 

exit

## Level 5 to 6

`ssh bandit5@bandit.labs.overthewire.org -p 2220` to log in.

`cd inhere`

`ls -a` shows us that there are 20 directories.

`find . -type f -size 1033c -readable ! -executable`

. tells to find in current directory

-type f to find files, -size to find files of 1033 bytes , readable to make sure file is readable, ! -executable to make sure file is not executable.

the command gives us a single output.

so we use `cat ./maybehere07/.file2` to get password.

flag - P4L4vucdmLnm8I7Vl7jG1ApGSfjYKqJU

exit



## Level 6 to 7
`ssh bandit6@bandit.labs.overthewire.org -p 2220` to log in.

`find . -user bandit7 -group bandit6 -size 33c` does not give an output so the password is not in the current directory.

It is `located somewhere on the server` so we move to the topmost directory in the tree which is /.

`cd ../..`

Now using `find . -user bandit7 -group bandit6 -size 33c` gives an output with many files with permission denied.

So we use

`find . -user bandit7 -group bandit6 -size 33c 2>/dev/null`

user specifies the owner group specifies group.

2 represents stderr and 2>/dev/null acts as a black hole to remove all the permission error files.

`cat ./var/lib/dpkg/info/bandit7.password`

password - z7WtoNQU2XfjmMtWA8u5rN4vzqu4v99S

exit


## Level 7 to 8
`ssh bandit7@bandit.labs.overthewire.org -p 2220` to log in.

`cat data.txt | grep 'millionth'` cat reads the file and grep searches for millionth as a filter.  | is the pipe operator that takes output of one command and use it as input for another.

password - TESKZC0XvTetK0S9xNwm25STk5iWrBvP

exit

## Level 8 to 9

`ssh bandit8@bandit.labs.overthewire.org -p 2220` to log in.

password is in the line which comes once only so we use 

`cat data.txt | sort | uniq -u`

cat reads the file and then sort sorts the file linewise. uniq -u gives only the unique line by removing the lines that come more than once adjacently.

uniq works by checking if the line is repeated adjacentally or not. So we need to use sort before uniq.

password - EN632PlfYiZbn3PhVK3XOGSlNInNE00t

exit

tip - use clear after every level to clear the terminal.

## Level 9 to 10
`ssh bandit9@bandit.labs.overthewire.org -p 2220` to log in.

The password for the next level is stored in the file `data.txt` in one of the few human-readable strings, preceded by several ‘=’ characters.

So we use `strings data.txt | grep "="`

The strings command read the strings from data.txt and grep gives us the password.

password - G7w8LIi6J3kTb8A7j9LgrywtEUlyyp6s

exit



## Level 10 to 11

`ssh bandit10@bandit.labs.overthewire.org -p 2220` to log in.

The password is in base64 form. So we use base64 -d to decode it 

`cat data.txt | base64 -d`

password - 6zPeziLdR2RKNdNYFNb6nVCKzphlXHBM

exit

## Level 11 to 12

`ssh bandit11@bandit.labs.overthewire.org -p 2220` to log in.

We need to rotate the letters by 13 positions.

So we use `cat data.txt | tr [a-zA-Z] [n-za-mN-ZA-M]`

a-z is broken into a-m and n-z which gets converted to n-z and a-m. Similar for upper case. In essence tr does a mapping form one set to another.

password -  JVNBBFSmZwKKOP0XbFXOoW8chDz5yVRv

exit


## Level 12 to 13

`ssh bandit12@bandit.labs.overthewire.org -p 2220` to log in.

`mkdir /tmp/copy` creates a directory.

`cp data.txt /tmp/copy` creates a copy of data.txt in the directory.

We now move to the `copy` directory.

Using `xxd -r data.txt cdata` we uncompress the hexdump into cdata

Now `file cdata` tells us the file type of cdata  which is gzip.

Now every time we decompress the file using the suitable command , then check the file type , rename the file according to suitable filetype and then decompress again till the file type is ASCII text. The commands are 

`mv cdata cdata.gz` to make gzip file

`gzip -d cdata.gz` decompress gzip file

`mv cdata data.bz2` to make bzip2 file

`bzip2 -d data.bz2` to decompress bzip2 file

`mv data data.tar` to make tar file

`tar -xvf data.tar` to decompress tar file

Final **cat data** gives us password wbWdlBxEir4CaE8LaPhauuOo6pwRmrDw

exit


## Level 13 to 14

`ssh bandit13@bandit.labs.overthewire.org -p 2220` to log in.

We need to log in as user `bandit14` using the private ssh key available to us.

The command is 

`ssh bandit14@localhost -i sshkey.private`

We have chose local host since we are already on the bandit server.

-i flag is the identity file used for private key authentication.

Then we change to directory `cd /etc/bandit_pass`

and cat bandit 14

password - fGrHPx402xGC7U7rXKDaxiWFTOiF0ENq

exit

## Level 14 to 15
`ssh bandit14@bandit.labs.overthewire.org -p 2220` to log in.

We need to establish a connection to the localhost on the port 30000.

So we use telnet command.

`telnet localhost 30000`

Now we send password to the the host and receive 

jN2kgmIXJ6fShzhT2avhotn4Zcka6tnt

exit



## Level 15 to 16
`ssh bandit15@bandit.labs.overthewire.org -p 2220` to log in.

We need to establish connection on port 30001 using openssl on local host

We use `openssl s_client -connect localhost:30001 -ign_eof`

and then type previous password and then get the new password.

JQttfApK4SeyHwDlI9SXGR50qclOAil1

exit



## Level 16 to 17

`ssh bandit16@bandit.labs.overthewire.org -p 2220`  to log in.

`nmap localhost -p31000-32000` is used to filter the ports.

It gives us 5 ports which are open. We can connect to them one by one. 

The one which connects is port 31790.

Here we get the private rsa key 

`exit`
We save the key in our computer using `nano shell.private` and change the 
permissions as `chmod 400 ssh.private` as required by the private keys.





## Level 17 to 18

`ssh bandit17@bandit.labs.overthewire.org -p 2220 -i ssh.private` to log in using the private key which we have stored in our previous level.

We will use diff command to compare line by line.

`diff passwords.new passwords.old`

password - hga5tuuCLF6fFzUpnagiMN8ssu9LFrdg

exit


## Level 18 to 19

`ssh bandit18@bandit.labs.overthewire.org -p 2220` to log in.

But using above command will lead us to log out.

There is fraction of seconds before we logout.

So we add command with ssh to get password.

`ssh bandit18@bandit.labs.overthewire.org -p 2220 cat readme`

password - awhqfNnAbc1naukrpqDYcF95h7HoMTrC

exit

## Level 19 to 20
`ssh bandit19@bandit.labs.overthewire.org -p 2220` to log in.

When we do ls-la on bandit_pass library we observe that it requires bandit20 as user to see it.

So we run the bandit20-do and see that it allows us to run commands as bandit20 user.

`./bandit20-do`

after that we cat the bandit20 in bandit_pass.

`./bandit20-do cat /etc/bandit_pass/bandit20`

password - VxCazJaVykI6W36BkBU0mJTCM8rR95XT

exit

## Level 20 to 21
`ssh bandit20@bandit.labs.overthewire.org -p 2220` to log in.

We need to send the previous level password over the connection to get new password.

So we need two terminals to set a connection between two. 

Log in to bandit level 20 from both.

On one terminal setup the server and on another we will use the setuid.

**Server**
`nc -l 10000`

-l is listen command that opens the port 10000 for connections.

**Client** 

suconnect is the binary that is needed to connect to our localhost.

`./suconnect 10000`

Now connection is established.

**Server**
Now type the password from the previous level which is checked and we get the next password on this screen.

password - NvEJF7oVjkddltPSrdKEFOllh9V1IBcq

`exit` on both terminals.


