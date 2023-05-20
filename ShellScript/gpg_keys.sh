#! /bin/bash 
 echo "==================="
 echo "Welcome to GPG Portal"
 echo "==================="

 if which gpg >/dev/null ; then
    echo "GPG installed"
  else
    echo "GPG not installed"
    echo "Download GPG from https://gnupg.org/download/"
    exit 1
fi

 if which git >/dev/null; then
    echo "Git is Installed"
else
 echo "Git not Installed"
 echo "For installation refer to https://git-scm.com/downloads"
 exit 1

fi
config(){
  possiblegpgkey1=$(generate)
  possiblegpgkey2=$1
  if [ -z "$possiblegpgkey1" ]; then
  gpgkey=$possiblegpgkey2
  else 
  gpgkey=$possiblegpgkey1
  fi
   git config --global --unset gpg.format
  git config --global user.signingkey "$gpgkey"
  git config --global commit.gpgsign true
  gpg --armor --export $gpgkey
  echo "Copy the public GPG key and paste in the github"


}
generate(){
  echo "Generating a new key ..."
  gpg --full-generate-key
  concatenatedkeys=$(gpg --list-secret-keys --keyid-format=long | awk '/sec/{print $2}' ) #gives us all the keys including rsa4069 separated by spaces
  keys=($(echo $concatenatedkeys)) #creates a array of keys including rsa
  pseudogpgkey=($(echo ${keys[-1]} | tr '/' ' ')) # last key conatins our new gpgid so removing / from that and creating array
  gpgkeyid=${pseudogpgkey[1]} #gives us the gpgkeyid
  echo $gpgkeyid
 }

gpgsetup(){
  if ! gpg --list-secret-keys --keyid-format=long | grep -q "sec" ; 
  then
  echo "No GPG key found. Generating a new key..."
  generate

  else
    
    gpg --list-secret-keys --keyid-format=long
    echo "Copy the GPG key from sec after rsa4069 and before date and paste it "
    read key_id
    config $key_id

fi


}
delete(){
 gpg --list-secret-keys --keyid-format=long
 echo "Copy the key to be deleted in sec"
 read key
 gpg --delete-secret-key "$key"
 gpg --delete-key "$key"

}

echo "Choose from the options"
echo "Press 1 for signing in existing GPG key"
echo "Press 2 for creating a new GPG key"
echo "Press 3 for deleting a GPG key"

read input 

if [ "$input" -eq 1 ]; then
gpgsetup

elif [ "$input" -eq 2 ]; then
generate

elif [ "$input" -eq 3 ]; then
delete

fi
