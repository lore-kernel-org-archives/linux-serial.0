From: "Adam J. Richter" <adam@yggdrasil.com>
Subject: Re: Linux 2.5.30: [SERIAL] build fails at 8250.c
Date: Fri, 2 Aug 2002 17:20:28 -0700
Sender: linux-serial-owner@vger.kernel.org
Message-ID: <200208030020.RAA05695@baldur.yggdrasil.com>
Return-path: <linux-serial-owner@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org
To: rmk@arm.linux.org.uk
Cc: axel@hh59.org, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, tytso@mit.edu

On Sat, 3 Aug 2002 01:12:10 +0100, Russell King wrote:
>Ok, here's a fix for the 8250.c build problem (please don't send it
>to Linus; I've other changes that'll be going via BK and patch to
>lkml pending):
>
>--- orig/drivers/serial/8250.c  Fri Aug  2 21:13:31 2002
>+++ linux/drivers/serial/8250.c Sat Aug  3 00:28:47 2002
>@@ -31,7 +31,8 @@
> #include <linux/console.h>
> #include <linux/sysrq.h>
> #include <linux/serial_reg.h>
>-#include <linux/serialP.h>
>+#include <linux/circ_buf.h>
>+#include <linux/serial.h>
> #include <linux/delay.h>
> 
> #include <asm/io.h>

	Your patch still results in a compilation error for me.
It looks like 8250.c needs <linux/serialP.h> for ALPHA_KLUDGE_MCR:

  gcc -Wp,-MD,./.8250.o.d -D__KERNEL__ -I/usr/src/linux/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 -march=i386 -nostdinc -iwithprefix include -DMODULE -include /usr/src/linux/include/linux/modversions.h   -DKBUILD_BASENAME=8250 -DEXPORT_SYMTAB  -c -o 8250.o 8250.c
8250.c: In function `serial8250_set_mctrl':
8250.c:1061: `ALPHA_KLUDGE_MCR' undeclared (first use in this function)
8250.c:1061: (Each undeclared identifier is reported only once
8250.c:1061: for each function it appears in.)

Adam J. Richter     __     ______________   575 Oroville Road
adam@yggdrasil.com     \ /                  Milpitas, California 95035
+1 408 309-6081         | g g d r a s i l   United States of America
                         "Free Software For The Rest Of Us."
