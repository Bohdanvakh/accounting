# Accounting Application Documentation

The accounting application is a tool for determining the price of goods, calculating specific goods and items, creating orders for delivery, and providing all the information about the weight and dimensions of the packages.

# How to Use

## Using in Local Environment

First, you need to download the code to your local machine by clicking [Download ZIP](https://github.com/Bohdanvakh/accounting/archive/refs/heads/main.zip).

After you have installed the application, you need to open [cmd](https://learn.microsoft.com/en-us/windows-server/administration/windows-commands/cmd) to manage the code.

⚠️ The documentation describes the process of managing the application using a Windows machine. If you don't know how to use Windows and use Linux, please check this [article](https://learn.microsoft.com/en-us/windows/).

After you have opened cmd, go to the folder where the downloaded application is located by using the cd command. Example:
```bash
Windows\C:\Users\User> cd "/path/to/application"
```

## How to use Docker with the application?

Before you read this part, please, install docker and Docker Desktop into your local machine, After that you can continue reading the article.

There are several ways of using Docker.

## 1. Back End Development
If you are a back end developer and don't need frontend part of the application, you can go to root path of the application, open your cmd and run the command:
```bash
Windows\C:\Users\User> cd "/path/to/application"
```

After that run this command:
```bash
docker-compose build
```
that command will create image of your application. Then you can run next command:
```bash
docker-compose up
```
that command will create and run containers for your back end application. You would be able to use Rails, postgresql and other servers.

## 2. Full Stack Development
If you need to work with back end and frontend parts of the application you should do next steps:

1. Create root folder (for example, you can set "app" name for it).
2. In the root folder you should create folder for back end part of the application: app/be/
3. In the root folder you should create folders for front end part of the application: app/fe/
4. Clone each repo in created folders (front end repo into /fe; back end repo into /be).
5. Go back to root folder (app/) and create files `docker-compose.yml`, `.env`

The structure should look like this:
/app:
    /be:
        rails application code
    /fe:
        react application code
    .env
    docker-compose.yml

6. Open created docker-compose.yml
7. Provide configurations for your docker-compose.yml. If you don't know how to do it you can use this example:
```
services:

  db:
    image: postgres:16
    volumes:
      - "postgres:/var/lib/postgresql/data"
    env_file:
      - .env

  be:
    build: ./be
    command: bundle exec rails server -b 0.0.0.0 -p 3000
    volumes:
      - ./be:/app
    ports:
      - "3000:3000"
    depends_on:
      - db
    env_file:
      - .env

  fe:
    build: ./fe
    depends_on:
      - be
    ports:
      - "8080:8080"
    volumes:
      - ./fe:/app
      - /app/node_modules
    environment:
      - PORT=8080
      - WATCHPACK_POLLING=true

volumes:
  postgres:
```
8. Save the file. Open `.env`. provide env variables for your postgres. You should provide values for this env variables:
POSTGRES_HOST=db
POSTGRES_DB=your_value
POSTGRES_PORT=your_value
POSTGRES_USER=your_value
POSTGRES_PASSWORD=your_value
9. Save the file.
After that run this command:
```bash
docker-compose build
```
that command will create image of your application. Then you can run next command:
```bash
docker-compose up
```
that command will create and run containers for your back end application. You would be able to use Rails, postgresql and other servers.
