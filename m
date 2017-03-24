From: Stefan Agner <stefan@agner.ch>
Subject: [PATCH] tty: serial: fsl_lpuart: lock port on console write
Date: Fri, 24 Mar 2017 11:33:46 -0700
Message-ID: <20170324183346.12178-1-stefan@agner.ch>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@linuxfoundation.org
Cc: jslaby@suse.com, bhuvanchandra.dv@toradex.com, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Stefan Agner <stefan@agner.ch>
List-Id: linux-serial@vger.kernel.org

The console write code is not entirely race free (e.g. the operations
to disabling the UART interrupts are not atomic) hence locking is
required. This has been become apparent with the PREEMPT RT patchset
applied: With the fully preemptible kernel configuration the system
often ended up in a freeze already at startup.

Disable interrupts and lock using read_lock_irqsave. Try to lock in
the sysrq/oops case, but don't bother if locking fails.

Signed-off-by: Stefan Agner <stefan@agner.ch>
---
 drivers/tty/serial/fsl_lpuart.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/drivers/tty/serial/fsl_lpuart.c b/drivers/tty/serial/fsl_lpuart.c
index f02934ffb329..15df1ba78095 100644
--- a/drivers/tty/serial/fsl_lpuart.c
+++ b/drivers/tty/serial/fsl_lpuart.c
@@ -1705,6 +1705,13 @@ lpuart_console_write(struct console *co, const char *s, unsigned int count)
 {
 	struct lpuart_port *sport = lpuart_ports[co->index];
 	unsigned char  old_cr2, cr2;
+	unsigned long flags;
+	int locked = 1;
+
+	if (sport->port.sysrq || oops_in_progress)
+		locked = spin_trylock_irqsave(&sport->port.lock, flags);
+	else
+		spin_lock_irqsave(&sport->port.lock, flags);
 
 	/* first save CR2 and then disable interrupts */
 	cr2 = old_cr2 = readb(sport->port.membase + UARTCR2);
@@ -1719,6 +1726,9 @@ lpuart_console_write(struct console *co, const char *s, unsigned int count)
 		barrier();
 
 	writeb(old_cr2, sport->port.membase + UARTCR2);
+
+	if (locked)
+		spin_unlock_irqrestore(&sport->port.lock, flags);
 }
 
 static void
@@ -1726,6 +1736,13 @@ lpuart32_console_write(struct console *co, const char *s, unsigned int count)
 {
 	struct lpuart_port *sport = lpuart_ports[co->index];
 	unsigned long  old_cr, cr;
+	unsigned long flags;
+	int locked = 1;
+
+	if (sport->port.sysrq || oops_in_progress)
+		locked = spin_trylock_irqsave(&sport->port.lock, flags);
+	else
+		spin_lock_irqsave(&sport->port.lock, flags);
 
 	/* first save CR2 and then disable interrupts */
 	cr = old_cr = lpuart32_read(sport->port.membase + UARTCTRL);
@@ -1740,6 +1757,9 @@ lpuart32_console_write(struct console *co, const char *s, unsigned int count)
 		barrier();
 
 	lpuart32_write(old_cr, sport->port.membase + UARTCTRL);
+
+	if (locked)
+		spin_unlock_irqrestore(&sport->port.lock, flags);
 }
 
 /*
-- 
2.12.0
