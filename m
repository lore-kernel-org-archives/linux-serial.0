From: Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 3/4] TTY: serial/m32r_sio, remove debug macros
Date: Tue, 12 Jan 2016 10:59:08 +0100
Message-ID: <1452592749-25150-3-git-send-email-jslaby@suse.cz>
References: <1452592749-25150-1-git-send-email-jslaby@suse.cz>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1452592749-25150-1-git-send-email-jslaby@suse.cz>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@linuxfoundation.org
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Jiri Slaby <jslaby@suse.cz>
List-Id: linux-serial@vger.kernel.org

DEBUG_AUTOCONF is unused.

Switch DEBUG_INTR to pr_debug. This is only enabled with DEBUG or
dynamic debug when explicitly asked for.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---
 drivers/tty/serial/m32r_sio.c | 25 +++++--------------------
 1 file changed, 5 insertions(+), 20 deletions(-)

diff --git a/drivers/tty/serial/m32r_sio.c b/drivers/tty/serial/m32r_sio.c
index 835b5697a455..6b1303505667 100644
--- a/drivers/tty/serial/m32r_sio.c
+++ b/drivers/tty/serial/m32r_sio.c
@@ -49,21 +49,6 @@
 #include <linux/serial_core.h>
 #include "m32r_sio_reg.h"
 
-/*
- * Debugging.
- */
-#if 0
-#define DEBUG_AUTOCONF(fmt...)	printk(fmt)
-#else
-#define DEBUG_AUTOCONF(fmt...)	do { } while (0)
-#endif
-
-#if 0
-#define DEBUG_INTR(fmt...)	printk(fmt)
-#else
-#define DEBUG_INTR(fmt...)	do { } while (0)
-#endif
-
 #define PASS_LIMIT	256
 
 /* Standard COM flags */
@@ -334,7 +319,7 @@ static void receive_chars(struct uart_sio_port *up, int *status)
 			}
 
 			if (*status & UART_LSR_BI) {
-				DEBUG_INTR("handling break....");
+				pr_debug("handling break....\n");
 				flag = TTY_BREAK;
 			} else if (*status & UART_LSR_PE)
 				flag = TTY_PARITY;
@@ -395,7 +380,7 @@ static void transmit_chars(struct uart_sio_port *up)
 	if (uart_circ_chars_pending(xmit) < WAKEUP_CHARS)
 		uart_write_wakeup(&up->port);
 
-	DEBUG_INTR("THRE...");
+	pr_debug("THRE...\n");
 
 	if (uart_circ_empty(xmit))
 		m32r_sio_stop_tx(&up->port);
@@ -407,7 +392,7 @@ static void transmit_chars(struct uart_sio_port *up)
 static inline void m32r_sio_handle_port(struct uart_sio_port *up,
 	unsigned int status)
 {
-	DEBUG_INTR("status = %x...", status);
+	pr_debug("status = %x...\n", status);
 
 	if (status & 0x04)
 		receive_chars(up, &status);
@@ -435,7 +420,7 @@ static irqreturn_t m32r_sio_interrupt(int irq, void *dev_id)
 	struct list_head *l, *end = NULL;
 	int pass_counter = 0;
 
-	DEBUG_INTR("m32r_sio_interrupt(%d)...", irq);
+	pr_debug("m32r_sio_interrupt(%d)...\n", irq);
 
 #ifdef CONFIG_SERIAL_M32R_PLDSIO
 //	if (irq == PLD_IRQ_SIO0_SND)
@@ -475,7 +460,7 @@ static irqreturn_t m32r_sio_interrupt(int irq, void *dev_id)
 
 	spin_unlock(&i->lock);
 
-	DEBUG_INTR("end.\n");
+	pr_debug("end.\n");
 
 	return IRQ_HANDLED;
 }
-- 
2.7.0
