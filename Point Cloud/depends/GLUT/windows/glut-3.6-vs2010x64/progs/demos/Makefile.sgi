#!smake
#
# Copyright (c) Mark J. Kilgard, 1995, 1997.
#
include $(ROOT)/usr/include/make/commondefs

TOP = ../..

SUBDIRS = ideas atlantis walker yacme glutmech geoface \
  chess rollercoaster underwater opengl_logo bluepony \
  lorenz smooth gliq glflare bounce

default $(COMMONTARGS): $(_FORCE)
	$(SUBDIRS_MAKERULE)

$(SUBDIRS): $(_FORCE)
	cd $@; $(MAKE)

$(_FORCE):
