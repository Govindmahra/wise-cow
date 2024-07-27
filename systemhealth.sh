#!/bin/bash

# Define thresholds
CPU_THRESHOLD=80
MEMORY_THRESHOLD=80
DISK_THRESHOLD=90

# Define log file in user's home directory
LOG_FILE="$HOME/system_health_monitor.log"

# Function to log messages
log_message() {
    local message="$1"
    echo "$(date) - ${message}" >> "${LOG_FILE}"
}

# Check CPU usage
check_cpu_usage() {
    local cpu_usage
    cpu_usage=$(top -bn1 | grep "Cpu(s)" | sed "s/.*, *\([0-9.]*\)%* id.*/\1/" | awk '{print 100 - $1}')
    if (( $(echo "$cpu_usage > $CPU_THRESHOLD" | bc -l) )); then
        local msg="High CPU usage detected: ${cpu_usage}%"
        echo "$msg"
        log_message "$msg"
    fi
}

# Check memory usage
check_memory_usage() {
    local memory_usage
    memory_usage=$(free | grep Mem | awk '{print $3/$2 * 100.0}')
    if (( $(echo "$memory_usage > $MEMORY_THRESHOLD" | bc -l) )); then
        local msg="High memory usage detected: ${memory_usage}%"
        echo "$msg"
        log_message "$msg"
    fi
}

# Check disk space usage
check_disk_usage() {
    local disk_usage
    disk_usage=$(df / | grep / | awk '{ print $5 }' | sed 's/%//g')
    if (( disk_usage > DISK_THRESHOLD )); then
        local msg="High disk space usage detected: ${disk_usage}%"
        echo "$msg"
        log_message "$msg"
    fi
}

# Check running processes
check_running_processes() {
    local process_count
    process_count=$(ps aux | wc -l)
    if (( process_count > 100 )); then
        local msg="High number of running processes detected: ${process_count}"
        echo "$msg"
        log_message "$msg"
    fi
}

# Main function to perform all checks
main() {
    check_cpu_usage
    check_memory_usage
    check_disk_usage
    check_running_processes
}

# Run the main function
main

