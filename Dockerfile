# Use an official Python runtime as a parent image
FROM python:3.9-slim

# Set the working directory in the container
WORKDIR /app

# Copy requirements.txt from the app directory
COPY ./app/requirements.txt /app/

# Install Python dependencies
RUN pip install --no-cache-dir -r /app/requirements.txt

# Install Playwright and required dependencies
RUN apt-get update && apt-get install -y libnss3 libatk1.0-0 libatk-bridge2.0-0 libcups2 libdrm2 libxcomposite1 libxrandr2 libgbm-dev libasound2 libpangocairo-1.0-0 libxdamage1 libpango-1.0-0 libgtk-3-0 libx11-xcb1
RUN pip install playwright && playwright install

# Copy the rest of the application files
COPY ./app .

# Ensure outputs directory exists and is writable
RUN mkdir -p ./outputs && chmod -R 777 ./outputs

# Expose port 8000 for the FastAPI service
EXPOSE 8000

# Run the FastAPI server using uvicorn
CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "8000"]
