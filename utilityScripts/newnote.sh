#!/bin/bash
USER_DESKTOP="C:\Users\tommy.lane\Desktop"
BASE_NOTES_DIR="${USER_DESKTOP}/Notes"
CURRENT_DATE=`date "+%Y_%m_%d_%s"`
TODO_OPTIONS='TODO InProgress(i) Rejected(R) | BackBurner(B) DONE(D) Cancelled(c)'

function spaceToUnderscore()
{
	RESULT="`echo "$@" | sed 's/ /_/g'`"
}


function getPromptResponseEscaped()
{
	read -p "$@" answer
	spaceToUnderscore $answer
}

getPromptResponseEscaped "Which Project is this for?: "
Project=$RESULT


read -p "What title for this new note?: " user_title
spaceToUnderscore $user_title
Title=$RESULT


filePrefix="${CURRENT_DATE}_${Title}"
fileName="${Title}.org"
Folder="${BASE_NOTES_DIR}/${Project}/${filePrefix}"
if [ ! -d $Folder ]
then
	mkdir -p $Folder
fi

filePath="${Folder}/${fileName}"
touch $filePath && \
echo "#+TITLE: ${user_title}" >> $filePath && \
echo "#+TODO: ${TODO_OPTIONS}" >> $filePath && \
echo "" >> $filePath && \
sync && \
"C:\Program Files\Emacs\x86_64\bin\runemacs.exe" "$filePath"
cd $Folder
"explorer.exe" ".\\"
