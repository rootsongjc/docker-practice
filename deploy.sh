#/bin/bash
echo -e "\033[0;32mDeploying updates to GitHub...\033[0m"
name="docker-handbook"
# Build the project.
gitbook build . _book
rm -f _book/gitbook/images/*
cp images/favicon.ico _book/gitbook/images/
cp -r _book/* ../$name-gh-pages

# Go To github pages folder
cd ../$name-gh-pages

# Add changes to git.
git add -A

# Commit changes.

git commit -m "$1"

# Push source and build repos.
git push origin gh-pages

# Come Back
cd ../$name
