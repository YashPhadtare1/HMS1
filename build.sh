#!/usr/bin/env bash
# exit on error
set -o errexit

# Install dependencies
pip install --upgrade pip
pip install -r requirements.txt || {
  echo "Failed to install dependencies. Trying with --no-deps..."
  pip install --no-deps -r requirements.txt
}

# Create necessary directories
mkdir -p static/images/doctors
mkdir -p instance

# Set permissions
chmod -R 755 static
chmod -R 755 instance

# Initialize the database if it doesn't exist
python -c "from database import init_db; init_db()" 
