
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


## Test Server Configuration

One can download the UA OPCUA server from its own site [1]. Its configuration and running environment is found at [2]. 

## Start an IOC
```
jhlee@kaffee:~/e3-3.15.5/e3-opcua$ iocsh.bash cmds/st.cmd

.....

iocshLoad 'cmds/st.cmd',''
require opcua,0.0.0
Module opcua version 0.0.0 found in /epics/base-3.15.5/require/3.0.4/siteApps/opcua/0.0.0/
Loading library /epics/base-3.15.5/require/3.0.4/siteApps/opcua/0.0.0/lib/linux-x86_64/libopcua.so
Loaded opcua version 0.0.0
Loading dbd file /epics/base-3.15.5/require/3.0.4/siteApps/opcua/0.0.0/dbd/opcua.dbd
Calling function opcua_registerRecordDeviceDriver
Loading module info records for opcua
epicsEnvSet(TOP, "/home/jhlee/e3-3.15.5/e3-opcua/cmds/..")
## Pretty minimal setup: one session with a 200ms subscription on top
epicsEnvSet("SESSION",   "OPC1")
epicsEnvSet("SUBSCRIPT", "SUB1")
opcuaCreateSession OPC1 opc.tcp://localhost:48020
opcuaCreateSubscription SUB1 OPC1 200
dbLoadRecords("uasdk-server-ess.db","P=OPC:,R=,SESS=OPC1,SUBS=SUB1")
iocInit()
Starting iocInit
############################################################################
## EPICS R3.15.5-E3-3.15.5-patch
## EPICS Base built Nov 20 2018
############################################################################
OPC UA: Autoconnecting sessions
OPC UA session OPC1: connection status changed from Disconnected to Connected
iocRun: All initialization complete
dbl > "/home/jhlee/e3-3.15.5/e3-opcua/cmds/../OPC1_PVs.list"
# Set the IOC Prompt String One 
epicsEnvSet IOCSH_PS1 "350b5cb.kaffee.8471 > "
#
350b5cb.kaffee.8471 > 
```

* Get PVs from the uasdk-server-ess.db, which is the exactly same as the substitutions file [3].

```
OPC:CurrentSessionCount        2
OPC:CurrentSubscriptionCount   2
OPC:CumulatedSessionCount      3
OPC:CumulatedSubscriptionCount 3
OPC:ServerState                Running
OPC:ManufacturerName           Unified Automation GmbH
OPC:ProductName                ANSI C SDK UA Sample Server
OPC:SoftwareVersion            V1.8.3 / 149ebb531cbbd67a7f48ea1509d320
OPC:CurrentTime                2018-11-27T13:17:10.989Z
OPC:StartTime                  2018-11-27T13:03:56.234Z
```

## Unified Automation Demo Server DB template

* [UA Demo Server DB Template](template/UAopcuaDemoServer.template)
* Address Space (name space) : ```ns=4```
* NodeId Identifier string : ```s=Demo.AccessRights.Access_All.All_RW```


## Reference

[1] https://www.unified-automation.com/downloads/opc-ua-servers
[2] https://github.com/jeonghanlee/opcua-server
[3] exampleTop/DeviceDbApp/S7-1500-server.substitutions
