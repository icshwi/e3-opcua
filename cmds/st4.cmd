require opcua,devel

epicsEnvSet(TOP, "$(E3_CMD_TOP)/..")

epicsEnvSet("SESSION",   "OPC1")
epicsEnvSet("SUBSCRIPT", "SUB1")
epicsEnvSet("OPCSERVER", "127.0.0.1")
#epicsEnvSet("OPCSERVER", "10.0.6.32")
#epicsEnvSet("OPCSERVER", "proton")

iocshLoad("$(TOP)/iocsh/opcua.iocsh", "P=OPC:,SESS=$(SESSION),SUBS=$(SUBSCRIPT),INET=$(OPCSERVER), DEBUG=5, SUBSDEBUG=0")


dbLoadRecords("$(TOP)/opcua-dev/exampleTop/TemplateDbSup/AnyServerDb/opcuaServerInfo.template",   "P=OPC:,R=,SESS=$(SESSION),SUBS=$(SUBSCRIPT)")
dbLoadRecords("$(TOP)/opcua-dev/exampleTop/TemplateDbSup/AnyServerDb/opcuaServerStats.template",  "P=OPC:,R=,SESS=$(SESSION),SUBS=$(SUBSCRIPT)")
#dbLoadRecords("$(TOP)/template/UaOpcUaAnsiCDemoServer.template", "P=OPC:,R=Demo:,SESS=$(SESSION),SUBS=$(SUBSCRIPT)")


iocInit()

dbl > "$(TOP)/$(SESSION)_PVs.list"

