# git-windows-batch-scripts-auto-update-microsservices-repositories
git windows batch scripts for auto updating microsservices repositories on a windows folder

The update.bat batch script basically does a git pull in every folder of the current path.

The master_update.bat script changes every repository in the current folder to the MAIN or MASTER branch and runs a git pull on it, if any error happens it awaits for user input, on success it also awaits for user input before closing.


The master-update-with-merge script follows these steps:

1- Save the current branch name in a variable

2- Checkout to MASTER or MAIN

3- Run a git pull on the repository

4- Go back to the branch it was before the checkout

5- Run a git merge with master or main


The master-update-with-merge-push script follows these steps:

1- Save the current branch name in a variable

2- Checkout to MASTER or MAIN

3- Run a git pull on the repository

4- Go back to the branch it was before the checkout

5- Run a git merge with master or main

6- Run a git push to sync local with remote
