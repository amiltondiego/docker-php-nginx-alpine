Docker  - PHP-FPM 8 | Nginx | Alpine Linux
==============================================
Docker image with php 8, nginx build on [Alpine Linux](http://www.alpinelinux.org/).

<details>
    <summary>PHP Modules</summary>
    
* Mysqli
* pdo_mysql
* sqlite3
* pdo_pgsql
* bcmath
* odbc
* pdo_sqlite
* json
* openssl
* curl
* zlib
* session
* xml
* phar
* intl
* dom
* xmlreader
* ctype
* mbstring
* gd
* pcntl
* opcache
* xdebug
* mongodb
* redis
</details>


> Use commands with [make](https://www.gnu.org/software/make/) or open the **Makefile** file and read the commands

Usage
-----
Build Image Docker:

    make image
Start the Docker Container:

    make run
Remove Container Image Docker:

    make remove
Destroy Image Docker:

    make destroy
Push Image Docker:

    make push