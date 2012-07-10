#!/bin/bash

PATH_TO_LESSC="lessc";
OTHER_PATH="./path_to_lessc";

#if other path is specified in OTHER_PATH variable, read it
if [ -f $OTHER_PATH ] 
then
    PATH_TO_LESSC=`cat $OTHER_PATH`;
fi

#perform compilation
for LESS in `find . -name *.less`
do
    BASE_NAME=${LESS%.less}
    case $1 in
        "clean")
            rm -f ${BASE_NAME}.css
            ;;
        "compile")
            if [ -f "${BASE_NAME}.css" ]
            then
                echo "WARNING: CSS file ${BASE_NAME}.css exists. Rewriting..."
            fi
            sed 's/^\(.*background:\s*url(.\)\(.*\)\(.).*;\)\s*\/\/URLPREFIX\s*\(.*\)\s*$/\1\4\2\3 \/\/URLPREFIX \4/g' $LESS > $LESS.copy
            $PATH_TO_LESSC -x $LESS.copy > ${BASE_NAME}.css
            rm $LESS.copy
            ;;
        *)
            echo "Usage: 'lessproc compile' OR 'lessproc clean'";
            exit 1;
            ;;
    esac
done
exit 0;
