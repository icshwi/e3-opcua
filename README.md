
e3-opcua  
======
ESS Site-specific EPICS module : opcua


## Unified Automation OPC UA C++ SDK Configuration

* Debian OS
```
apt install libssl-dev  libxml2-dev 
```

* Build SDK with SHARED_LIBS
```
UASDK $ ./buildSdk.sh -s ON
```


## e3 Configuration


* CONFIG_OPTIONS

```
WITH_UASDK:=$(UASDK)
WITH_UASDK_USE_XMLPARSER:=YES
WITH_UASDK_USE_CRYPTO:=YES
```
, where UASDK is the path to the Unified Automation OPC UA C++ SDK.

The original opcua epics module supports the following option in order to handle its shared libraries :
* SYSTEM   = shared libs are in a system location
* PROVIDED = shared libs are in $(UASDK_DIR)
* INSTALL  = shared libs are installed (copied) into this module
However, e3-opcua only supports INSTALL only.

