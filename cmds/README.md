
## OPC UA Demo Server Configuration

```
opcua-server (master)$ ./start_server.bash edit
```

Replace [gethostname] with its ip address

```
Endpoints/0/EndpointURL = opc.tcp://10.0.6.172:48020
Endpoints/0/BindURL = opc.tcp://10.0.6.172:48020

```

