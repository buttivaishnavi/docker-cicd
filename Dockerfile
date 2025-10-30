# Use the official Python base image
FROM python:3.9-slim

# Set the working directory inside the container
WORKDIR /app

# Copy the current directory contents into the container
COPY . /app

# Install dependencies from requirements.txt
RUN pip install -r requirements.txt

# Expose port 5000 to the host
EXPOSE 5000

# Command to run the app
CMD ["python", "app.py"]
