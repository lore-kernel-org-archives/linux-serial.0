From: Alexander Shiyan <shc_work@mail.ru>
Subject: [PATCH 12/12] serial: clps711x: Cleanup driver
Date: Sun, 14 Oct 2012 11:05:34 +0400
Message-ID: <1350198334-18737-12-git-send-email-shc_work@mail.ru>
References: <1350198334-18737-1-git-send-email-shc_work@mail.ru>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from smtp17.mail.ru ([94.100.176.154]:47940 "EHLO smtp17.mail.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751606Ab2JNHGn (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Sun, 14 Oct 2012 03:06:43 -0400
In-Reply-To: <1350198334-18737-1-git-send-email-shc_work@mail.ru>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: Alan Cox <alan@linux.intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Arnd Bergmann <arnd@arndb.de>, Alexander Shiyan <shc_work@mail.ru>

This patch performs cleanup on clps711x serial driver. This include:
- Change functions naming style.
- Removed unused includes.
- Removed unneeded comments.

Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
---
 drivers/tty/serial/clps711x.c |  105 ++++++++++++++++++-----------------------
 1 files changed, 46 insertions(+), 59 deletions(-)

diff --git a/drivers/tty/serial/clps711x.c b/drivers/tty/serial/clps711x.c
index 90efe05..a0a6db5 100644
--- a/drivers/tty/serial/clps711x.c
+++ b/drivers/tty/serial/clps711x.c
@@ -10,15 +10,6 @@
  * it under the terms of the GNU General Public License as published by
  * the Free Software Foundation; either version 2 of the License, or
  * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
  */
 
 #if defined(CONFIG_SERIAL_CLPS711X_CONSOLE) && defined(CONFIG_MAGIC_SYSRQ)
@@ -26,22 +17,18 @@
 #endif
 
 #include <linux/module.h>
-#include <linux/ioport.h>
-#include <linux/init.h>
-#include <linux/console.h>
-#include <linux/sysrq.h>
-#include <linux/spinlock.h>
 #include <linux/device.h>
-#include <linux/tty.h>
-#include <linux/tty_flip.h>
+#include <linux/console.h>
 #include <linux/serial_core.h>
 #include <linux/serial.h>
 #include <linux/io.h>
 #include <linux/clk.h>
+#include <linux/tty.h>
+#include <linux/tty_flip.h>
+#include <linux/ioport.h>
 #include <linux/platform_device.h>
 
 #include <mach/hardware.h>
-#include <asm/irq.h>
 
 #define UART_CLPS711X_NAME	"uart-clps711x"
 #define UART_CLPS711X_NR	2
@@ -65,7 +52,7 @@ struct clps711x_port {
 #endif
 };
 
-static void clps711xuart_stop_tx(struct uart_port *port)
+static void uart_clps711x_stop_tx(struct uart_port *port)
 {
 	struct clps711x_port *s = dev_get_drvdata(port->dev);
 
@@ -75,7 +62,7 @@ static void clps711xuart_stop_tx(struct uart_port *port)
 	}
 }
 
-static void clps711xuart_start_tx(struct uart_port *port)
+static void uart_clps711x_start_tx(struct uart_port *port)
 {
 	struct clps711x_port *s = dev_get_drvdata(port->dev);
 
@@ -85,13 +72,14 @@ static void clps711xuart_start_tx(struct uart_port *port)
 	}
 }
 
-static void clps711xuart_stop_rx(struct uart_port *port)
+static void uart_clps711x_stop_rx(struct uart_port *port)
 {
 	disable_irq(RX_IRQ(port));
 }
 
-static void clps711xuart_enable_ms(struct uart_port *port)
+static void uart_clps711x_enable_ms(struct uart_port *port)
 {
+	/* Do nothing */
 }
 
 static irqreturn_t uart_clps711x_int_rx(int irq, void *dev_id)
@@ -156,7 +144,7 @@ static irqreturn_t uart_clps711x_int_tx(int irq, void *dev_id)
 	struct circ_buf *xmit = &port->state->xmit;
 
 	if (port->x_char) {
-		clps_writel(port->x_char, UARTDR(port));
+		clps_writew(port->x_char, UARTDR(port));
 		port->icount.tx++;
 		port->x_char = 0;
 		return IRQ_HANDLED;
@@ -182,13 +170,12 @@ static irqreturn_t uart_clps711x_int_tx(int irq, void *dev_id)
 	return IRQ_HANDLED;
 }
 
-static unsigned int clps711xuart_tx_empty(struct uart_port *port)
+static unsigned int uart_clps711x_tx_empty(struct uart_port *port)
 {
-	unsigned int status = clps_readl(SYSFLG(port));
-	return status & SYSFLG_UBUSY ? 0 : TIOCSER_TEMT;
+	return (clps_readl(SYSFLG(port) & SYSFLG_UBUSY)) ? 0 : TIOCSER_TEMT;
 }
 
-static unsigned int clps711xuart_get_mctrl(struct uart_port *port)
+static unsigned int uart_clps711x_get_mctrl(struct uart_port *port)
 {
 	unsigned int status, result = 0;
 
@@ -206,12 +193,12 @@ static unsigned int clps711xuart_get_mctrl(struct uart_port *port)
 	return result;
 }
 
-static void
-clps711xuart_set_mctrl_null(struct uart_port *port, unsigned int mctrl)
+static void uart_clps711x_set_mctrl(struct uart_port *port, unsigned int mctrl)
 {
+	/* Do nothing */
 }
 
-static void clps711xuart_break_ctl(struct uart_port *port, int break_state)
+static void uart_clps711x_break_ctl(struct uart_port *port, int break_state)
 {
 	unsigned long flags;
 	unsigned int ubrlcr;
@@ -228,7 +215,7 @@ static void clps711xuart_break_ctl(struct uart_port *port, int break_state)
 	spin_unlock_irqrestore(&port->lock, flags);
 }
 
-static int clps711xuart_startup(struct uart_port *port)
+static int uart_clps711x_startup(struct uart_port *port)
 {
 	struct clps711x_port *s = dev_get_drvdata(port->dev);
 	int ret;
@@ -256,7 +243,7 @@ static int clps711xuart_startup(struct uart_port *port)
 	return 0;
 }
 
-static void clps711xuart_shutdown(struct uart_port *port)
+static void uart_clps711x_shutdown(struct uart_port *port)
 {
 	/* Free the interrupts */
 	devm_free_irq(port->dev, TX_IRQ(port), port);
@@ -266,9 +253,9 @@ static void clps711xuart_shutdown(struct uart_port *port)
 	clps_writel(clps_readl(SYSCON(port)) & ~SYSCON_UARTEN, SYSCON(port));
 }
 
-static void
-clps711xuart_set_termios(struct uart_port *port, struct ktermios *termios,
-			 struct ktermios *old)
+static void uart_clps711x_set_termios(struct uart_port *port,
+				      struct ktermios *termios,
+				      struct ktermios *old)
 {
 	unsigned int ubrlcr, baud, quot;
 	unsigned long flags;
@@ -292,7 +279,8 @@ clps711xuart_set_termios(struct uart_port *port, struct ktermios *termios,
 	case CS7:
 		ubrlcr = UBRLCR_WRDLEN7;
 		break;
-	default: // CS8
+	case CS8:
+	default:
 		ubrlcr = UBRLCR_WRDLEN8;
 		break;
 	}
@@ -329,45 +317,44 @@ clps711xuart_set_termios(struct uart_port *port, struct ktermios *termios,
 	spin_unlock_irqrestore(&port->lock, flags);
 }
 
-static const char *clps711xuart_type(struct uart_port *port)
+static const char *uart_clps711x_type(struct uart_port *port)
 {
-	return port->type == PORT_CLPS711X ? "CLPS711x" : NULL;
+	return (port->type == PORT_CLPS711X) ? "CLPS711X" : NULL;
 }
 
-/*
- * Configure/autoconfigure the port.
- */
-static void clps711xuart_config_port(struct uart_port *port, int flags)
+static void uart_clps711x_config_port(struct uart_port *port, int flags)
 {
 	if (flags & UART_CONFIG_TYPE)
 		port->type = PORT_CLPS711X;
 }
 
-static void clps711xuart_release_port(struct uart_port *port)
+static void uart_clps711x_release_port(struct uart_port *port)
 {
+	/* Do nothing */
 }
 
-static int clps711xuart_request_port(struct uart_port *port)
+static int uart_clps711x_request_port(struct uart_port *port)
 {
+	/* Do nothing */
 	return 0;
 }
 
-static struct uart_ops uart_clps711x_ops = {
-	.tx_empty	= clps711xuart_tx_empty,
-	.set_mctrl	= clps711xuart_set_mctrl_null,
-	.get_mctrl	= clps711xuart_get_mctrl,
-	.stop_tx	= clps711xuart_stop_tx,
-	.start_tx	= clps711xuart_start_tx,
-	.stop_rx	= clps711xuart_stop_rx,
-	.enable_ms	= clps711xuart_enable_ms,
-	.break_ctl	= clps711xuart_break_ctl,
-	.startup	= clps711xuart_startup,
-	.shutdown	= clps711xuart_shutdown,
-	.set_termios	= clps711xuart_set_termios,
-	.type		= clps711xuart_type,
-	.config_port	= clps711xuart_config_port,
-	.release_port	= clps711xuart_release_port,
-	.request_port	= clps711xuart_request_port,
+static const struct uart_ops uart_clps711x_ops = {
+	.tx_empty	= uart_clps711x_tx_empty,
+	.set_mctrl	= uart_clps711x_set_mctrl,
+	.get_mctrl	= uart_clps711x_get_mctrl,
+	.stop_tx	= uart_clps711x_stop_tx,
+	.start_tx	= uart_clps711x_start_tx,
+	.stop_rx	= uart_clps711x_stop_rx,
+	.enable_ms	= uart_clps711x_enable_ms,
+	.break_ctl	= uart_clps711x_break_ctl,
+	.startup	= uart_clps711x_startup,
+	.shutdown	= uart_clps711x_shutdown,
+	.set_termios	= uart_clps711x_set_termios,
+	.type		= uart_clps711x_type,
+	.config_port	= uart_clps711x_config_port,
+	.release_port	= uart_clps711x_release_port,
+	.request_port	= uart_clps711x_request_port,
 };
 
 #ifdef CONFIG_SERIAL_CLPS711X_CONSOLE
-- 
1.7.8.6

