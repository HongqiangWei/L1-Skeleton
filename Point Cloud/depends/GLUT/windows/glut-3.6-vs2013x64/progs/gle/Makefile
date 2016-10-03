# Makefile for Win32

!include <win32.mak>

TOP  = ../..
SRCS = beam.c candlestick.c cone.c cylinder.c helix.c helix2.c helix3.c helix4.c helixtex.c horn.c joincone.c joinoffset.c screw.c taper.c texas.c twoid.c twistoid.c

EXTRALIBS = $(GLE)

!include "$(TOP)/glutwin32.mak"

joincone.obj: cone.obj
	copy cone.obj joincone.obj

# dependencies
beam.exe	: mainsimple.obj
cylinder.exe	: mainsimple.obj
cone.exe	: mainsimple.obj
helix.exe	: mainsimple.obj
helix2.exe	: mainsimple.obj
helix3.exe	: mainsimple.obj
helix4.exe	: mainsimple.obj
helixtex.exe	: texture.obj maintex.obj
horn.exe	: mainsimple.obj
joincone.exe	: mainjoin.obj
joinoffset.exe	: mainjoin.obj
screw.exe	: texture.obj maintex.obj
taper.exe	: mainsimple.obj
texas.exe	: mainjoin.obj
twistoid.exe	: texture.obj maintex.obj
