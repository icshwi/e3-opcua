require opcua,0.0.0

epicsEnvSet(TOP, "$(E3_CMD_TOP)/..")

epicsEnvSet("SESSION",   "OPC1")
epicsEnvSet("SUBSCRIPT", "SUB1")
epicsEnvSet("OPCSERVER", "127.0.0.1")
#epicsEnvSet("OPCSERVER", "10.0.6.172")
loadIocsh("opcua.iocsh", "P=OPC:,SESS=$(SESSION),SUBS=$(SUBSCRIPT),INET=$(OPCSERVER)")

dbLoadRecords("$(TOP)/template/UaOpcUaAnsiCDemoServer.template", "P=OPC:,R=,SESS=$(SESSION),SUBS=$(SUBSCRIPT)")


iocInit()

dbl > "$(TOP)/$(SESSION)_PVs.list"

