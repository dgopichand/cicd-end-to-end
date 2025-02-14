# Use a compatible Python version (3.10, since Django 3.2 is known to work well with it)
FROM python:3.10

# Set working directory
WORKDIR /app

# Install system dependencies
RUN apt-get update && apt-get install -y \
    python3-distutils \
    python3-setuptools \
    && rm -rf /var/lib/apt/lists/*

# Upgrade pip and install dependencies
RUN pip install --upgrade pip && \
    pip install django==3.2

# Copy project files
COPY . .

# Run migrations (fail the build if migrations don't work)
RUN python manage.py migrate

# Expose port 8000
EXPOSE 8000

# Start the Django server
CMD ["python", "manage.py", "runserver", "0.0.0.0:8000"]
