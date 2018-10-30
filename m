From: Douglas Anderson <dianders@chromium.org>
Subject: [PATCH v2 5/5] serial: 8250: Process sysrq at port unlock time
Date: Tue, 30 Oct 2018 15:11:07 -0700
Message-ID: <20181030221107.79758-6-dianders@chromium.org>
References: <20181030221107.79758-1-dianders@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20181030221107.79758-1-dianders@chromium.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>
Cc: dan.carpenter@oracle.com, vigneshr@ti.com, linux-aspeed@lists.ozlabs.org, andrew@aj.id.au, linux-arm-msm@vger.kernel.org, Douglas Anderson <dianders@chromium.org>, tony@atomide.com, joel@jms.id.au, linux-serial@vger.kernel.org, andriy.shevchenko@linux.intel.com, linux-arm-kernel@lists.infradead.org, jk@ozlabs.org
List-Id: linux-serial@vger.kernel.org

Let's take advantage of the new ("serial: core: Allow processing sysrq
at port unlock time") to handle sysrqs more cleanly.

Signed-off-by: Douglas Anderson <dianders@chromium.org>
---
I don't have a great way to test all 8250 variants, but I've at least
tested rk3288 / rk3399 and they seem to work.  Hopefully I got the
aspeed_vuart / fsl / omap variants right (I only compile tested
those).

 drivers/tty/serial/8250/8250_aspeed_vuart.c | 6 +++++-
 drivers/tty/serial/8250/8250_fsl.c          | 6 +++++-
 drivers/tty/serial/8250/8250_omap.c         | 6 +++++-
 drivers/tty/serial/8250/8250_port.c         | 8 +++-----
 4 files changed, 18 insertions(+), 8 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_aspeed_vuart.c b/drivers/tty/serial/8250/8250_aspeed_vuart.c
index 435bec40dee6..0438d9a905ce 100644
--- a/drivers/tty/serial/8250/8250_aspeed_vuart.c
+++ b/drivers/tty/serial/8250/8250_aspeed_vuart.c
@@ -5,6 +5,10 @@
  *    Copyright (C) 2016 Jeremy Kerr <jk@ozlabs.org>, IBM Corp.
  *    Copyright (C) 2006 Arnd Bergmann <arnd@arndb.de>, IBM Corp.
  */
+#if defined(CONFIG_SERIAL_8250_CONSOLE) && defined(CONFIG_MAGIC_SYSRQ)
+#define SUPPORT_SYSRQ
+#endif
+
 #include <linux/device.h>
 #include <linux/module.h>
 #include <linux/of_address.h>
@@ -293,7 +297,7 @@ static int aspeed_vuart_handle_irq(struct uart_port *port)
 	if (lsr & UART_LSR_THRE)
 		serial8250_tx_chars(up);
 
-	spin_unlock_irqrestore(&port->lock, flags);
+	uart_unlock_and_check_sysrq(port, flags);
 
 	return 1;
 }
diff --git a/drivers/tty/serial/8250/8250_fsl.c b/drivers/tty/serial/8250/8250_fsl.c
index 6640a4c7ddd1..ff3dcaea5d93 100644
--- a/drivers/tty/serial/8250/8250_fsl.c
+++ b/drivers/tty/serial/8250/8250_fsl.c
@@ -1,4 +1,8 @@
 // SPDX-License-Identifier: GPL-2.0
+#if defined(CONFIG_SERIAL_8250_CONSOLE) && defined(CONFIG_MAGIC_SYSRQ)
+#define SUPPORT_SYSRQ
+#endif
+
 #include <linux/serial_reg.h>
 #include <linux/serial_8250.h>
 
@@ -54,7 +58,7 @@ int fsl8250_handle_irq(struct uart_port *port)
 		serial8250_tx_chars(up);
 
 	up->lsr_saved_flags = orig_lsr;
-	spin_unlock_irqrestore(&up->port.lock, flags);
+	uart_unlock_and_check_sysrq(&up->port, flags);
 	return 1;
 }
 EXPORT_SYMBOL_GPL(fsl8250_handle_irq);
diff --git a/drivers/tty/serial/8250/8250_omap.c b/drivers/tty/serial/8250/8250_omap.c
index a019286f8bb6..ad7ba7d0f28d 100644
--- a/drivers/tty/serial/8250/8250_omap.c
+++ b/drivers/tty/serial/8250/8250_omap.c
@@ -8,6 +8,10 @@
  *
  */
 
+#if defined(CONFIG_SERIAL_8250_CONSOLE) && defined(CONFIG_MAGIC_SYSRQ)
+#define SUPPORT_SYSRQ
+#endif
+
 #include <linux/device.h>
 #include <linux/io.h>
 #include <linux/module.h>
@@ -1085,7 +1089,7 @@ static int omap_8250_dma_handle_irq(struct uart_port *port)
 		}
 	}
 
-	spin_unlock_irqrestore(&port->lock, flags);
+	uart_unlock_and_check_sysrq(port, flags);
 	serial8250_rpm_put(up);
 	return 1;
 }
diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
index 3f779d25ec0c..d2f3310abe54 100644
--- a/drivers/tty/serial/8250/8250_port.c
+++ b/drivers/tty/serial/8250/8250_port.c
@@ -1736,7 +1736,7 @@ void serial8250_read_char(struct uart_8250_port *up, unsigned char lsr)
 		else if (lsr & UART_LSR_FE)
 			flag = TTY_FRAME;
 	}
-	if (uart_handle_sysrq_char(port, ch))
+	if (uart_prepare_sysrq_char(port, ch))
 		return;
 
 	uart_insert_char(port, lsr, UART_LSR_OE, ch, flag);
@@ -1878,7 +1878,7 @@ int serial8250_handle_irq(struct uart_port *port, unsigned int iir)
 	if ((!up->dma || up->dma->tx_err) && (status & UART_LSR_THRE))
 		serial8250_tx_chars(up);
 
-	spin_unlock_irqrestore(&port->lock, flags);
+	uart_unlock_and_check_sysrq(port, flags);
 	return 1;
 }
 EXPORT_SYMBOL_GPL(serial8250_handle_irq);
@@ -3239,9 +3239,7 @@ void serial8250_console_write(struct uart_8250_port *up, const char *s,
 
 	serial8250_rpm_get(up);
 
-	if (port->sysrq)
-		locked = 0;
-	else if (oops_in_progress)
+	if (oops_in_progress)
 		locked = spin_trylock_irqsave(&port->lock, flags);
 	else
 		spin_lock_irqsave(&port->lock, flags);
-- 
2.19.1.568.g152ad8e336-goog
