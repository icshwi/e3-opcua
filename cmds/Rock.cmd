require opcua,devel

epicsEnvSet(TOP, "$(E3_CMD_TOP)/..")


epicsEnvSet("SESSION",   "ROCK")
epicsEnvSet("SUBSCRIPT", "SUB1")
epicsEnvSet("OPCSERVER", "opcua.rocks")
epicsEnvSet("PORT", "4840")
#opc.tcp://opcua.rocks:4840
iocshLoad("$(TOP)/iocsh/opcua.iocsh", "P=$(SESSION):,SESS=$(SESSION),SUBS=$(SUBSCRIPT),INET=$(OPCSERVER), PORT=$(PORT), DEBUG=5, SUBSDEBUG=0")


dbLoadRecords("$(TOP)/template/opcuaServerStatus.template",   "P=$(SESSION):,R=,SESS=$(SESSION),SUBS=$(SUBSCRIPT)")
#dbLoadRecords("$(TOP)/template/opcuaServerStats.template",  "P=$(SESSION):,R=,SESS=$(SESSION),SUBS=$(SUBSCRIPT)")

#dbLoadRecords("$(TOP)/template/UaOpcUaAnsiCDemoServer.template", "P=OPC:,R=Demo:,SESS=$(SESSION),SUBS=$(SUBSCRIPT)")


iocInit()

dbl > "$(TOP)/$(SESSION)_PVs.list"

