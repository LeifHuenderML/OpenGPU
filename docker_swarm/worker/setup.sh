#!/bin/bash

sudo apt-get install jq

#!/bin/bash

# Send the request to the Flask server and store the response
response=$(curl -s http://192.168.1.192:5000/join_swarm)

# Extract the command from the response using jq
join_command=$(echo $response | jq -r .command)

# Check if the command is not empty
if [ -n "$join_command" ]; then
    echo "Joining Docker Swarm..."
    # Execute the join command
    eval $join_command
else
    echo "Failed to retrieve the Docker Swarm join command."
fi
