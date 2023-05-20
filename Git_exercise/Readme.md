# GIT  Exercise
##  Master
`
 git start master
`
for verification
##  Commit-One-File
`git start next` to start the next exercise

`git add A.txt` to add A

`git commit -m "A added to commit"`

`git verify` to verify and start next exercise

## Commit-One-File-staged

`git restore --staged B.txt`

Removes B from the staging area

git commit -m`A added to commit

`git verify` to verify and start next exercise

## Ignore Them

`nano .gitignore` It will create a .gitignore file.

We add 

`*.exe
*.o
*.jar
libraries/`

in the file

`git add .gitignore` Add gitignore file

` git commit -m "Ignore unwanted files"` Commit all the files

` git verify` Next level

## Start Chase-Branch

Initial

```

HEAD
|
chase-branch    escaped
|                 |
A <----- B <----- C
```

Final
```
               escaped
                  |
A <----- B <----- C
                  |
            chase-branch
                  |
                 HEAD
```

`git merge` This command merges the chase branch which is also head with escaped branch. So they point to same commit.
`git verify` Next Level


##  Merge-Conflict


Initial tree
```
        HEAD
         |
   merge-conflict
         |
A <----- B
\
  \----- C
         |
another-piece-of-work

```
Final

```

                HEAD
                  |
             merge-conflict
                  |
A <----- B <----- D
 \               /
  \----- C <----/
         |
another-piece-of-work

```
`git merge another-piece-of-work` gives merge conflict in equation.txt

`cat equation.txt` gives 

```<<<<<<< HEAD

2 + ? = 5    
=======
? + 3 = 5
>>>>>>> another-piece-of-work

```
We can see the conflict. In order to remove conflict we  change it to `2+3 = 5` and then run 

```shell
git add equation.txt 

git commit -m "conflict resolved"

git verify # Next Level
```

add equation.txt again, commit it and verify to move to next level.

## Save-Your-Work

`git stash` to save your work on the side.

`nano bug.txt` to open bug file in editor and remove the line 

`THIS IS A BUG - remove the whole line to fix it.`

remove this line and save the file.

`git add bug.txt `

`git commit -m "bug fix"`

Add and commit the bug file.

Now we pop the stash and merge it with bug.

`$ git stash pop

Auto-merging bug.txt
On branch save-your-work

Your branch is ahead of 'origin/save-your-work' by 2 commits.

  (use "git push" to publish your local commits)`

  Now, add "Finally, finished it!" line to bug through

  `nano bug.txt`

  and then do final add and commit.

  `git add bug.txt program.txt `

 ` git commit -m "final commit" `

  `git verify`

## Change-Branch-History

We have to change the history of commits so we just use git rebase.

` git rebase hot-bugfix`

` git verify`

 rebase changes our commit history and makes our current branch point to hot-bugfix.
 
 ## Remove - Ignored

` git rm --cached ignored.txt` 

The command removes ignored.txt from index area.

`git commit -m "remove ignored.txt"`

`git verify` 

 ## Case - Sensitive-Filename
 
  `git mv File.txt file.txt`

  ` git add file.txt`

  ` git commit -m "renamed file"`

  ` git verify`

  git mv changes the file name without changing commit history.
  
## Fix-Typo

`nano file.txt`

Change wordl to world

`git add file.txt` add file

`git commit --amend` change the commit message

`git verify` Next Level

## Forge Date

` git commit --amend --no-edit --date "Sat 20 May 1987 12:52:34 IST"`

The command changes the date.

`git verify` Next Level

## Fix Old Typo

To reach the older commits we use 

`git rebase -i`

We need to change the last second commit so we change pick to edit in the editor.

then use `nano.txt` to remove the error.

`git add file.txt`

`git commit --amend` To change the commit message

`git rebase --continue` to continue to the next commit

There is a merge conflict.

Use `nano file.txt` to solve merge conflict.

Then `add file.txt`

`git rebase --continue` If you want to change the commit message you can but no need.

`git verify`

  


