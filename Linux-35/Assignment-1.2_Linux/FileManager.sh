#!/bin/bash

case "$1" in

# ---------- Directory Operations ----------

addDir)
    mkdir -p "$2/$3"
    echo "Directory '$3' created successfully....."
    ;;

deleteDir)
    rm -rf "$2/$3"
    echo "Directory '$3' deleted successfully....."
    ;;

listFiles)
    echo "Files in $2......"
    find "$2" -maxdepth 1 -type f -printf "%f\n"
    ;;

listDirs)
    echo "Directories in $2......"
    find "$2" -maxdepth 1 -type d -printf "%f\n" | grep -v "^.$"
    ;;

listAll)
    echo "Contents of $2....."
    ls -l "$2"
    ;;



# ---------- File Operations ----------

addFile)

    if [ -z "$4" ]
    then
        touch "$2/$3"
        echo "File '$3' created....."
    else
        echo "$4" > "$2/$3"
        echo "File '$3' created with initial content....."
    fi
    ;;



addContentToFile)

    echo "$4" >> "$2/$3"
    echo "Content added successfully....."
    ;;

addContentToFileBegining)

    (echo "$4"; cat "$2/$3") > /tmp/tempfile
    mv /tmp/tempfile "$2/$3"
    echo "Content added at beginning....."
    ;;

showFileBeginingContent)

    head -n "$4" "$2/$3"
    ;;

showFileEndContent)

    tail -n "$4" "$2/$3"
    ;;

showFileContentAtLine)

    sed -n "${4}p" "$2/$3"
    ;;

showFileContentForLineRange)

    sed -n "${4},${5}p" "$2/$3"
    ;;

moveFile)

    mv "$2" "$3"
    echo "File moved successfully....."
    ;;

copyFile)

    cp "$2" "$3"
    echo "File copied successfully....."
    ;;

clearFileContent)

    > "$2/$3"
    echo "File content cleared....."
    ;;

deleteFile)

    rm "$2/$3"
    echo "File deleted successfully....."
    ;;

*)

    echo "Invalid Command!"
    echo ""
    echo "Usage:"
    echo " Directory Commands"
    echo "  ./FileManager.sh addDir <path> <dirname>"
    echo "  ./FileManager.sh deleteDir <path> <dirname>"
    echo "  ./FileManager.sh listFiles <path>"
    echo "  ./FileManager.sh listDirs <path>"
    echo "  ./FileManager.sh listAll <path>"
    echo ""
    echo " File Commands"
    echo "  ./FileManager.sh addFile <path> <filename> [content]"
    echo "  ./FileManager.sh addContentToFile <path> <filename> <content>"
    echo "  ./FileManager.sh addContentToFileBegining <path> <filename> <content>"
    echo "  ./FileManager.sh showFileBeginingContent <path> <filename> <n>"
    echo "  ./FileManager.sh showFileEndContent <path> <filename> <n>"
    echo "  ./FileManager.sh showFileContentAtLine <path> <filename> <line>"
    echo "  ./FileManager.sh showFileContentForLineRange <path> <filename> <start> <end>"
    echo "  ./FileManager.sh moveFile <source> <destination>"
    echo "  ./FileManager.sh copyFile <source> <destination>"
    echo "  ./FileManager.sh clearFileContent <path> <filename>"
    echo "  ./FileManager.sh deleteFile <path> <filename>"
    ;;

esac
