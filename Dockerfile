# Use a base image that includes Bash and essential tools
FROM ubuntu:20.04

# Install necessary packages
RUN apt-get update && apt-get install -y \
    netcat \
    fortune-mod \
    cowsay \
    bash \
    && rm -rf /var/lib/apt/lists/*

# Copy the Wisecow application script into the container
COPY wisecow.sh ~/govind/wisecow/wise-cow/src/wisecow.sh

# Make the script executable
RUN chmod +x ~/govind/wisecow/wise-cow/src/wisecow.sh

# Expose the port the application will run on
EXPOSE 4499

# Define the default command to run the Wisecow application
CMD ["~/govind/wisecow/wise-cow/src/wisecow.sh"]

