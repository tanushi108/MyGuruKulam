#!/bin/bash

case "$1" in

    # List branches
    -l)
        git branch
        ;;

    # Create branch
    -b)
        git branch "$2"
        echo "Branch $2 created"
        ;;

    # Delete branch
    -d)
        git branch -d "$2"
        ;;

    # Merge branch1 into branch2
    -m)
        if [ "$2" = "-1" ] && [ "$4" = "-2" ]; then
            branch1="$3"
            branch2="$5"

            git checkout "$branch2"
            git merge "$branch1"
        else
            echo "Usage: ./gitBranches.sh -m -1 <branch1> -2 <branch2>"
        fi
        ;;

    # Rebase branch1 onto branch2
    -r)
        if [ "$2" = "-1" ] && [ "$4" = "-2" ]; then
            branch1="$3"
            branch2="$5"

            git checkout "$branch1"
            git rebase "$branch2"
        else
            echo "Usage: ./gitBranches.sh -r -1 <branch1> -2 <branch2>"
        fi
        ;;

    *)
        echo "Usage:"
        echo "./gitBranches.sh -l"
        echo "./gitBranches.sh -b <branch_name>"
        echo "./gitBranches.sh -d <branch_name>"
        echo "./gitBranches.sh -m -1 <branch1> -2 <branch2>"
        echo "./gitBranches.sh -r -1 <branch1> -2 <branch2>"
        ;;

esac
