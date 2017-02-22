# Docker WordPress SRDB
Using the great [interconnectit/Search-Replace-DB](https://github.com/interconnectit/Search-Replace-DB) this easily helps with replacing strings in a WordPress database.

# Usage
You have to link the database to the container and declare the `wp-config.php` as a volume at `/tmp/wp-config.php` or `/var/www/html`. Alternatively you can directly specify *user*, *password*, *host* and *database name* as environment variables, for example in your `docker-compose.yml` file.

```
docker run --rm -v /path/to/wp-config.php:/tmp/wp-config.php:ro --link some-db-container:db sebwas/wp-srdb srdb example.com example.net
```

**-- OR --**

```
docker run --rm -v /path/to/wordpress:/var/www/html:ro --link some-db-container:db sebwas/wp-srdb srdb example.com example.net
```

**-- OR --**

Directly specify the db data as environment variables like so:
```
docker run --rm -e DB_USER=root -e DB_PASS=secret -e DB_HOST=db -e DB_NAME=wordpress --link some-db-container:db sebwas/wp-srdb srdb example.com example.net
```

**-- OR --**

Use it in a docker-compose file like so:

```
version: '2'

services:

  wordpress-data:
    image: mysql:5.7
    environment:
      - MYSQL_ROOT_PASSWORD=secret
      - MYSQL_DATABASE=wordpress
    volumes:
      - wordpress-data:/var/lib/mysql

  migrate:
    image: sebwas/wp-srdb
    environment:
      - DB_HOST=mysql
      - DB_NAME=wordpress
      - DB_USER=root
      - DB_PASS=secret
    links:
      - wordpress-data:mysql

volumes:
  wordpress-data:
    driver: local
```
