## Make sure hidden files from previous year are deleted (includes .git folder)
### You can view hidden files by pressing "Command + Shift + ." on a Mac, or "Control + Shift + ." on Windows
## Go to Github, then repository page, then click "New"
## Make name for repository, then click "Create repository"
## Copy the code below and paste into terminal, making sure to edit the repository name if needed


git init
git remote add origin git@github.com:nwakim/PUBH_523_26Su.git
git branch -M main
git add --all
git commit -m "first commit"
git push -u origin main