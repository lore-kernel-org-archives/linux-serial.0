From: Helge Deller <deller@gmx.de>
Subject: [PATCH] fix early_serial_setup() regression
Date: Tue, 13 Jan 2009 22:51:07 +0100
Message-ID: <496D0CCB.1020706__46557.7861214571$1231883635$gmane$org@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail.gmx.net ([213.165.64.20]:39147 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753706AbZAMVwM (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Tue, 13 Jan 2009 16:52:12 -0500
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: David Daney <ddaney@caviumnetworks.com>, Tomaso Paoletti <tpaoletti@caviumnetworks.com>, Andrew Morton <akpm@linux-foundation.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>, Linus
Cc: linux-parisc@vger.kernel.org

commit b430428a188e8a434325e251d0704af4b88b4711,
	"8250: Don't clobber spinlocks."
introduced a regression on the parisc architecture, which
broke the handover to the serial port at boottime.

early_serial_setup() was changed to only copy a subset of the
uart_port fields, and sadly the "type" and "line" fields
were forgotten and thus the serial port was not initialized
and could not be used for a handover.
This patch fixes this by copying the missing fields.

As this change to early_serial_setup() doesn't need an 
initialized spinlock in the uart_port struct any longer, we
can drop the spinlock initialization in the superio driver.

CC: David Daney <ddaney@caviumnetworks.com>
CC: Tomaso Paoletti <tpaoletti@caviumnetworks.com>
CC: Andrew Morton <akpm@linux-foundation.org>
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Linus Torvalds <torvalds@linux-foundation.org>
CC: Kyle McMartin <kyle@mcmartin.ca>
CC: linux-parisc@vger.kernel.org

Signed-off-by: Helge Deller <deller@gmx.de>


diff --git a/drivers/serial/8250.c b/drivers/serial/8250.c
index 1889a63..0d934bf 100644
--- a/drivers/serial/8250.c
+++ b/drivers/serial/8250.c
@@ -2839,6 +2839,8 @@ int __init early_serial_setup(struct uart_port *port)
 	p->flags        = port->flags;
 	p->mapbase      = port->mapbase;
 	p->private_data = port->private_data;
+	p->type		= port->type;
+	p->line		= port->line;
 
 	set_io_from_upio(p);
 	if (port->serial_in)
diff --git a/drivers/parisc/superio.c b/drivers/parisc/superio.c
index 1e93c83..4fa3bb2 100644
--- a/drivers/parisc/superio.c
+++ b/drivers/parisc/superio.c
@@ -405,7 +405,6 @@ static void __init superio_serial_init(void)
 	serial_port.type	= PORT_16550A;
 	serial_port.uartclk	= 115200*16;
 	serial_port.fifosize	= 16;
-	spin_lock_init(&serial_port.lock);
 
 	/* serial port #1 */
 	serial_port.iobase	= sio_dev.sp1_base;

