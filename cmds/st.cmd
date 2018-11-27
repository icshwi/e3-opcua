require opcua,0.0.0

epicsEnvSet(TOP, "$(E3_CMD_TOP)/..")

epicsEnvSet("SESSION",   "OPC1")
epicsEnvSet("SUBSCRIPT", "SUB1")

opcuaCreateSession $(SESSION) opc.tcp://127.0.0.1:48020
opcuaCreateSubscription $(SUBSCRIPT) $(SESSION) 200

#dbLoadRecords("uasdk-server-ess.db","P=OPC:,R=,SESS=$(SESSION),SUBS=$(SUBSCRIPT)")
dbLoadRecords("opcuaServerInfo.template",   "P=OPC:,R=,SESS=$(SESSION)")
dbLoadRecords("opcuaServerStats.template",  "P=OPC:,R=,SESS=$(SESSION),SUBS=$(SUBSCRIPT)")
dbLoadRecords("$(TOP)/template/UAopcuaDemoServer.template", "P=OPC:,R=,SESS=$(SESSION),SUBS=$(SUBSCRIPT)")


iocInit()

dbl > "$(TOP)/$(SESSION)_PVs.list"
