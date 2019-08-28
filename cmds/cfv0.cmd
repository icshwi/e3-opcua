#require iocStats,ae5d083

require opcua,0.3.1

epicsEnvSet(TOP, "$(E3_CMD_TOP)/..")

epicsEnvSet("SESSION",   "OPC1")
epicsEnvSet("SUBSCRIPT", "SUB1")
epicsEnvSet("OPCSERVER", "172.17.3.1")
epicsEnvSet("OPCPORT", "21381/MatrikonOpcUaWrapper")
#iocshLoad("$(iocstats_DIR)/iocStats.iocsh", "IOCNAME=$(SESSION):$(SUBSCRIPT)")
iocshLoad("$(TOP)/iocsh/opcua.iocsh", "P=OPC:,SESS=$(SESSION),SUBS=$(SUBSCRIPT),INET=$(OPCSERVER),PORT=$(OPCPORT),DEBUG=1, SUBSDEBUG=0")

dbLoadRecords("$(TOP)/template/UaOpcServerExtra.template", "P=OPC:,R=Demo:,SESS=$(SESSION),SUBS=$(SUBSCRIPT)")
dbLoadRecords("$(TOP)/template/ABBServer.template", "P=OPC:,R=Demo:,SESS=$(SESSION),SUBS=$(SUBSCRIPT)")

iocInit()

dbl > "$(TOP)/$(SESSION)_PVs.list"

