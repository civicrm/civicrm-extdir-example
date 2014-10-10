#!/bin/bash
set -e

## usage (if you've installed via buildkit and have buildkit in the path)
##  bash make.sh
## usage (if you've installed manually to http://localhost/)
##  env DL_URL=http://localhost/ bash make.sh

###########################################################################
#### Define configuration
## The base directory of the extension repository
if [ -z "$REPO" ]; then
  REPO="."
fi

pushd "$REPO" >> /dev/null
  ## The file listing
  INDEX="$(pwd)/index.html"

  ## The public download URL
  if [ -z "$DL_URL" -a -n `which amp` ]; then
    eval $(amp export -Ncms --prefix=CMS_)
    DL_URL="$CMS_URL"
  fi
  if [ -z "$DL_URL" ]; then
    echo "Failed to determine DL_URL. Perhaps you should set the DL_URL environment variable?"
    exit 2
  fi
popd >> /dev/null

###########################################################################
#### Build the zip/xml/html files

pushd "$REPO" >> /dev/null
  [ ! -d zips ] && mkdir zips

  echo "<html><body><ul>" > "$INDEX"

  find -maxdepth 1 -mindepth 1 -type d  | while read DIR ; do
    EXT=$(basename "$DIR")
    set -x

    if [ -f "$EXT/info.xml" ]; then
      [ -f "zips/$EXT.zip" ]  && rm -f "zips/$EXT.zip"
      zip -r "zips/$EXT.zip" $EXT -x '*~' '*/.git/*'
      cat "$EXT/info.xml" | sed "s;</extension>;  <downloadUrl>$DL_URL/zips/$EXT.zip</downloadUrl></extension>;" > "$EXT.xml"
      echo "<li><a href="$EXT.xml">$EXT.xml</a></li>" >> "$INDEX"
    fi

    set +x
  done
  
  echo "</ul></body></html>" >> "$INDEX"
popd >> /dev/null
