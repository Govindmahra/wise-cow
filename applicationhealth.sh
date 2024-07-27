#!/bin/bash

# Function to check application status
check_application_status() {
    local url=$1
    local response_code

    # Use curl to fetch the HTTP status code
    response_code=$(curl -s -o /dev/null -w "%{http_code}" "$url")

    # Get the current timestamp
    local current_time
    current_time=$(date +"%Y-%m-%d %H:%M:%S")

    # Log the current time and status code
    echo "$current_time - URL: $url - Status Code: $response_code"

    # Determine if the application is 'up' or 'down'
    if [ "$response_code" -ge 200 ] && [ "$response_code" -lt 300 ]; then
        echo "Application is UP. Status Code: $response_code"
    else
        echo "Application is DOWN. Status Code: $response_code"
    fi
}

# Main script execution
# Replace 'http://example.com' with your application's URL
application_url="http://example.com"

check_application_status "$application_url"

