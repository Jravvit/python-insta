gitbook install && gitbook build
cp -R _book/* .
git clean -fx _book
git add ./
git commit -a -m "Update docs"
git push
