Here is a `README.md` file that explains how to set up and run the project with Docker Compose, including the use of environment-specific configurations for PostgreSQL (test, development, and production).

---

# PostgreSQL Docker Setup for Development, Testing, and Production

This project provides a fully-fledged Docker Compose setup for PostgreSQL, tailored for development, testing, and production environments. It includes the following components:

- **PostgreSQL**: The primary database service.
- **pgAdmin**: A web-based interface for managing PostgreSQL.
- **Custom Initialization Scripts**: For setting up the database schema or sample data (e.g., tables, test data).

### Features

- **Environment-Specific Configurations**: Easily switch between development, testing, and production environments.
- **Persistent Storage**: Data is stored in Docker volumes to ensure it persists across container restarts.
- **Health Checks**: PostgreSQL and pgAdmin containers are monitored for health status.
- **Flexible Database Initialization**: Custom SQL initialization scripts are executed at database creation.

## Prerequisites

- Docker and Docker Compose installed on your machine.
- Basic knowledge of PostgreSQL and Docker Compose.

## Getting Started

### 1. Clone the Repository

```bash
git clone https://github.com/yourusername/postgres-docker-setup.git
cd postgres-docker-setup
```

### 2. Set Up Environment Variables

In this setup, we use `.env` files to configure PostgreSQL for different environments (development, testing, and production).

1. **Create the environment-specific `.env` files**:
   - `.env.dev`: Used for development environment.
   - `.env.test`: Used for testing environment.
   - `.env.prod`: Used for production environment.

Each `.env` file should include PostgreSQL credentials like `POSTGRES_USER`, `POSTGRES_PASSWORD`, and `POSTGRES_DB`.

#### Example `.env.dev`
```env
POSTGRES_USER=devuser
POSTGRES_PASSWORD=devpassword
POSTGRES_DB=devdb
```

#### Example `.env.test`
```env
POSTGRES_USER=testuser
POSTGRES_PASSWORD=testpassword
POSTGRES_DB=testdb
```

#### Example `.env.prod`
```env
POSTGRES_USER=produser
POSTGRES_PASSWORD=prodpassword
POSTGRES_DB=proddb
```

### 3. Configure Initialization Scripts

Place any custom SQL scripts in the `init-scripts` folder. These scripts will be run during the initial database setup. For example, you can include scripts for creating tables, inserting sample data, or configuring users.

### 4. Running the Containers

To run the containers for a specific environment, use the following commands. Each environment will use the respective `.env` file to configure PostgreSQL.

#### Development Environment:
```bash
docker-compose --env-file .env.dev up -d
```

#### Testing Environment:
```bash
docker-compose --env-file .env.test up -d
```

#### Production Environment:
```bash
docker-compose --env-file .env.prod up -d
```

This will start the PostgreSQL and pgAdmin containers. The `-d` flag runs the containers in detached mode (in the background).

### 5. Access pgAdmin

Once the containers are running, you can access pgAdmin through your browser. It will be available on `http://localhost:8080`. Log in using the default credentials specified in the `docker-compose.yml` file:

- **Email**: `admin@example.com`
- **Password**: `adminpassword`

After logging in, you can connect to the PostgreSQL instance by using the credentials defined in your `.env` file (e.g., `POSTGRES_USER`, `POSTGRES_PASSWORD`).

### 6. Stopping and Removing Containers

To stop the running containers and remove them, use the following command:

```bash
docker-compose down
```

This will stop all containers and remove them, but your data will remain in the Docker volume (`postgres_data`) unless you explicitly remove the volume.

### 7. Viewing Logs

To view the logs for the PostgreSQL or pgAdmin containers, use:

```bash
docker-compose logs postgres
```

or for pgAdmin:

```bash
docker-compose logs pgadmin
```

### 8. Custom Initialization Scripts

You can customize the database initialization by adding your SQL scripts to the `init-scripts` folder. For example, to create tables or insert test data when PostgreSQL is first initialized, you can place an SQL file in this folder:

- `init-scripts/create-tables.sql`:
    ```sql
    CREATE TABLE test_table (
        id SERIAL PRIMARY KEY,
        name VARCHAR(255)
    );
    INSERT INTO test_table (name) VALUES ('Test Data');
    ```

These scripts will be automatically executed when the PostgreSQL container starts for the first time.

### 9. Health Checks

Both the `postgres` and `pgadmin` containers include health checks to ensure they are functioning properly.

- **PostgreSQL**: Uses the `pg_isready` command to check if the database is ready to accept connections.
- **pgAdmin**: Uses `curl` to check if the pgAdmin web interface is available.

### 10. Changing Environment-Specific Configuration

You can modify the environment configuration for each environment by editing the respective `.env` file. For example, if you need to change the PostgreSQL user, password, or database name for a specific environment, update the corresponding `.env` file.

### 11. Additional Notes

- **Persistence**: The `postgres_data` volume ensures that your database persists across container restarts. You can find the data stored in your system's Docker volumes directory.
- **Security**: For production environments, make sure to secure your database by using strong passwords and consider running PostgreSQL in a private network.

## Troubleshooting

- **Cannot Connect to PostgreSQL**: Ensure that the correct `.env` file is used when starting the containers and that the database is fully initialized before trying to connect.
- **pgAdmin Not Loading**: Check the logs with `docker-compose logs pgadmin` to ensure that the pgAdmin container is up and accessible.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

---

This `README.md` covers all necessary steps to set up, run, and manage the Docker Compose configuration for PostgreSQL in different environments. You can modify or extend it based on your specific project needs.