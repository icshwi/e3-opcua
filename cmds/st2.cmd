require opcua,0.0.0

epicsEnvSet(TOP, "$(E3_CMD_TOP)/..")

epicsEnvSet("SESSION",   "OPC1")
epicsEnvSet("SUBSCRIPT", "SUB1")
epicsEnvSet("OPCSERVER", "127.0.0.1")

loadIocsh("opcua.iocsh", "P=OPC:,SESS=$(SESSION),SUBS=$(SUBSCRIPT),INET=$(OPCSERVER)")

dbLoadRecords("$(TOP)/template/UAopcuaDemoServer.template", "P=OPC:,R=,SESS=$(SESSION),SUBS=$(SUBSCRIPT)")


iocInit()

dbl > "$(TOP)/$(SESSION)_PVs.list"

