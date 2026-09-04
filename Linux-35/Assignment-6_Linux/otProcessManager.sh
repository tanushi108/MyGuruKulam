#!/bin/bash

case "$1" in

topProcess)

    if [[ "$3" == "memory" ]]; then

        echo "Top $2 processes by memory"

        ps -eo pid,user,%cpu,%mem,comm --sort=-%mem | head -n $(( $2 + 1 ))

    elif [[ "$3" == "cpu" ]]; then

        echo "Top $2 processes by CPU"

        ps -eo pid,user,%cpu,%mem,comm --sort=-%cpu | head -n $(( $2 + 1 ))

    else

        echo "Error: Use memory or cpu"

    fi
    ;;


killLeastPriorityProcess)

    pid=$(ps -eo pid,ni --sort=ni | tail -n 1 | awk '{print $1}')

    if [[ -n "$pid" ]]; then

        echo "Killing process with lowest priority: PID $pid"
        sudo kill "$pid"

    else

        echo "No process found"

    fi
    ;;


RunningDurationProcess)

    input="$2"

    if [[ -z "$input" ]]; then

        echo "Please provide process name or PID"

    elif [[ "$input" =~ ^[0-9]+$ ]]; then

        pid="$input"

    else

        pid=$(pgrep -o "$input")

    fi

    if [[ -n "$pid" ]]; then

        echo "Process PID: $pid"

        echo "Process Name:"
        ps -p "$pid" -o comm=

        echo "Started:"
        ps -p "$pid" -o lstart=

        echo "Running Duration:"
        ps -p "$pid" -o etime=

    else

        echo "Process not found"

    fi
    ;;


listOrphanProcess)

    echo "Orphan Processes:"

    ps -eo pid,ppid,user,stat,comm | awk '$2 == 1'

    ;;


listZoombieProcess)

    echo "Zombie Processes:"

    ps -eo pid,ppid,user,stat,comm | awk '$4 ~ /Z/'

    ;;


killProcess)

    input="$2"

    if [[ -z "$input" ]]; then

        echo "Please provide process name or PID"

    elif [[ "$input" =~ ^[0-9]+$ ]]; then

        pid="$input"

    else

        pid=$(pgrep -o "$input")

    fi

    if [[ -n "$pid" ]]; then

        echo "Killing process PID: $pid"
        sudo kill "$pid"

    else

        echo "Process not found"

    fi

    ;;


listWaitingProcess)

    echo "Processes waiting for resources:"

    ps -eo pid,ppid,stat,wchan,comm |grep '^ *[0-9]* *D'

    ;;


*)

    echo "Usage:"
    echo "./otProcessManager.sh topProcess <n> <memory|cpu>"
    echo "./otProcessManager.sh killLeastPriorityProcess"
    echo "./otProcessManager.sh RunningDurationProcess <name|pid>"
    echo "./otProcessManager.sh listOrphanProcess"
    echo "./otProcessManager.sh listZoombieProcess"
    echo "./otProcessManager.sh killProcess <name|pid>"
    echo "./otProcessManager.sh ListWaitingProcess"

    ;;

esac
