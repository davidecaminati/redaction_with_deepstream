 # Copyright (c) 2018, NVIDIA CORPORATION. All rights reserved.
 #
 # Permission is hereby granted, free of charge, to any person obtaining a
 # copy of this software and associated documentation files (the "Software"),
 # to deal in the Software without restriction, including without limitation
 # the rights to use, copy, modify, merge, publish, distribute, sublicense,
 # and/or sell copies of the Software, and to permit persons to whom the
 # Software is furnished to do so, subject to the following conditions:
 #
 # The above copyright notice and this permission notice shall be included in
 # all copies or substantial portions of the Software.
 #
 # THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 # IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 # FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
 # THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 # LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
 # FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
 # DEALINGS IN THE SOFTWARE.

APP:= deepstream-redaction-app

NVDS_VERSION:=4.0

LIB_INSTALL_DIR?=/opt/nvidia/deepstream/deepstream-$(NVDS_VERSION)/lib/

SRCS:= $(wildcard *.c)

INCS:= $(wildcard *.h)

PKGS:= gstreamer-1.0

OBJS:= $(SRCS:.c=.o)

CFLAGS:= -I../../includes

CFLAGS+= `pkg-config --cflags $(PKGS)`

LIBS:= `pkg-config --libs $(PKGS)`

LIBS+= -L$(LIB_INSTALL_DIR) -lnvdsgst_meta -lnvds_meta \
       -Wl,-rpath,$(LIB_INSTALL_DIR)

all: $(APP)

.o: .c $(INCS) Makefile
	$(CC) -c $@ $(CFLAGS) $<

$(APP): $(OBJS) Makefile
	$(CC) -o $(APP) $(OBJS) $(LIBS)

clean:
	rm -rf $(OBJS) $(APP)


