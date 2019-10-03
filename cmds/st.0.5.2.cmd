require opcua,0.5.2
require iocStats,3.1.16

epicsEnvSet(TOP, "$(E3_CMD_TOP)/..")

epicsEnvSet("SESSION",   "UAOPC")
epicsEnvSet("SUBSCRIPT", "SUB1")
epicsEnvSet("OPCSERVER", "127.0.0.1")
epicsEnvSet("PORT", "48020")

iocshLoad("$(opcua_DIR)/opcua.iocsh", "P=$(SESSION):,SESS=$(SESSION),SUBS=$(SUBSCRIPT),INET=$(OPCSERVER), PORT=$(PORT), DEBUG=0, SUBSDEBUG=0")

iocshLoad("$(iocStats_DIR)/iocStats.iocsh", "IOCNAME=$(SESSION)")
dbLoadRecords("$(TOP)/template/UaOpcUaAnsiCDemoServer.template", "P=$(SESSION):,R=Demo:,SESS=$(SESSION),SUBS=$(SUBSCRIPT)")


iocInit()

dbl > "$(TOP)/$(SESSION)_PVs.list"

