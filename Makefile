#!/usr/bin/make -f

# Makefile for git-update
# SPDX-License-Identifier: GPL-3.0

SHELL=/bin/bash
include config.mk

.PHONY: install uninstall

install: $(SCRIPT).bash $(SCRIPT).1
	install -m 0755 $(SCRIPT).bash $(BINDIR)/$(SCRIPT)
	install -m 0644 $(SCRIPT).1 $(MANDIR)

uninstall:
	rm -f $(BINDIR)/$(SCRIPT)
	rm -f $(MANDIR)/$(SCRIPT).1
