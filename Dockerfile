FROM python:3

# Set working directory inside the container
WORKDIR /app

# Copy all files to the working directory
COPY . .

# Install Django
RUN pip install django==3.2

# Run migrations (ensure manage.py is in the correct location)
RUN python manage.py migrate || echo "Migrations failed, continuing..."

# Expose port 8000
EXPOSE 8000

# Start the Django server
CMD ["python", "manage.py", "runserver", "0.0.0.0:8000"]
