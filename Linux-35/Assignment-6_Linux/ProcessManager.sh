#!/bin/bash

BASE_DIR="$HOME"
DB="$BASE_DIR/services.db"

mkdir -p "$BASE_DIR"
touch "$DB"

operation=""
script=""
alias=""
priority=""

while [[ $# -gt 0 ]]
do
    case "$1" in

        -o)
            operation="$2"
            shift 2
            ;;

        -s)
            script="$2"
            shift 2
            ;;

        -a)
            alias="$2"
            shift 2
            ;;

        -p)
           if [[ "$2" == "priority" ]]; then
                operation="priority"
                priority="$3"
                shift 3
            else
                echo "Usage: ./ProcessManager.sh -p priority <low|med|high> -a <alias>"
                exit 1
            fi            ;;

        *)
            echo "Unknown option: $1"
            exit 1
            ;;

    esac
done


case "$operation" in


register)

    if [[ -z "$script" || -z "$alias" ]]; then
        echo "Usage: ./ProcessManager.sh -o register -s <script-path> -a <alias>"
        exit 1
    fi

    if [[ ! -f "$script" ]]; then
        echo "Script not found: $script"
        exit 1
    fi

    if [[ ! "$alias" =~ ^[a-zA-Z0-9_-]+$ ]]; then
        echo "Invalid alias"
        exit 1
    fi

    if grep -q "^${alias}|" "$DB"; then
        echo "Service already registered"
        exit 1
    fi

    echo "$alias|$script|-" >> "$DB"

    echo "Service registered successfully"
    echo "Alias : $alias"
    echo "Script: $script"

    ;;


start)

    if [[ -z "$alias" ]]; then
        echo "Usage: ./ProcessManager.sh -o start -a <alias>"
        exit 1
    fi

    record=$(awk -F'|' -v a="$alias" '$1 == a {print}' "$DB")

    if [[ -z "$record" ]]; then
        echo "Service not registered"
        exit 1
    fi

    IFS='|' read -r service_alias script pid <<< "$record"

    if [[ "$pid" != "-" ]] && kill -0 "$pid" 2>/dev/null; then
        echo "Service is already running"
        echo "PID: $pid"
        exit 1
    fi

    nohup bash "$script" > "/tmp/${alias}.log" 2>&1 &

    pid=$!

    awk -F'|' -v a="$alias" -v p="$pid" \
        'BEGIN {OFS="|"} $1 == a {$3=p} {print}' \
        "$DB" > "$DB.tmp" && mv "$DB.tmp" "$DB"

    echo "Service started"
    echo "PID: $pid"

    ;;


status)

    if [[ -z "$alias" ]]; then
        echo "Usage: ./ProcessManager.sh -o status -a <alias>"
        exit 1
    fi

    record=$(awk -F'|' -v a="$alias" '$1 == a {print}' "$DB")

    if [[ -z "$record" ]]; then
        echo "Service not registered"
        exit 1
    fi

    IFS='|' read -r service_alias script pid <<< "$record"

    if [[ "$pid" != "-" ]] && kill -0 "$pid" 2>/dev/null; then

        echo "Service : $alias"
        echo "PID     : $pid"
        echo "Status  : RUNNING"

    else

        echo "Service : $alias"
        echo "Status  : STOPPED"

    fi

    ;;


kill)

    if [[ -z "$alias" ]]; then
        echo "Usage: ./ProcessManager.sh -o kill -a <alias>"
        exit 1
    fi

    record=$(awk -F'|' -v a="$alias" '$1 == a {print}' "$DB")

    if [[ -z "$record" ]]; then
        echo "Service not registered"
        exit 1
    fi

    IFS='|' read -r service_alias script pid <<< "$record"

    if [[ "$pid" == "-" ]]; then
        echo "Service is not running"
        exit 1
    fi

    if kill -0 "$pid" 2>/dev/null; then

        kill "$pid"

        awk -F'|' -v a="$alias" \
            'BEGIN {OFS="|"} $1 == a {$3="-"} {print}' \
            "$DB" > "$DB.tmp" && mv "$DB.tmp" "$DB"

        echo "Service stopped"
        echo "PID: $pid"

    else

        echo "Process is not running"

        awk -F'|' -v a="$alias" \
            'BEGIN {OFS="|"} $1 == a {$3="-"} {print}' \
            "$DB" > "$DB.tmp" && mv "$DB.tmp" "$DB"

    fi

    ;;


priority)

    if [[ -z "$priority" || -z "$alias" ]]; then
        echo "Usage: ./ProcessManager.sh -o priority -p <low|med|high> -a <alias>"
        exit 1
    fi

    pid=$(awk -F'|' -v a="$alias" '$1 == a {print $3}' "$DB")

    if [[ -z "$pid" || "$pid" == "-" ]]; then
        echo "Service is not running"
        exit 1
    fi

    if ! kill -0 "$pid" 2>/dev/null; then
        echo "Service is not running"
        exit 1
    fi

    case "$priority" in

        high)
            sudo renice -n -10 -p "$pid"
            ;;

        med)
            sudo renice -n 0 -p "$pid"
            ;;

        low)
            sudo renice -n 10 -p "$pid"
            ;;

        *)
            echo "Use: low, med or high"
            exit 1
            ;;

    esac

    ;;


list)

    echo "Registered services:"

    if [[ ! -s "$DB" ]]; then
        echo "No services registered"
    else
        cut -d'|' -f1 "$DB"
    fi

    ;;


top)

    echo "Alias | PID | State | Priority | Script"
    echo "------------------------------------------"

    if [[ -n "$alias" ]]; then

        record=$(awk -F'|' -v a="$alias" '$1 == a {print}' "$DB")

        if [[ -z "$record" ]]; then
            echo "Service not registered"
            exit 1
        fi

        IFS='|' read -r service_alias script pid <<< "$record"

        if [[ "$pid" != "-" ]] && kill -0 "$pid" 2>/dev/null; then

            state=$(ps -p "$pid" -o stat= | xargs)
            nice=$(ps -p "$pid" -o ni= | xargs)

            echo "$service_alias | $pid | $state | $nice | $script"

        else

            echo "$service_alias | - | STOPPED | - | $script"

        fi

    else

        while IFS='|' read -r service_alias script pid
        do

            [[ -z "$service_alias" ]] && continue

            if [[ "$pid" != "-" ]] && kill -0 "$pid" 2>/dev/null; then

                state=$(ps -p "$pid" -o stat= | xargs)
                nice=$(ps -p "$pid" -o ni= | xargs)

                echo "$service_alias | $pid | $state | $nice | $script"

            else

                echo "$service_alias | - | STOPPED | - | $script"

            fi

        done < "$DB"

    fi

    ;;


*)

    echo "Usage:"
    echo "./ProcessManager.sh -o register -s <script-path> -a <alias>"
    echo "./ProcessManager.sh -o start -a <alias>"
    echo "./ProcessManager.sh -o status -a <alias>"
    echo "./ProcessManager.sh -o kill -a <alias>"
    echo "./ProcessManager.sh -o priority -p <low|med|high> -a <alias>"
    echo "./ProcessManager.sh -o list"
    echo "./ProcessManager.sh -o top [-a <alias>]"

    ;;

esac
