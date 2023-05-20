#! /bin/bash 
 echo "==================="
 echo "Welcome to GPG Portal"
 echo "==================="

 if which gpg >/dev/null ; then
    echo "GPG installed"
  else
    echo "GPG not installed"
    exit 1
fi

 if which git >/dev/null; then
    echo "Git is Installed"
else
 echo "Git not Installed"
 exit 1

fi
generate(){
  echo "Generating a new key ..."
  gpg --full-generate-key
  concatenatedkeys=$(gpg --list-secret-keys --keyid-format=long | awk '/sec/{print $2}' ) #gives us all the keys including rsa4069 separated by spaces
  keys=($(echo $concatenatedkeys)) #creates a array of keys including rsa
  pseudogpgkey=($(echo ${keys[-1]} | tr '/' ' ')) # last key conatins our new gpgid so removing / from that and creating array
  gpgkey=${pseudogpgkey[1]} #gives us the gpgkeyid
  git config --global --unset gpg.format
  git config --global user.signingkey "$gpgkey"
  git config --global commit.gpgsign true
  gpg --armor --export $gpgkey

}

gpgsetup(){
  if ! gpg --list-secret-keys --keyid-format=long | grep -q "sec" ; 
  then
  echo "No GPG key found. Generating a new key..."
  generate

  else
    
    gpg --list-secret-keys --keyid-format=long
    echo "Copy the GPG key from sec and paste it"
    read key_id
    git config --global --unset gpg.format
    git config --global user.signingkey "$key_id"
    echo "Enter your name"
    read name
    git config --global user.name "$name"
    echo "Enter your email id"
    read email
    git config --global user.email "$email"
    git config --global commit.gpgsign true
    gpg --armor --export "$key_id"
    echo "Copy the public GPG key and paste in the github"

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
