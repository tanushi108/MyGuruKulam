#!/bin/bash

case "$1" in

    -t)
        git tag "$2"
        echo "Tag $2 created"
        ;;

    -l)
        git tag
        ;;

    -d)
        git tag -d "$2"
        ;;

    *)
        echo "Usage:"
        echo "./gitTags.sh -t <tag_name>"
        echo "./gitTags.sh -l"
        echo "./gitTags.sh -d <tag_name>"
        ;;

esac
