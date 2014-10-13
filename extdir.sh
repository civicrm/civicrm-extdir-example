#!/bin/bash
set -e

###########################################################################
#### Define configuration
function do_init() {
  ## The base directory of the extension repository
  if [ -z "$REPO" ]; then
    REPO="."
  fi
  
  pushd "$REPO" >> /dev/null
    ## The file listing
    INDEX="$(pwd)/index.html"
  
    ## The public download URL
    if [ -z "$DL_URL" -a -n `which amp` ]; then
      if amp export -Ncms --prefix=CMS_ >> /dev/null ; then
        eval $(amp export -Ncms --prefix=CMS_)
        DL_URL="$CMS_URL"
      fi
    fi
    if [ -z "$DL_URL" ]; then
      echo "Failed to determine DL_URL. If not using buildkit, then you must manually set DL_URL."
      exit 2
    fi
  popd >> /dev/null
}

###########################################################################
#### Helper: Build the zip/xml/html files
function do_make() {
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
}

###########################################################################
## Helper: Cleanup
function do_clean() {
  pushd "$REPO" >> /dev/null
    for file in index.html *.xml ; do
      [ -f "$file" ] && rm -f "$file"
    done
    [ -d "zips" ] && rm -rf zips
  popd >> /dev/null
}

###########################################################################
## Main
case "$1" in
  make)
    do_init
    do_clean
    do_make
    ;;
  clean)
    do_init
    do_clean
    ;;
  *)
    echo "extdir.sh - Rudimentary build script for a local extensions directory"
    echo "examples:"
    echo "  $0 make"
    echo "  $0 clean"
    echo "  env DL_URL=http://localhost/extdir $0 make"
    echo "  env DL_URL=http://localhost/extdir $0 clean"
    exit 1
esac
