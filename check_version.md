## Use this link to get the latest version from github api

curl -s https://api.github.com/repos/Vaishnav-Sabari-Girish/arduino-cli-interactive/releases/latest | jq -r '.tag_name'
v1.0.2

## To check between 2 versions (strings) in bash use 

```bash
if test $string1 = $string2 
then
  echo "Equal"
else 
  echo "Not Equal"
fi
```
