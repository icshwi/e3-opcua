
require opcua,0.5.2
require iocStats,3.1.16

epicsEnvSet(TOP, "$(E3_CMD_TOP)/..")

epicsEnvSet("SESSION",   "OPC1")
epicsEnvSet("SUBSCRIPT", "SUB1")
epicsEnvSet("OPCSERVER", "172.17.3.1")
epicsEnvSet("OPCPORT", "21381/MatrikonOpcUaWrapper")
#epicsEnvSet("OPCPORT", "21381")
#iocshLoad("$(iocstats_DIR)/iocStats.iocsh", "IOCNAME=$(SESSION):$(SUBSCRIPT)")
iocshLoad("$(TOP)/iocsh/opcua.iocsh", "P=OPC:,SESS=$(SESSION),SUBS=$(SUBSCRIPT),INET=$(OPCSERVER),PORT=$(OPCPORT),SUBSTIME=1000, DEBUG=1, SUBSDEBUG=0")

dbLoadRecords("$(TOP)/template/ABBServer.template", "P=OPC:,R=Demo:,SESS=$(SESSION),SUBS=$(SUBSCRIPT)")

iocInit()

dbl > "$(TOP)/$(SESSION)_PVs.list"

