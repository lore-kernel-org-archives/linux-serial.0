From: Julien Masson <jmasson@baylibre.com>
Subject: [PATCH v2] tty: serial: meson_uart: Add support for kernel debugger
Date: Thu,  7 Feb 2019 18:11:29 +0100
Message-ID: <86k1ibv74r.fsf@baylibre.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Kevin Hilman <khilman@baylibre.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-amlogic@lists.infradead.org, linux-arm-kernel@lists.infradead.org, linux-serial@vger.kernel.org, Jiri Slaby <jslaby@suse.com>, Julien Masson <jmasson@baylibre.com>, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

The kgdb invokes the poll_put_char and poll_get_char when communicating
with the host. This patch implement the serial polling hooks for the
meson_uart to be used for KGDB debugging over serial line.

Signed-off-by: Julien Masson <jmasson@baylibre.com>
---

Changes since v1 [0]:
* Use readl_poll_timeout_atomic instead of looping with read + cpu_relax
  -> read every 5 usecs during 1 msec
* add some comments

[0]: https://lore.kernel.org/lkml/1549015162-17418-1-git-send-email-jmasson@baylibre.com

 drivers/tty/serial/meson_uart.c | 65 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 65 insertions(+)

diff --git a/drivers/tty/serial/meson_uart.c b/drivers/tty/serial/meson_uart.c
index 8a84259..bcff572 100644
--- a/drivers/tty/serial/meson_uart.c
+++ b/drivers/tty/serial/meson_uart.c
@@ -14,6 +14,7 @@
 #include <linux/delay.h>
 #include <linux/init.h>
 #include <linux/io.h>
+#include <linux/iopoll.h>
 #include <linux/module.h>
 #include <linux/kernel.h>
 #include <linux/of.h>
@@ -75,6 +76,8 @@
 #define AML_UART_PORT_NUM		6
 #define AML_UART_DEV_NAME		"ttyAML"
 
+#define AML_UART_POLL_USEC		5
+#define AML_UART_TIMEOUT_USEC		1000
 
 static struct uart_driver meson_uart_driver;
 
@@ -426,6 +429,64 @@ static void meson_uart_config_port(struct uart_port *port, int flags)
 	}
 }
 
+#ifdef CONFIG_CONSOLE_POLL
+/*
+ * Console polling routines for writing and reading from the uart while
+ * in an interrupt or debug context (i.e. kgdb).
+ */
+
+static int meson_uart_poll_get_char(struct uart_port *port)
+{
+	u32 c;
+	unsigned long flags;
+
+	spin_lock_irqsave(&port->lock, flags);
+
+	if (readl(port->membase + AML_UART_STATUS) & AML_UART_RX_EMPTY)
+		c = NO_POLL_CHAR;
+	else
+		c = readl(port->membase + AML_UART_RFIFO);
+
+	spin_unlock_irqrestore(&port->lock, flags);
+
+	return c;
+}
+
+static void meson_uart_poll_put_char(struct uart_port *port, unsigned char c)
+{
+	unsigned long flags;
+	u32 reg;
+	int ret;
+
+	spin_lock_irqsave(&port->lock, flags);
+
+	/* Wait until FIFO is empty or timeout */
+	ret = readl_poll_timeout_atomic(port->membase + AML_UART_STATUS, reg,
+					reg & AML_UART_TX_EMPTY,
+					AML_UART_POLL_USEC,
+					AML_UART_TIMEOUT_USEC);
+	if (ret == -ETIMEDOUT) {
+		dev_err(port->dev, "Timeout waiting for UART TX EMPTY\n");
+		goto out;
+	}
+
+	/* Write the character */
+	writel(c, port->membase + AML_UART_WFIFO);
+
+	/* Wait until FIFO is empty or timeout */
+	ret = readl_poll_timeout_atomic(port->membase + AML_UART_STATUS, reg,
+					reg & AML_UART_TX_EMPTY,
+					AML_UART_POLL_USEC,
+					AML_UART_TIMEOUT_USEC);
+	if (ret == -ETIMEDOUT)
+		dev_err(port->dev, "Timeout waiting for UART TX EMPTY\n");
+
+out:
+	spin_unlock_irqrestore(&port->lock, flags);
+}
+
+#endif /* CONFIG_CONSOLE_POLL */
+
 static const struct uart_ops meson_uart_ops = {
 	.set_mctrl      = meson_uart_set_mctrl,
 	.get_mctrl      = meson_uart_get_mctrl,
@@ -441,6 +502,10 @@ static const struct uart_ops meson_uart_ops = {
 	.request_port	= meson_uart_request_port,
 	.release_port	= meson_uart_release_port,
 	.verify_port	= meson_uart_verify_port,
+#ifdef CONFIG_CONSOLE_POLL
+	.poll_get_char	= meson_uart_poll_get_char,
+	.poll_put_char	= meson_uart_poll_put_char,
+#endif
 };
 
 #ifdef CONFIG_SERIAL_MESON_CONSOLE
-- 
2.7.4
