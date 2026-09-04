#!/bin/bash

if [[ "$1" == "-h" || "$1" == "--help" || "$1" == "help" ]]
then
    echo "Usage:"
    echo "./teplateEngine.sh <template-file> key1=value1 key2=value2 ..."
    echo
    echo "Example:"
    echo "./teplateEngine.sh trainer.template fname=sandeep topic=linux"
    exit 0
fi


if [[ ! -f "$1" ]]
then
    echo "Error: Template file '$1' does not exist"
    exit 1
fi

IFS='=' read -r key1 value1 <<< "$2"
IFS='=' read -r key2 value2 <<< "$3"

echo "----- Template file -----"
cat "$1"

sed -i "s/{{${key1}}}/${value1}/g; s/{{${key2}}}/${value2}/g" "$1"

echo
echo "----- File content -----"
cat "$1"
