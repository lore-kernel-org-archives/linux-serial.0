From: schivers@csc.com (Stephen Chivers)
Subject: [PATCH] printk/of_serial: fix serial console cessation part way
 through boot.
Date: Sat, 10 May 2014 15:37:34 +1000
Message-ID: <20140510053734.AF4E9E0692@canberra.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail170.messagelabs.com ([216.82.253.227]:56466 "EHLO
	mail170.messagelabs.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750775AbaEJFjx (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Sat, 10 May 2014 01:39:53 -0400
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: geert@linux-m68k.org, jslaby@suse.cz, gregkh@linuxfoundation.org
Cc: linuxppc-dev@lists.ozlabs.org, benh@kernel.crashing.org, devicetree@vger.kernel.org, rob+dt@kernel.org, grant.likely@linaro.org, linux-kernel@vger.kernel.org, cproctor@csc.com, linux-serial@vger.kernel.org, schivers@csc.com

Commit 5f5c9ae56c38942623f69c3e6dc6ec78e4da2076
"serial_core: Unregister console in uart_remove_one_port()"
fixed a crash where a serial port was removed but
not deregistered as a console.

There is a side effect of that commit for platforms having serial consoles
and of_serial configured (CONFIG_SERIAL_OF_PLATFORM). The serial console
is disabled midway through the boot process.

This cessation of the serial console affects PowerPC computers
such as the MVME5100 and SAM440EP.

The sequence is:

	bootconsole [udbg0] enabled
	....
	serial8250/16550 driver initialises and registers its UARTS,
	one of these is the serial console.
	console [ttyS0] enabled
	....
	of_serial probes "platform" devices, registering them as it goes.
	One of these is the serial console.
	console [ttyS0] disabled.

The disabling of the serial console is due to:

	a.  unregister_console in printk not clearing the
	    CONS_ENABLED bit in the console flags,
	    even though it has announced that the console is disabled; and

	b.  of_platform_serial_probe in of_serial not setting the port type
	    before it registers with serial8250_register_8250_port.

This patch ensures that the serial console is re-enabled when of_serial
registers a serial port that corresponds to the designated console.

Signed-off-by: Stephen Chivers <schivers@csc.com>
Tested-by: Stephen Chivers <schivers@csc.com>

===
The above failure was identified in Linux-3.15-rc2.

Tested using MVME5100 and SAM440EP PowerPC computers with
kernels built from Linux-3.15-rc5 and tty-next.

The continued operation of the serial console is vital for computers
such as the MVME5100 as that Single Board Computer does not
have any grapical/display hardware.

---
 drivers/tty/serial/of_serial.c |    1 +
 kernel/printk/printk.c         |    1 +
 2 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/drivers/tty/serial/of_serial.c b/drivers/tty/serial/of_serial.c
index 9924660..27981e2 100644
--- a/drivers/tty/serial/of_serial.c
+++ b/drivers/tty/serial/of_serial.c
@@ -173,6 +173,7 @@ static int of_platform_serial_probe(struct platform_device *ofdev)
 	{
 		struct uart_8250_port port8250;
 		memset(&port8250, 0, sizeof(port8250));
+		port.type = port_type;
 		port8250.port = port;
 
 		if (port.fifosize)
diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 7228258..221229c 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -2413,6 +2413,7 @@ int unregister_console(struct console *console)
 	if (console_drivers != NULL && console->flags & CON_CONSDEV)
 		console_drivers->flags |= CON_CONSDEV;
 
+	console->flags &= ~CON_ENABLED;
 	console_unlock();
 	console_sysfs_notify();
 	return res;
