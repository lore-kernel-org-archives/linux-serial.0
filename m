From: Stefan Althoefer <as@janz.de>
Subject: ioctl(tiocsserial) for devices which need ioremapping
Date: Tue, 23 Jan 2007 08:26:35 +0100
Message-ID: <45B5B8AB.9020200@janz.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mr01.hansenet.de ([213.191.74.10]:36666 "EHLO mr01.hansenet.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932852AbXAWHYf convert rfc822-to-8bit (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 23 Jan 2007 02:24:35 -0500
Received: from mail1.janzag.de (213.39.240.49) by mr01.hansenet.de (7.2.074)
        id 45AE38A1000510DC for linux-serial@vger.kernel.org; Tue, 23 Jan 2007 08:24:34 +0100
Received: from localhost (localhost [127.0.0.1])
	by mail1.janzag.de (Postfix) with ESMTP id 89CE910667
	for <linux-serial@vger.kernel.org>; Tue, 23 Jan 2007 08:24:34 +0100 (CET)
Received: from mail1.janzag.de ([127.0.0.1])
 by localhost (mail1 [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 20517-06-2 for <linux-serial@vger.kernel.org>;
 Tue, 23 Jan 2007 08:24:30 +0100 (CET)
Received: from [192.168.0.63] (pc-as007.janzag.de [192.168.0.63])
	by mail1.janzag.de (Postfix) with ESMTP id 8DD2C1AEA7
	for <linux-serial@vger.kernel.org>; Tue, 23 Jan 2007 08:24:21 +0100 (CET)
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org

hi,

I'm using the linux serial 8250 driver for an IXP425 based ARM
device. The two on-chip serial ports work with no problem.

However, depending on the configuration of my system I have
some more 8250 based serial ports, which I want to register to
the driver after the system has booted (after I have detected
how many ports are available).
=46or this I have written a tool to configure the serial port base
address and interrupt with the TIOCSSERIAL ioctl.

Unfortunately, there is a problem with this: The new serial ports
require that the memory mapped address must be remapped. Although
there is a member in the serial_struct to specify this, the driver
does not pay attention to the UPF_IOREMAP bit in serial_struct.flags.

The same appears to the UPF_SHARE_IRQ flag.

Is there any way to handle this (to attach my serial port and have
the address relocation take place)?

To solve this problem, I have created the following patch. It checks
for the UPF_IOREMAP and UPF_SHARE_IRQ flags when it detects that
either port or interrupt are changed. Is it possible to integrate
this into the kernel?

-----%<------------
diff -r -N -u linux-2.6.18.1/drivers/serial/serial_core.c
linux-2.6.18.1-xscale-fordiff/drivers/serial/serial_core.c
--- linux-2.6.18.1/drivers/serial/serial_core.c 2006-10-14 05:34:03.000=
000000 +0200
+++ linux-2.6.18.1-xscale-fordiff/drivers/serial/serial_core.c  2006-11=
-02 11:52:46.000000000 +0100
@@ -706,6 +706,22 @@
                 goto check_and_exit;
         }

+       /* FIXME: as@janz.de
+        *
+        * If we change port and IOREMAP is requested, then we push it =
in.
+        * If we change irq  and SHARE_IRQ is requested, then we push i=
t in.
+        */
+       if( change_port ){
+           if( (new_serial.flags & UPF_IOREMAP) && !(port->flags & UPF=
_IOREMAP) ){
+               port->flags |=3D UPF_IOREMAP;
+           }
+       }
+       if( change_irq ){
+           if( (new_serial.flags & UPF_SHARE_IRQ) && !(port->flags & U=
PF_SHARE_IRQ) ){
+               port->flags |=3D UPF_SHARE_IRQ;
+           }
+       }
+
         /*
          * Ask the low level driver to verify the settings.
          */
---------------------

--=20
----------------------
Stefan Alth=F6fer (stefan.althoefer@janz.de)
Janz Automationssysteme AG
   - Automation Intelligence -
Member of the Janz company group
Im Doerener Feld 8
33100 Paderborn - Germany


-
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
