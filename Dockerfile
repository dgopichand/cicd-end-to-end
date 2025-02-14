# Use a stable Python version (avoid latest due to breaking changes)
FROM python:3.12

# Set working directory inside the container
WORKDIR /app

# Install dependencies
RUN apt-get update && apt-get install -y python3-setuptools && \
    pip install --upgrade pip && \
    pip install django==3.2

# Copy all files to the working directory
COPY . .

# Run migrations (will fail the build if migrations fail)
RUN python manage.py migrate

# Expose port 8000
EXPOSE 8000

# Start the Django server
CMD ["python", "manage.py", "runserver", "0.0.0.0:8000"]
