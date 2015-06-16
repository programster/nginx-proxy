This is forked version of [jwilder/nginx-proxy](https://github.com/jwilder/nginx-proxy).

### Main differences
* uses nginx-extras from Ubuntu repositories rather than disabling the repositories and installing from a PPA.
* uses the cron service to tie up the docker foreground process instead of switching daemon mode off in nginx. This means you can restart the nginx service.
* Trying to implement CORS support through setting the ALLOW_CROSS_DOMAIN_REQUESTS environment variable on the web application containers.
