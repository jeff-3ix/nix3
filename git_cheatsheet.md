`git init`
Start git in a directory

`git add <files>`

`git commit -a -m "message"`
Stage and commit with commit message in command line.

`git log`

`git log --one-line`

`git push origin main` can later be just `git push`

`git pull main origin` can later be just `git pull`

`git status`

`git branch`
Show git branches

`git switch -c <new_branch>`
Create new git branch and switch into it

`git switch main`
Switch back into main branch


## To Merge Experimental Branch Back into Main
(in <exp_branch>)
`git status`
Then commit anything that is needed

`git switch main`

`git pull --ff-only`
Make sure main in uptodate 

`git merge <exp_branch>`
If No conflicts --> done.
If conflicts --> Git stops and tell you which files need attention.
`git status`
To see conflicted files. Open them, resolve the <<<<< ===== >>>>> sections, then
```
git add <resolved-files> 
git commit
```

`git push origin main`

## Clean up:

`git branch -d <old_branch>`
Delete local branch <old_branch>

`git push origin --delete <old_branch>`
Delete GitHub version of branch <old_branch>