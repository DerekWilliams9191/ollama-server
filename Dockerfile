FROM ollama/ollama:latest

# Create ollama user and set permissions
RUN useradd -r -s /bin/false -m -d /usr/share/ollama ollama

# Create directories and set permissions
RUN mkdir -p /usr/share/ollama/.ollama && \
    chown -R ollama:ollama /usr/share/ollama

# Install curl for health checks
RUN apt-get update && apt-get install -y curl && rm -rf /var/lib/apt/lists/*

# Copy startup script
COPY ./startup.sh /usr/local/bin/startup.sh
RUN chmod +x /usr/local/bin/startup.sh && \
    chown ollama:ollama /usr/local/bin/startup.sh

# Switch to ollama user
USER ollama

# Set working directory
WORKDIR /usr/share/ollama

# Start with startup script
ENTRYPOINT ["/usr/local/bin/startup.sh"]
