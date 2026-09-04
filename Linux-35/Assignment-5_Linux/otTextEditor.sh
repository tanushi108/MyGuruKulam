#!/bin/bash

case "$1" in

help|-help|-h|--help)
        echo "Usage:"
        echo "./otTextEditor <operation> <arguments>"

        echo
        echo "Operations:"
        echo "  addLineTop <file> <line>"
        echo "  addLineBottom <file> <line>"
        echo "  addLineAt <file> <line_no> <line>"
        echo "  updateFirstWord <file> <word> <new_word>"
        echo "  updateAllWords <file> <word> <new_word>"
        echo "  insertWord <file> <word1> <word2> <word>"
        echo "  deleteLine <file> <line_no>"
        echo "  deleteLine <file> <line_no> <word>"
	echo " show <file>"
	echo " showNum <file>" 
        echo
        echo "Example:"
        echo './otTextEditor addLineTop sample.txt "Hello Linux"'
        ;;

# --------------------------------------------------
# Add line at top
# --------------------------------------------------
addLineTop)

if [[ ! -f "$2" ]];then
echo "Error: File $2 does not exist."
exit 1 
fi

    sed -i "1i $3" "$2"

    echo "Line added at top"
    cat -n "$2"
    ;;


# --------------------------------------------------
# Add line at bottom
# --------------------------------------------------
addLineBottom)
if [[ ! -f "$2" ]];then
echo "Error: File $2 does not exist."
exit 1 
fi

    echo "$3" >> "$2"

    echo "Line added at bottom"

cat -n "$2"    ;;


# --------------------------------------------------
# Add line at specific line number
# --------------------------------------------------
addLineAt)
if [[ ! -f "$2" ]];then
echo "Error: File $2 does not exist."
exit 1 
fi

    sed -i "${3}i $4" "$2"

    echo "Line added at line $3"
cat -n "$2"    
;;


# --------------------------------------------------
# Replace first occurrence of word
# --------------------------------------------------
updateFirstWord)
if [[ ! -f "$2" ]];then
echo "Error: File $2 does not exist."
exit 1 
fi

    sed -i "0,/$3/s//$4/" "$2"

    echo "First occurrence of '$3' replaced with '$4'"
    cat -n "$2";;


# --------------------------------------------------
# Replace all occurrences of word
# --------------------------------------------------
updateAllWords)
if [[ ! -f "$2" ]];then
echo "Error: File $2 does not exist."
exit 1 
fi

    sed -i "s/$3/$4/g" "$2"

    echo "All occurrences of '$3' replaced with '$4'"
cat -n "$2"    ;;


# --------------------------------------------------
# Insert word between two words
# --------------------------------------------------
insertWord)
if [[ ! -f "$2" ]];then
echo "Error: File $2 does not exist."
exit 1 
fi

    sed -i "s/$3 $4/$3 $5 $4/g" "$2"

    echo "'$5' inserted between '$3' and '$4'"
cat -n "$2"    ;;


# --------------------------------------------------
# Delete line
# --------------------------------------------------
deleteLine)
if [[ ! -f "$2" ]];then
echo "Error: File $2 does not exist."
exit 1 
fi

    if [[ $# -eq 3 ]]
    then
        # Delete line using line number
        sed -i "${3}d" "$2"

        echo "Line $3 deleted"

    elif [[ $# -eq 4 ]]
    then
        # Delete line only if it contains the word
        sed -i "${3}{/$4/d}" "$2"

        echo "Line $3 containing '$4' deleted"

    else
        echo "Usage:"
        echo "./otTextEditor deleteLine <file> <line no>"
        echo "./otTextEditor deleteLine <file> <line no> <word>"
        exit 1
    fi

    ;;


# --------------------------------------------------
# Show file
# --------------------------------------------------
show)
if [[ ! -f "$2" ]];then
echo "Error: File $2 does not exist."
exit 1 
fi

    cat "$2"
    ;;
showNum)
if [[ ! -f "$2" ]];then
echo "Error: File $2 does not exist."
exit 1 
fi

cat -n "$2"
;;


# --------------------------------------------------
# Invalid option
# --------------------------------------------------
*)

    echo "Invalid option: $1"
    echo "Use './otTextEditor help' for help"
    exit 1
    ;;

esac
