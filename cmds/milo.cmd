require opcua,devel

epicsEnvSet(TOP, "$(E3_CMD_TOP)/..")


epicsEnvSet("SESSION",   "MILO")
epicsEnvSet("SUBSCRIPT", "SUB1")
epicsEnvSet("OPCSERVER", "milo.digitalpetri.com")
epicsEnvSet("PORT", "62541/milo")

# opc.tcp://milo.digitalpetri.com:62541/milo
# MILO:ServerManufacturerName    Industrial Softworks
# MILO:ServerProductName         Eclipse Milo OPC UA Demo Server
# MILO:ServerSoftwareVersion     dev

iocshLoad("$(TOP)/iocsh/opcua.iocsh", "P=$(SESSION):,SESS=$(SESSION),SUBS=$(SUBSCRIPT),INET=$(OPCSERVER), PORT=$(PORT), DEBUG=5, SUBSDEBUG=0")


dbLoadRecords("$(TOP)/template/opcuaServerStatus.template",   "P=$(SESSION):,R=,SESS=$(SESSION),SUBS=$(SUBSCRIPT)")
#dbLoadRecords("$(TOP)/template/opcuaServerStats.template",  "P=$(SESSION):,R=,SESS=$(SESSION),SUBS=$(SUBSCRIPT)")

#dbLoadRecords("$(TOP)/template/UaOpcUaAnsiCDemoServer.template", "P=OPC:,R=Demo:,SESS=$(SESSION),SUBS=$(SUBSCRIPT)")


iocInit()

dbl > "$(TOP)/$(SESSION)_PVs.list"

