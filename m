From: Julien Masson <jmasson@baylibre.com>
Subject: [PATCH] tty: serial: meson_uart: Add support for kernel debugger
Date: Fri,  1 Feb 2019 10:59:22 +0100
Message-ID: <1549015162-17418-1-git-send-email-jmasson@baylibre.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Kevin Hilman <khilman@baylibre.com>
Cc: Julien Masson <jmasson@baylibre.com>, Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

The kgdb invokes the poll_put_char and poll_get_char when communicating
with the host. This patch implement the serial polling hooks for the
meson_uart to be used for KGDB debugging over serial line.

Signed-off-by: Julien Masson <jmasson@baylibre.com>
---
It has been tested on "Le Potato" board:
https://libre.computer/products/boards/aml-s905x-cc/

Kernel command line arguments:
kgdboc=ttyAML0,115200 kgdbretry=4 nokaslr kgdbcon

Kernel modules:
CONFIG_DEBUG_INFO=y
CONFIG_DEBUG_KERNEL=y
CONFIG_FRAME_POINTER=y
CONFIG_KGDB=y
CONFIG_KGDB_SERIAL_CONSOLE=y

Warning: for single step instruction I had to apply this patch:
https://lore.kernel.org/patchwork/patch/562423/

 drivers/tty/serial/meson_uart.c | 46 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 46 insertions(+)

diff --git a/drivers/tty/serial/meson_uart.c b/drivers/tty/serial/meson_uart.c
index 8a84259..49b20da 100644
--- a/drivers/tty/serial/meson_uart.c
+++ b/drivers/tty/serial/meson_uart.c
@@ -426,6 +426,48 @@ static void meson_uart_config_port(struct uart_port *port, int flags)
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
+
+	spin_lock_irqsave(&port->lock, flags);
+
+	while (!(readl(port->membase + AML_UART_STATUS) & AML_UART_TX_EMPTY))
+		cpu_relax();
+
+	writel(c, port->membase + AML_UART_WFIFO);
+
+	while (!(readl(port->membase + AML_UART_STATUS) & AML_UART_TX_EMPTY))
+		cpu_relax();
+
+	spin_unlock_irqrestore(&port->lock, flags);
+}
+
+#endif /* CONFIG_CONSOLE_POLL */
+
 static const struct uart_ops meson_uart_ops = {
 	.set_mctrl      = meson_uart_set_mctrl,
 	.get_mctrl      = meson_uart_get_mctrl,
@@ -441,6 +483,10 @@ static const struct uart_ops meson_uart_ops = {
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
