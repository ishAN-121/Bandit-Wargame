#! bin/bash 
 echo "============================"
 echo "Welcome to Github Portal"
 echo "============================"


username=$GIT_USERNAME
token=$GITHUB_TOKEN
if [ -z "$token"]; then
echo "Github token is not set.Enter your personal github access token "
read -s token
fi

if [ -z "$username"]; then
echo "Github username is not set.Enter your github username"
read username
fi
echo "Enter Repository name "
read reponame
while ! [[ "$reponame" =~ ^[a-zA-Z0-9_]$ ]]
do
echo "Wrong repo name.Enter again."
read reponame
done


git config --global credential.helper store
git config --global credential.https://github.com.username $username
git config --global credential.https://github.com.password $token





create_repo(){
echo "Enter 1 for a public repo and 2 for a private repo"
read val
if [ "$val" -eq 1 ]; then
repo_type=false

else 
repo_type=true
fi
echo "Enter description"
read description
check=$(curl -s https://api.github.com/repos/username/reponame | awk '/message/{print $2 $3}')

if [ "$check" == *"NotFound"* ]; then
echo "Repository already exists exiting ...."
exit 1
fi


curl  -L -s -X POST H "Accept: application/vnd.github+json" -H "Authorization: Bearer $token" https://api.github.com/user/repos -d "{\"name\":\"$reponame\",\"description\":\"$description\",\"private\":\"$repo_type\"}" > /dev/null

if [ $? -eq 0 ]; then
 echo "Repository created successfully!"
 else 
 echo "Failed to create" 
 exit
fi
choose_directory
}

choose_directory(){
     echo "To create a new directory press 1 or To add the current directory press 2"
    read val
    if [ "$val" -eq 1 ]; then
    mkdir "$reponame"
    cd "$reponame"
    echo "Enter the filename for the repo"
    read filename
    echo "Enter the file's content in nano and save the file"
    nano "$filename"
    commit

    elif [ "$val" -eq 2 ]; then
    commit
    fi
}

commit(){
    git init
    git add .
    git branch -m master main
    echo "Enter commit message"
    read commit_m
    git commit -m "$commit_m"
    git remote add origin "https://github.com/$username/$reponame.git"
    git push origin main
    
}
create_repo