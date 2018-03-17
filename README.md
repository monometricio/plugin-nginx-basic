# plugin-nginx-basic
Monometric.IO nginx plugin (https://monometric.io)

## Description

This plugin will query nginx via the ngx_http_stub_status_module and provide metrics.

## Installation

```mm-plugins install monometricio/plugin-nginx-basic```

```mm-plugins enable monometricio/plugin-nginx-basic```

You should see the plugin when running ```mm-plugins list```.

Remember to edit the configuration file ```/etc/mm-agent/plugins/monometricio-plugin-nginx-basic.conf```.

## Provided metrics

| Key        | Description  |
| ------------- |:-------------|
| nginx.active_connections | current active connections | 
| nginx.reading | The current number of connections where nginx is reading the request header. 
| nginx.writing | The current number of connections where nginx is writing the response back to the client.
| nginx.waiting | The current number of idle client connections waiting for a request. 
| _counter.nginx.accepts | The rate of of accepted client connections. | 
| _counter.nginx.handled | The rate of handled connections
| _counter.nginx.requests_per_sec | The rate of requests | 
| nginx.cpu_usage_percent | The sum of CPU usage by nginx processes | 
| nginx.mem_usage_percen | The sum of memory usage by nginx processes |

## Configuration

For the plugin to work, it needs a valid server stub URL, and this must be configured in NGINX.

Example NGINX configuration (inside server block):

```
location /nginx-status {
    allow 127.0.0.1;
    deny all;
    stub_status;
}
```

Example nginx plugin configuration:

```
[Env]
NGINX_URL=http://127.0.0.1/nginx-status
```

## Additional information
Further documentation about the nginx stub module can be found on:
http://nginx.org/en/docs/http/ngx_http_stub_status_module.html

## Testing configuration

You can test-run the plugin and verify the output by running:

```mm-plugins run monometricio/plugin-nginx-basic```
