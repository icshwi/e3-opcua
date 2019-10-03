require opcua,0.3.1

epicsEnvSet(TOP, "$(E3_CMD_TOP)/..")

epicsEnvSet("SESSION",   "OPC_VVS_00")
epicsEnvSet("SUBSCRIPT", "S7PLC")
epicsEnvSet("OPCSERVER", "172.16.45.135")
iocshLoad("$(TOP)/iocsh/opcua.iocsh", "P=OPC-MPSVAC:,SESS=$(SESSION),SUBS=$(SUBSCRIPT),INET=$(OPCSERVER),PORT=4840,DEBUG=1, SUBSDEBUG=0")

dbLoadRecords("$(TOP)/template/MPSVac_VVS.db", "P=OPC-MPSVAC:,R=S7PLC-MPSVac:,SUBS=$(SUBSCRIPT)")
dbLoadRecords("$(TOP)/template/MPSVac_State_Machine.db", "P=OPC-MPSVac:,R=S7PLC-MPSVac:,SUBS=$(SUBSCRIPT)")
dbLoadRecords("$(TOP)/template/MPSVac_Masking.db", "P=OPC-MPSVac:,R=S7PLC-MPSVac:,SUBS=$(SUBSCRIPT)")
dbLoadRecords("$(TOP)/template/MPSVac_BM_BD.db", "P=OPC-MPSVac:,R=S7PLC-MPSVac:,SUBS=$(SUBSCRIPT)")
dbLoadRecords("$(TOP)/template/MPSVac_FBIS.db", "P=OPC-MPSVac:,R=S7PLC-MPSVac:,SUBS=$(SUBSCRIPT)")
dbLoadRecords("$(TOP)/template/MPSVac_Rearm_Reint.db", "P=OPC-MPSVac:,R=S7PLC-MPSVac:,SUBS=$(SUBSCRIPT)")
dbLoadRecords("$(TOP)/template/MPSVac_Checksum.db", "P=OPC-MPSVac:,R=S7PLC-MPSVac:,SUBS=$(SUBSCRIPT)")

iocInit()

dbl > "$(TOP)/$(SESSION)_PVs.list"

