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
mkdir -p data

# Set permissions
chmod -R 755 static
chmod -R 755 instance
chmod -R 755 data

# Initialize the database
echo "Initializing database..."
python -c "from database import init_db; init_db()"

# Verify database was created
echo "Verifying database..."
python -c "from database import check_database_exists; print('Database exists:', check_database_exists())" 
