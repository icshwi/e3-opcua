require opcua,0.5.2
require iocStats,3.1.16

epicsEnvSet(TOP, "$(E3_CMD_TOP)/..")
epicsEnvSet("IOCNAME",    "UAOPC")

#
epicsEnvSet("SESSION1",   "$(IOCNAME)1")
epicsEnvSet("SUBSCRIPT1", "SUB1")
epicsEnvSet("OPCSERVER1", "127.0.0.1")
epicsEnvSet("PORT1", "48020")
iocshLoad("$(opcua_DIR)/opcua.iocsh", "P=$(SESSION1):,SESS=$(SESSION1),SUBS=$(SUBSCRIPT1),INET=$(OPCSERVER1), PORT=$(PORT1), DEBUG=0, SUBSDEBUG=0")
dbLoadRecords("$(TOP)/template/UaOpcUaAnsiCDemoServer.template", "P=$(SESSION1):,R=Demo:,SESS=$(SESSION1),SUBS=$(SUBSCRIPT1)")

#
epicsEnvSet("SESSION2",   "$(IOCNAME)2")
epicsEnvSet("SUBSCRIPT2", "SUB2")
epicsEnvSet("OPCSERVER2", "opcua.rocks")
epicsEnvSet("PORT2",      "4840")
iocshLoad("$(opcua_DIR)/opcua.iocsh", "P=$(SESSION2):,SESS=$(SESSION2),SUBS=$(SUBSCRIPT2),INET=$(OPCSERVER2), PORT=$(PORT2), DEBUG=0, SUBSDEBUG=0")

#
epicsEnvSet("SESSION3",   "$(IOCNAME)3")
epicsEnvSet("SUBSCRIPT3", "SUB3")
epicsEnvSet("OPCSERVER3", "milo.digitalpetri.com")
epicsEnvSet("PORT3", "62541/milo")
iocshLoad("$(opcua_DIR)/opcua.iocsh", "P=$(SESSION3):,SESS=$(SESSION3),SUBS=$(SUBSCRIPT3),INET=$(OPCSERVER3), PORT=$(PORT3), DEBUG=0, SUBSDEBUG=0")
dbLoadRecords("$(TOP)/template/MiloDigitalPetriDemoServer.template", "P=$(SESSION3):,R=Demo:,SESS=$(SESSION3),SUBS=$(SUBSCRIPT3)")

epicsEnvSet("SESSION4",   "$(IOCNAME)4")
epicsEnvSet("SUBSCRIPT4", "SUB4")
epicsEnvSet("OPCSERVER4", "opcuademo.sterfive.com")
epicsEnvSet("PORT4", "26543")
iocshLoad("$(opcua_DIR)/opcua.iocsh", "P=$(SESSION4):,SESS=$(SESSION4),SUBS=$(SUBSCRIPT4),INET=$(OPCSERVER4), PORT=$(PORT4), DEBUG=0, SUBSDEBUG=0")
dbLoadRecords("$(TOP)/template/SterfiveDemoServer.template", "P=$(SESSION4):,R=Demo:,SESS=$(SESSION4),SUBS=$(SUBSCRIPT4)")

iocshLoad("$(iocStats_DIR)/iocStats.iocsh", "IOCNAME=$(IOCNAME)")



iocInit()

dbl > "$(TOP)/$(IOCNAME)_PVs.list"

