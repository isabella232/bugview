#
# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at http://mozilla.org/MPL/2.0/.
#

#
# Copyright 2019, Joyent, Inc.
#

#
# bugview Makefile
#

#
# Tools
#



JS_FILES = \
	jirapub.js \
	lib/backend_jira.js \
	lib/backend_files.js
JSSTYLE_FILES	= $(JS_FILES)
JSSTYLE_FLAGS	= -f tools/jsstyle.conf
ESLINT_FILES	= $(JS_FILES)

ifeq ($(shell uname -s),SunOS)
	NODE_PREBUILT_VERSION =	v4.6.1
	NODE_PREBUILT_TAG =	zone
	NODE_PREBUILT_IMAGE =	18b094b0-eb01-11e5-80c1-175dac7ddf02
endif

include ./tools/mk/Makefile.defs
ifeq ($(shell uname -s),SunOS)
	include ./tools/mk/Makefile.node_prebuilt.defs
else
	NODE := node
	NPM := $(shell which npm)
	NPM_EXEC=$(NPM)
endif

#
# Repo-specific targets
#

.PHONY: all
all: | $(NPM_EXEC) 0-npm-stamp

0-npm-stamp:
	$(NPM) install
	touch $@

CLEAN_FILES += ./node_modules/ 0-npm-stamp

include ./tools/mk/Makefile.deps
ifeq ($(shell uname -s),SunOS)
	include ./tools/mk/Makefile.node_prebuilt.targ
endif
include ./tools/mk/Makefile.targ
