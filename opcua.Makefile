#
#  Copyright (c) 2018 - Present  European Spallation Source ERIC
#
#  The program is free software: you can redistribute
#  it and/or modify it under the terms of the GNU General Public License
#  as published by the Free Software Foundation, either version 2 of the
#  License, or any newer version.
#
#  This program is distributed in the hope that it will be useful, but WITHOUT
#  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
#  FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
#  more details.
#
#  You should have received a copy of the GNU General Public License along with
#  this program. If not, see https://www.gnu.org/licenses/gpl-2.0.txt
#
# 
# Author  : Jeong Han Lee
# email   : jeonghan.lee@gmail.com
# Date    : Saturday, December  8 11:21:13 CET 2018
# version : 0.0.3
#

## The following lines are mandatory, please don't change them.
where_am_I := $(dir $(abspath $(lastword $(MAKEFILE_LIST))))
include $(E3_REQUIRE_TOOLS)/driver.makefile
include $(E3_REQUIRE_CONFIG)/DECOUPLE_FLAGS
include $(where_am_I)/configure/CONFIG_OPCUA_VERSION


## Exclude linux-ppc64e6500
EXCLUDE_ARCHS = linux-ppc64e6500


OPCUASRC:=devOpcuaSup
UASDKSRC:=$(OPCUASRC)/UaSdk
EXAMPLEDB:=exampleTop/TemplateDbSup/AnyServerDb


USR_INCLUDES += -I$(COMMON_DIR)
USR_INCLUDES += -I$(where_am_I)$(OPCUASRC)
USR_INCLUDES += -I$(where_am_I)$(UASDKSRC)


### In order to use the same codes in RULES_OPCUA
UASDK:=$(WITH_UASDK)
UASDK_USE_XMLPARSER:=$(WITH_UASDK_USE_XMLPARSER)
UASDK_USE_CRYPTO:=$(WITH_UASDK_USE_CRYPTO)


### START ### RULES_OPCUA
UASDK_MODULES = uaclient uapki uabase uastack
ifeq ($(UASDK_USE_XMLPARSER),YES)
UASDK_MODULES += xmlparser
endif
ifeq ($(UASDK_USE_CRYPTO),YES)
USR_SYS_LIBS += crypto
endif

# Depending on SDK version, C++ modules may have a 'cpp' suffix
UASDK_LIBS = $(notdir $(wildcard $(foreach module, $(UASDK_MODULES), \
    $(UASDK)/include/$(module) $(UASDK)/include/$(module)cpp)))

USR_INCLUDES += $(foreach lib, $(UASDK_LIBS), -I$(UASDK)/include/$(lib))
### END ### RULES_OPCUA


USR_CXXFLAGS_Linux += -std=c++11
#USR_CXXFLAGS += -DUSE_TYPED_RSET

TEMPLATES += $(wildcard $(EXAMPLEDB)/*.template)
TEMPLATES += $(wildcard $(EXAMPLEDB)/*.db)


ifeq ($(T_A),linux-x86_64)
USR_LDFLAGS += -Wl,--enable-new-dtags
USR_LDFLAGS += -Wl,-rpath=$(E3_MODULES_VENDOR_LIBS_LOCATION)
USR_LDFLAGS += -L$(E3_MODULES_VENDOR_LIBS_LOCATION)
LIB_SYS_LIBS += $(UASDK_LIBS)
endif


VENDOR_LIBS += $(foreach lib, $(UASDK_LIBS), $(UASDK)/lib/lib$(lib).so)


# Generic sources and interfaces

DBDS    += $(UASDKSRC)/opcuaUaSdk.dbd
DBDS    += $(UASDKSRC)/opcua.dbd
SOURCES += $(UASDKSRC)/Session.cpp
SOURCES += $(UASDKSRC)/SessionUaSdk.cpp
SOURCES += $(UASDKSRC)/Subscription.cpp
SOURCES += $(UASDKSRC)/SubscriptionUaSdk.cpp
SOURCES += $(UASDKSRC)/ItemUaSdk.cpp
SOURCES += $(UASDKSRC)/DataElementUaSdk.cpp
SOURCES += $(UASDKSRC)/iocshIntegrationUaSdk.cpp


DBDS    += $(OPCUASRC)/devOpcua.dbd
SOURCES += $(OPCUASRC)/devOpcua.cpp
SOURCES += $(OPCUASRC)/iocshIntegration.cpp
SOURCES += $(OPCUASRC)/RecordConnector.cpp
SOURCES += $(OPCUASRC)/linkParser.cpp


HEADERS += $(OPCUASRC)/devOpcuaVersion.h
HEADERS += $(COMMON_DIR)/devOpcuaVersionNum.h


## xxxRecord.dbd Local Codes 
DBDINC_SUFF = cpp
DBDINC_PATH = $(OPCUASRC)
DBDINC_SRCS = $(DBDINC_PATH)/opcuaItemRecord.$(DBDINC_SUFF)

## xxxRecord.dbd Generic Codes : BEGIN
DBDINC_DBDS = $(subst .$(DBDINC_SUFF),.dbd,   $(DBDINC_SRCS:$(DBDINC_PATH)/%=%))
DBDINC_HDRS = $(subst .$(DBDINC_SUFF),.h,     $(DBDINC_SRCS:$(DBDINC_PATH)/%=%))
DBDINC_DEPS = $(subst .$(DBDINC_SUFF),$(DEP), $(DBDINC_SRCS:$(DBDINC_PATH)/%=%))

HEADERS += $(DBDINC_HDRS)
SOURCES += $(DBDINC_SRCS)

$(DBDINC_DEPS): $(DBDINC_HDRS)

.dbd.h:
	$(DBTORECORDTYPEH)  $(USR_DBDFLAGS) -o $@ $<

.PHONY: $(DBDINC_DEPS) .dbd.h
## Record.dbd Generic codes : END

opcuaItemRecord$(DEP): $(COMMON_DIR)/devOpcuaVersionNum.h



# Module versioning
EXPANDVARS  += EPICS_OPCUA_MAJOR_VERSION
EXPANDVARS  += EPICS_OPCUA_MINOR_VERSION
EXPANDVARS  += EPICS_OPCUA_MAINTENANCE_VERSION
EXPANDVARS  += EPICS_OPCUA_DEVELOPMENT_FLAG
EXPANDFLAGS += $(foreach var,$(EXPANDVARS),-D$(var)="$(strip $($(var)))")



$(COMMON_DIR)/devOpcuaVersionNum.h: $(OPCUASRC)/devOpcuaVersionNum.h@
	$(EXPAND_TOOL) $(EXPANDFLAGS) $($@_EXPANDFLAGS) $< $@

SCRIPTS += $(wildcard ../iocsh/*.iocsh)




USR_DBFLAGS += -I . -I ..
USR_DBFLAGS += -I $(EPICS_BASE)/db
USR_DBFLAGS += -I $(EXAMPLEDB)

SUBS=$(wildcard $(EXAMPLEDB)/*.substitutions)
#TMPS=$(wildcard $(APPDB)/*.template)
TMPS=

db: $(SUBS) $(TMPS)

$(SUBS):
	@printf "Inflating database ... %44s >>> %40s \n" "$@" "$(basename $(@)).db"
	@rm -f  $(basename $(@)).db.d  $(basename $(@)).db
	$(MSI) -D $(USR_DBFLAGS) -o $(basename $(@)).db -S $@ > $(basename $(@)).db.d
	$(MSI)    $(USR_DBFLAGS) -o $(basename $(@)).db -S $@

$(TMPS):
	@printf "Inflating database ... %44s >>> %40s \n" "$@" "$(basename $(@)).db"
	@rm -f  $(basename $(@)).db.d  $(basename $(@)).db
	@$(MSI) -D $(USR_DBFLAGS) -o $(basename $(@)).db $@  > $(basename $(@)).db.d
	@$(MSI)    $(USR_DBFLAGS) -o $(basename $(@)).db $@


.PHONY: db $(SUBS) $(TMPS)


vlibs: $(VENDOR_LIBS)

$(VENDOR_LIBS):
	$(QUIET)$(SUDO) install -m 555 -d $(E3_MODULES_VENDOR_LIBS_LOCATION)/
	$(QUIET)$(SUDO) install -m 555 $@ $(E3_MODULES_VENDOR_LIBS_LOCATION)/

.PHONY: $(VENDOR_LIBS) vlibs



