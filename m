From: vcgandhi1@aol.com
Subject: Re: Change to serial_core.c .... causing my serial driver problem Help
 Request
Date: Wed, 30 Apr 2008 03:43:19 -0400
Message-ID: <8CA78ACFDC41B4E-15AC-4AF9@webmail-nc04.sysops.aol.com>
References: <8CA6D5E4DEA920C-1128-2973@webmail-nb07.sysops.aol.com> <Pine.LNX.4.64.0804160046460.6851@axis700.grange> <8CA6D67D9E313CC-1128-35BB@webmail-nb07.sysops.aol.com> <8CA6D6D112DB4D4-1128-38B0@webmail-nb07.sysops.aol.com> <Pine.LNX.4.64.0804170103040.7335@axis700.grange> <8CA6E48B50204C0-15A8-47D0@webmail-nb06.sysops.aol.com> <Pine.LNX.4.64.0804171657320.6716@axis700.grange> <8CA6EC102F70775-15A8-8B4A@webmail-nb06.sysops.aol.com> <Pine.LNX.4.64.0804171915180.6716@axis700.grange> <8CA6EF5BC26E069-12A0-1888@webmail-nc13.sysops.aol.com> <Pine.LNX.4.64.0804181700300.5725@axis700.grange> <8CA6FF4B03B281A-E10-2E1C@webmail-nf05.sim.aol.com> <Pine.LNX.4.64.0804231108170.5160@axis700.grange> <8CA73B83C791846-148-41B9@webmail-nb17.sysops.aol.com> <Pine.LNX.4.64.0804241557340.5283@axis700.gra
 nge>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from imo-d03.mx.aol.com ([205.188.157.35]:45007 "EHLO
	imo-d03.mx.aol.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756155AbYD3Hn0 (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 30 Apr 2008 03:43:26 -0400
In-Reply-To: <Pine.LNX.4.64.0804241557340.5283@axis700.grange>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: g.liakhovetski@gmx.de
Cc: linux-serial@vger.kernel.org

FYI,

I will get the patch tested tomorrow.

Vipul


-----Original Message-----
From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
To: vcgandhi1@aol.com
Cc: linux-serial@vger.kernel.org
Sent: Thu, 24 Apr 2008 7:02 am
Subject: Re: Change to serial_core.c .... causing my serial driver 
problem Help Request



On Wed, 23 Apr 2008, vcgandhi1@aol.com wrote:

> Yes that fixes the problem. Sorry for taking some time to test it, 
but been
> busy buying a house. The process is making me exhausted.
>
> Please do try to get the patch into the mainline, and thank you for 
your time.

Thanks for testing, I presume, you tested the generic patch, modifying
drivers/serial/serial_core.c, not setting major and minor numbers in 
your
driver. However, on a second thought, I think, you probably were right,
suggesting to use major and minor numbers from the tty device in
serial_match_port. So, if you just could confirm that the patch below 
also
works for you, I'll submit it. Sorry for asking you again, I just 
cannot
easily test it myself ATM. And if it does work, please add your
"Tested-by:" to it.

Thanks
Guennadi
---
Guennadi Liakhovetski

diff --git a/drivers/serial/serial_core.c b/drivers/serial/serial_core.c
index 0f5a179..593ae85 100644
--- a/drivers/serial/serial_core.c
+++ b/drivers/serial/serial_core.c
@@ -1949,7 +1949,9 @@ struct uart_match {
 static int serial_match_port(struct device *dev, void *data)
 {
    struct uart_match *match = data;
-   dev_t devt = MKDEV(match->driver->major, match->driver->minor) +
match->port->line;
+   struct tty_driver *tty_drv = match->driver->tty_driver;
+   dev_t devt = MKDEV(tty_drv->major, tty_drv->minor_start) +
+       match->port->line;

    return dev->devt == devt; /* Actually, only one tty per port */
 }

