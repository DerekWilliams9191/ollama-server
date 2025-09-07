#!/bin/bash

# Start Ollama server in the background
ollama serve &
OLLAMA_PID=$!

# Wait for server to be ready
echo "Waiting for Ollama server to start..."
while ! curl -f http://localhost:11434/api/version >/dev/null 2>&1; do
    sleep 2
done
echo "Ollama server is ready!"

# Define models to pull automatically
MODELS=(
    "llama3.2:latest"
)

# Pull each model
echo "Starting automatic model downloads..."
for model in "${MODELS[@]}"; do
    echo "Pulling model: $model"
    ollama pull "$model" || echo "Failed to pull $model, continuing..."
done

echo "Model downloads completed!"

# Keep the server running
wait $OLLAMA_PID
