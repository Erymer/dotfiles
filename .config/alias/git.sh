# GIT
# Source https://gist.github.com/digitaljhelms/4287848
gitu() {
    comment=$1

    git pull
    git add . &&
    git commit -m "${comment}" &&
    git push
}

gitnb() {
    # Creates new branch
    name=$1

    git checkout -b "${name}" && # Creates new branch
    git push origin "${name}" # pushes new branch to remote repository
}

gitmerge(){
    # Merge branch to master
    branch=$1

    git checkout main && # Changes to main/master branch
    git merge --no-ff "${branch}" && # makes sure to create a commit object during merge
    git push origin main && # push merge changes
    git push origin :"${branch}" # deletes the remote branch
}

 
gitsetremote(){
    # This is for when you first create the remote repository and then clone in
    # locally
    # Used to enable push in remote repositories using ssh keys
    # source https://gist.github.com/xirixiz/b6b0c6f4917ce17a90e00f9b60566278

    username=$1
    repository=$2

    git remote set-url origin git@github.com:"${username}"/"${repository}"

}

gitsetlocal(){
    # This is for when you first create a local repository and then you want to
    # upload this local repository to a remote github repository.
    # This enables push using ssh keys

    username=$1
    repository=$2
    git remote add origin https://github.com/"${username}"/"${repository}".git && \
    git remote set-url origin git@github.com:"${username}"/"${repository}" && \
    git push -u origin main &&

}
