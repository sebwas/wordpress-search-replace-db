# Docker WordPress SRDB
Using the great [https://github.com/interconnectit/Search-Replace-DB](interconnectit/Search-Replace-DB) this easily helps with replacing strings in a WordPress database.

# Usage
You have to link the database to the container and declare the `wp-config.php` as a volume at `/tmp/wp-config.php`. Alternatively you can mount an existing WordPress instance under `/var/www/html`.

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
