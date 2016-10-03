# Makefile for Win32

!include <win32.mak>

TOP  = ../../..
SRCS = bounce.c

!include "$(TOP)/glutwin32.mak"

trackball.c:
	copy ..\..\examples\trackball.c trackball.c

trackball.h:
	copy ..\..\examples\trackball.h trackball.h

tb.c:
	copy ..\smooth\tb.c tb.c

tb.h:
	copy ..\smooth\tb.h tb.h

# dependencies
bounce.exe	: glui.obj tb.obj trackball.obj
bounce.obj	: bounce.c tb.h glui.h
glui.obj	: glui.c glui.h
tb.obj		: tb.c tb.h trackball.h
