posts=/tmp/onstartups/posts

xmllint --xpath '/posts/row[@PostTypeId="1"]/@Id' $posts.xml | \
  sed 's/[^0-9\ ]*//g' | \
  tr ' ' '\n' > $posts

while read i; do
  curl -o$i.html http://localhost:8080/answers.onstartups.com/$i
done < "$posts"
