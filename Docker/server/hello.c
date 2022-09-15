#include <fcgi_stdio.h>

int main(void) {
    while (FCGI_Accept() >= 0) {
        printf(
            "Content-type: text/html\r\nStatus: 200 OK\r\n\r\nHello World!\n");
    }
    return 0;
}

/*!
 * Part 3:
 * make
 * install nginx, spawn-fcgi
 * sudo cp nginx.conf /etc/nginx/nginx.conf
 * sudo nginx -s reload && nginx
 * spawn-fcgi -p 8080 hello.fcgi
 * curl localhost:81
 */
