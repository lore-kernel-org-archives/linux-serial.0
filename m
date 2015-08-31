From: Vitaly Kuznetsov <vkuznets@redhat.com>
Subject: [PATCH] serial: core: prevent softlockups on slow consoles
Date: Mon, 31 Aug 2015 16:34:16 +0200
Message-ID: <1441031656-17959-1-git-send-email-vkuznets@redhat.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, "K. Y. Srinivasan" <kys@microsoft.com>, Dexuan Cui <decui@microsoft.com>
List-Id: linux-serial@vger.kernel.org

Hyper-V serial port is very slow on multi-vCPU guest, this causes
soflockups on intensive console writes. Touch nmi watchdog after putting
every char on port to avoid the issue for all serial drivers, the overhead
should be small.

This is just a part of the fix: serial8250_console_write() disables irqs
for all its execution time (which on such slow consoles can be dozens of
seconds), it should be possible to observe devices being stuck on this
CPU. We need to find a better way, e.g. do output in batches enabling irqs
in between.

Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
---
 drivers/tty/serial/serial_core.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
index f368520..cc05785 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -33,7 +33,7 @@
 #include <linux/serial.h> /* for serial_state and serial_icounter_struct */
 #include <linux/serial_core.h>
 #include <linux/delay.h>
-#include <linux/mutex.h>
+#include <linux/nmi.h>
 
 #include <asm/irq.h>
 #include <asm/uaccess.h>
@@ -1792,6 +1792,7 @@ void uart_console_write(struct uart_port *port, const char *s,
 		if (*s == '\n')
 			putchar(port, '\r');
 		putchar(port, *s);
+		touch_nmi_watchdog();
 	}
 }
 EXPORT_SYMBOL_GPL(uart_console_write);
-- 
2.4.3
