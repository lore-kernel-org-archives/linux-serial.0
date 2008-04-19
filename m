From: vcgandhi1@aol.com
Subject: Re: Change to serial_core.c .... causing my serial driver problem Help
 Request
Date: Sat, 19 Apr 2008 01:23:52 -0400
Message-ID: <8CA6FF4B03B281A-E10-2E1C@webmail-nf05.sim.aol.com>
References: <8CA6D5E4DEA920C-1128-2973@webmail-nb07.sysops.aol.com> <Pine.LNX.4.64.0804160046460.6851@axis700.grange> <8CA6D67D9E313CC-1128-35BB@webmail-nb07.sysops.aol.com> <8CA6D6D112DB4D4-1128-38B0@webmail-nb07.sysops.aol.com> <Pine.LNX.4.64.0804170103040.7335@axis700.grange> <8CA6E48B50204C0-15A8-47D0@webmail-nb06.sysops.aol.com> <Pine.LNX.4.64.0804171657320.6716@axis700.grange> <8CA6EC102F70775-15A8-8B4A@webmail-nb06.sysops.aol.com> <Pine.LNX.4.64.0804171915180.6716@axis700.grange> <8CA6EF5BC26E069-12A0-1888@webmail-nc13.sysops.aol.com> <Pine.LNX.4.64.0804181700300.5725@axis700.grange>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from imo-d21.mx.aol.com ([205.188.144.207]:63950 "EHLO
	imo-d21.mx.aol.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751066AbYDSFX7 (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Sat, 19 Apr 2008 01:23:59 -0400
In-Reply-To: <Pine.LNX.4.64.0804181700300.5725@axis700.grange>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: g.liakhovetski@gmx.de
Cc: linux-serial@vger.kernel.org

FYI,

I have not had a chance to test it today, Sorry. The patches should 
solve the problem, but I will confirm on the hardware this weekend.

Vipul



-----Original Message-----
From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
To: vcgandhi1@aol.com
Cc: linux-serial@vger.kernel.org
Sent: Fri, 18 Apr 2008 8:04 am
Subject: Re: Change to serial_core.c .... causing my serial driver 
problem Help Request



On Thu, 17 Apr 2008, vcgandhi1@aol.com wrote:

> My driver does the same as jsm_init_module. I would be very surprised 
if jsm
> actually worked with your change. You need to test it under suspend 
and resume
> condition.
>
> My driver does the same uart_register_driver/tty_register_driver, but 
it looks
> like tty_register_driver sets the major address for the tty 
structure, but
> that does not get set back in the uart_driver structure. So 
uart_driver
> structure is still at zero.

Indeed, you're right. One possible solution would be to pull the just
obtained numbers into struct uart_driver in the specific serial driver
like

diff --git a/drivers/serial/jsm/jsm_driver.c 
b/drivers/serial/jsm/jsm_driver.c
index 6767ee3..3afebab 100644
--- a/drivers/serial/jsm/jsm_driver.c
+++ b/drivers/serial/jsm/jsm_driver.c
@@ -225,6 +225,8 @@ static int __init jsm_init_module(void)

    rc = uart_register_driver(&jsm_uart_driver);
    if (!rc) {
+       jsm_uart_driver.major = jsm_uart_driver.tty_driver->major;
+       jsm_uart_driver.minor = jsm_uart_driver.tty_driver->minor_start;
        rc = pci_register_driver(&jsm_driver);
        if (rc)
            uart_unregister_driver(&jsm_uart_driver);

You could do the same in your driver and see if this fixes your 
problem.
However, maybe it is really better to fix it once for all drivers like

diff --git a/drivers/serial/serial_core.c b/drivers/serial/serial_core.c
index 0f5a179..11e96bc 100644
--- a/drivers/serial/serial_core.c
+++ b/drivers/serial/serial_core.c
@@ -2274,6 +2274,11 @@ int uart_register_driver(struct uart_driver *drv)
    if (retval < 0) {
        put_tty_driver(normal);
        kfree(drv->state);
+   } else if (!drv->major) {
+       /* Driver uses dynamic major and minor numbers,
+        * propagate the numbers, we just obtained, back */
+       drv->major = normal->major;
+       drv->minor = normal->minor_start;
    }
    return retval;
 }

Could you test this one too, please (without the previous one, of 
course)?

Thanks
Guennadi
---
Guennadi Liakhovetski

