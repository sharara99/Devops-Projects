# Flask Docker App

This project is a basic Flask web application that demonstrates how to serve dynamic content using Flask. The application runs inside a Docker container and includes a simple HTML template that displays a colored background.

## Features

- **Flask Web Framework:** The application uses Flask to serve a webpage.
- **Dynamic Content:** The background color of the page can be set dynamically through the Python code.
- **Dockerized:** The app is containerized using Docker, making it easy to deploy and run on any system with Docker installed.
- **Jenkins Integration:** A Jenkinsfile is included for CI/CD pipeline integration.

## Project Structure
.
├── Dockerfile
├── Jenkinsfile
├── README.md
├── app.py
├── docker-compose.yml
└── templates
    └── hello.html


- `app.py`: The main Flask application file.
- `Dockerfile`: Used to build the Docker image for the application.
- `Jenkinsfile`: CI/CD pipeline configuration for Jenkins.
- `docker-compose.yml`: Compose file for running the app in a Docker container.
- `templates/hello.html`: HTML template that gets rendered by Flask.

## Getting Started

### Prerequisites

- Docker installed on your machine.
- Python 3.x installed (if running locally without Docker).

