
## OPC UA Demo Server Configuration

```
opcua-server (master)$ ./start_server.bash edit
```

Replace [gethostname] with 127.0.0.1

```
Endpoints/0/EndpointURL = opc.tcp://127.0.0.1:48020
Endpoints/0/BindURL = opc.tcp://127.0.0.1:48020

```

