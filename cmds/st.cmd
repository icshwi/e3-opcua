require opcua,0.0.0


epicsEnvSet(TOP, "$(E3_CMD_TOP)/..")

## Pretty minimal setup: one session with a 200ms subscription on top

epicsEnvSet("SESSION",   "OPC1")
epicsEnvSet("SUBSCRIPT", "SUB1")

opcuaCreateSession $(SESSION) opc.tcp://localhost:48020
opcuaCreateSubscription $(SUBSCRIPT) $(SESSION) 200

dbLoadRecords("uasdk-server-ess.db","P=OPC:,R=,SESS=$(SESSION),SUBS=$(SUBSCRIPT)")

iocInit()


dbl > "$(TOP)/$(SESSION)_PVs.list"
