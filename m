From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH] serial: digicolor: fix sysrq handling
Date: Tue, 13 Jan 2015 15:37:11 +0100
Message-ID: <1730002.vWGOEymGdz@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@linuxfoundation.org
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, Baruch Siach <baruch@tkos.co.il>
List-Id: linux-serial@vger.kernel.org

Trying to build the digicolor-usart driver when sysrq is disabled
results in a compile error:

drivers/tty/serial/digicolor-usart.c: In function 'digicolor_uart_console_write':
drivers/tty/serial/digicolor-usart.c:407:33: error: 'struct uart_port' has no member named 'sysrq'

Like a lot of other drivers, this one requires an #ifdef to avoid
accessing the sysrq field here. While looking into this, I noticed
that the case where sysrq support is enabled is also broken, because
the driver fails to set the SUPPORT_SYSRQ macro.

This patch hopefully fixes both, but I do not hardware to test if sysrq
is actually working now.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>

diff --git a/drivers/tty/serial/digicolor-usart.c b/drivers/tty/serial/digicolor-usart.c
index 09ce0b3764e2..1e4bdd895804 100644
--- a/drivers/tty/serial/digicolor-usart.c
+++ b/drivers/tty/serial/digicolor-usart.c
@@ -23,6 +23,10 @@
 #include <linux/platform_device.h>
 #include <linux/workqueue.h>
 
+#if defined(CONFIG_SERIAL_CONEXANT_DIGICOLOR_CONSOLE) && defined(CONFIG_MAGIC_SYSRQ)
+#define SUPPORT_SYSRQ
+#endif
+
 #define UA_ENABLE			0x00
 #define UA_ENABLE_ENABLE		BIT(0)
 
@@ -403,10 +407,11 @@ static void digicolor_uart_console_write(struct console *co, const char *c,
 	u8 status;
 	unsigned long flags;
 	int locked = 1;
-
+#ifdef SUPPORT_SYSRQ
 	if (port->sysrq || oops_in_progress)
 		locked = spin_trylock_irqsave(&port->lock, flags);
 	else
+#endif
 		spin_lock_irqsave(&port->lock, flags);
 
 	uart_console_write(port, c, n, digicolor_uart_console_putchar);
