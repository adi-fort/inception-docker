<div align="center">

# 🐳 INCEPTION

### Containerized Web Infrastructure with Docker Compose

![Docker](https://img.shields.io/badge/Docker-Compose-2496ED?style=for-the-badge&logo=docker&logoColor=white)
![Linux](https://img.shields.io/badge/Linux-Debian-A81D33?style=for-the-badge&logo=debian&logoColor=white)
![42](https://img.shields.io/badge/42-Common_Core-000000?style=for-the-badge)

**A multi-container web stack built with custom Docker images and persistent storage.**

*Docker · Linux · Nginx · WordPress · MariaDB · TLS*

</div>

---

## 📖 About the Project

**Inception** is a system administration and containerization project developed as part of the **42 School Common Core curriculum**.

The goal is to deploy a small web infrastructure using Docker Compose, with each service running in its own container and built from a custom Dockerfile.

Instead of using ready-made application images, the project builds an environment around **Debian Bookworm**, installs and configures the required services, and connects them through a dedicated Docker network.

The resulting stack serves a WordPress website over HTTPS, with PHP execution handled by PHP-FPM and data stored in MariaDB.

---

## ✨ Features

| Feature | Implementation |
|:---|:---|
| **Container Orchestration** | Docker Compose manages three services |
| **Custom Images** | Separate Debian-based Dockerfiles |
| **HTTPS** | Nginx with TLS 1.2 and TLS 1.3 |
| **Application Runtime** | WordPress with PHP-FPM 8.2 |
| **Database** | MariaDB with initialization script |
| **Persistent Data** | Docker volumes for database and WordPress files |
| **Networking** | Dedicated Docker bridge network |
| **Automated Setup** | Shell scripts and WP-CLI |
| **Service Lifecycle** | Restart policies and Makefile commands |

---

## 🏗️ Infrastructure

The stack is composed of three independent services, each running in its own Docker container.

### 🌐 Nginx

**HTTPS Entry Point**

- Listens on port `443`.
- Uses a self-signed TLS certificate.
- Supports TLS 1.2 and TLS 1.3.
- Serves content from the shared WordPress directory.
- Forwards PHP requests to the WordPress container through FastCGI.

### 🐘 WordPress + PHP-FPM

**Application Layer**

- Runs WordPress with PHP-FPM 8.2.
- Receives PHP requests from Nginx on port `9000`.
- Uses WP-CLI for automated WordPress installation and configuration.
- Creates the administrator and additional WordPress users.
- Connects to MariaDB through the internal Docker network.
- Stores application files in a persistent volume.

### 🗄️ MariaDB

**Database Layer**

- Provides the relational database used by WordPress.
- Listens internally on port `3306`.
- Initializes the database and application user through a shell script.
- Stores database files in a persistent volume.
- Communicates with WordPress over the Docker network.

### Container Communication

| Source | Destination | Protocol / Port |
|:---|:---|:---|
| Browser | Nginx | HTTPS / `443` |
| Nginx | WordPress | FastCGI / `9000` |
| WordPress | MariaDB | TCP / `3306` |

Only the Nginx HTTPS port is published to the host.

The WordPress and MariaDB services communicate through the internal Docker network.

---

## 🧩 Project Structure

The project separates infrastructure configuration from individual service implementations.

| Path | Purpose |
|:---|:---|
| `Makefile` | Build and infrastructure management commands |
| `srcs/docker-compose.yml` | Docker Compose service definitions |
| `srcs/requirements/nginx/` | Nginx Dockerfile and configuration |
| `srcs/requirements/wordpress/` | WordPress Dockerfile and setup scripts |
| `srcs/requirements/mariadb/` | MariaDB Dockerfile and initialization |
| `srcs/requirements/tools/` | Environment setup and cleanup scripts |

Each service is built from a custom Dockerfile rather than using a preconfigured application image.

---

## 🚀 Getting Started

### Requirements

- Linux operating system
- Docker Engine
- Docker Compose plugin
- GNU Make
- Bash

### 1. Clone the Repository

```bash
git clone https://github.com/adi-fort/inception.git
cd inception
```

### 2. Configure the Environment

The project uses an environment file located at:

`srcs/.env`

Configuration variables include:

| Variable | Purpose |
|:---|:---|
| `DOMAIN_NAME` | Website domain |
| `WP_TITLE` | WordPress website title |
| `WP_ADMIN` | WordPress administrator username |
| `WP_ADMIN_PASSWORD` | Administrator password |
| `WP_ADMIN_EMAIL` | Administrator email address |
| `WP_USER` | Additional WordPress username |
| `WP_USER_PASSWORD` | Additional user password |
| `MYSQL_DATABASE` | MariaDB database name |
| `MYSQL_USER` | Database username |
| `MYSQL_PASSWORD` | Database password |
| `MYSQL_ROOT_PASSWORD` | MariaDB root password |

The setup script can prompt for missing values and generate the environment file.

> **Important:** Never commit real passwords or a populated `.env` file to a public repository.

### 3. Build and Start

```bash
make
```

This executes the environment preparation process and starts the Docker Compose stack.

### 4. Access WordPress

Open your browser and navigate to the configured HTTPS domain.

Since the project uses a self-signed TLS certificate, the browser may display a certificate warning.

> **Note:** The original setup was developed within the 42 environment. Some configuration files contain absolute paths that must be updated before running the project on another machine.

### 5. Cleanup

The Makefile provides additional targets:

```bash
make clean
make fclean
make re
```

**Warning:** Cleanup scripts may remove Docker resources and local persistent data. Review them before execution.

---

## 🔒 Networking & Security

Inception introduces several important infrastructure and security concepts.

### Service Isolation

Each service runs inside its own Docker container.

This separates the web server, application runtime, and database into independent environments.

### Internal Networking

The services communicate through a dedicated Docker bridge network.

Docker's internal DNS allows containers to communicate using service names.

### Restricted Port Exposure

Only Nginx exposes a port to the host.

PHP-FPM and MariaDB remain accessible through the internal Docker network.

### TLS Encryption

Nginx is configured to accept HTTPS connections using TLS 1.2 and TLS 1.3.

A self-signed certificate is generated for local development.

### Persistent Storage

Docker volumes ensure that WordPress files and MariaDB data can survive container recreation.

### Environment Configuration

Environment variables are used to configure services and initialize application credentials.

> This project is an educational infrastructure exercise, not a production-hardened deployment. Production use would require additional security measures, including proper secrets management, trusted certificates, and operational monitoring.

---

## 🧠 What I Learned

Developing Inception provided practical experience with several fundamental areas of infrastructure engineering.

### Docker & Containerization

Understanding Docker images, containers, Dockerfiles, entrypoints, and container lifecycle management.

### Linux System Administration

Configuring services on Debian, managing processes, working with permissions, and writing shell scripts.

### Container Networking

Understanding Docker networks, service discovery, internal communication, and port exposure.

### Web Infrastructure

Connecting Nginx, PHP-FPM, WordPress, and MariaDB into a functioning multi-service environment.

### Data Persistence

Managing Docker volumes and understanding the separation between container filesystems and persistent storage.

### Automation

Using Docker Compose, shell scripts, Makefiles, and WP-CLI to automate infrastructure deployment.

### Debugging & Troubleshooting

Investigating configuration errors, service startup dependencies, networking problems, and container logs.

---

## 🛠️ Technologies

<div align="center">

![Docker](https://img.shields.io/badge/Docker-2496ED?style=flat-square&logo=docker&logoColor=white)
![Nginx](https://img.shields.io/badge/Nginx-009639?style=flat-square&logo=nginx&logoColor=white)
![WordPress](https://img.shields.io/badge/WordPress-21759B?style=flat-square&logo=wordpress&logoColor=white)
![MariaDB](https://img.shields.io/badge/MariaDB-003545?style=flat-square&logo=mariadb&logoColor=white)
![Debian](https://img.shields.io/badge/Debian-A81D33?style=flat-square&logo=debian&logoColor=white)
![Bash](https://img.shields.io/badge/Bash-4EAA25?style=flat-square&logo=gnubash&logoColor=white)
![PHP](https://img.shields.io/badge/PHP-777BB4?style=flat-square&logo=php&logoColor=white)

</div>

---

## 🎓 42 School

This project is part of the **42 Common Core**, a peer-to-peer, project-based software engineering curriculum.

Inception focuses on developing practical skills in containerization, Linux system administration, networking, and infrastructure automation.

**Project:** Inception  
**School:** 42 Roma  
**Status:** Completed  
**Focus:** Docker, Linux, Networking & Infrastructure

---

<div align="center">

### Three services. One connected stack.

**[GitHub Profile](https://github.com/adi-fort)**

<sub>42 Common Core | Linux & Containerization</sub>

</div>
