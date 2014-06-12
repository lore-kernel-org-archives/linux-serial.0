From: Vineet Gupta <Vineet.Gupta1-HKixBCOQz3hWk0Htik3J/w@public.gmane.org>
Subject: [PATCH 4/9] serial/arc: Use generic earlycon infrastructure
Date: Thu, 12 Jun 2014 16:01:34 +0530
Message-ID: <1402569099-9900-5-git-send-email-vgupta@synopsys.com>
References: <1402569099-9900-1-git-send-email-vgupta@synopsys.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1402569099-9900-1-git-send-email-vgupta-HKixBCOQz3hWk0Htik3J/w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Jiri Slaby <jslaby-AlSwsSmVLrQ@public.gmane.org>, Paul Bolle <pebolle-IWqWACnzNjzz+pZb47iToQ@public.gmane.org>
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Francois.Bedard-HKixBCOQz3hWk0Htik3J/w@public.gmane.org, Vineet Gupta <Vineet.Gupta1-HKixBCOQz3hWk0Htik3J/w@public.gmane.org>
List-Id: linux-serial@vger.kernel.org

With this change both earlyprintk and earlycon coexist
We switch over to latter in next patch

Signed-off-by: Vineet Gupta <vgupta-HKixBCOQz3hWk0Htik3J/w@public.gmane.org>
---
 drivers/tty/serial/Kconfig    |  1 +
 drivers/tty/serial/arc_uart.c | 30 ++++++++++++++++++++++++++++++
 2 files changed, 31 insertions(+)

diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
index fb57159bad3a..2311443be7dc 100644
--- a/drivers/tty/serial/Kconfig
+++ b/drivers/tty/serial/Kconfig
@@ -1473,6 +1473,7 @@ config SERIAL_ARC_CONSOLE
 	bool "Console on ARC UART"
 	depends on SERIAL_ARC=y
 	select SERIAL_CORE_CONSOLE
+	select SERIAL_EARLYCON
 	help
 	  Enable system Console on ARC UART
 
diff --git a/drivers/tty/serial/arc_uart.c b/drivers/tty/serial/arc_uart.c
index a6da10f84293..0c8ba5bb97c7 100644
--- a/drivers/tty/serial/arc_uart.c
+++ b/drivers/tty/serial/arc_uart.c
@@ -646,6 +646,36 @@ static int __init arc_serial_probe_earlyprintk(struct platform_device *pdev)
 	register_console(&arc_early_serial_console);
 	return 0;
 }
+
+static __init void arc_early_serial_write(struct console *con, const char *s,
+					  unsigned int n)
+{
+	struct earlycon_device *dev = con->data;
+
+	uart_console_write(&dev->port, s, n, arc_serial_poll_putchar);
+}
+
+static int __init arc_early_console_setup(struct earlycon_device *dev,
+					  const char *opt)
+{
+	struct uart_port *port = &dev->port;
+	unsigned int l, h, hw_val;
+
+	if (!dev->port.membase)
+		return -ENODEV;
+
+	hw_val = port->uartclk / (dev->baud * 4) - 1;
+	l = hw_val & 0xFF;
+	h = (hw_val >> 8) & 0xFF;
+
+	UART_SET_BAUDL(port, l);
+	UART_SET_BAUDH(port, h);
+
+	dev->con->write = arc_early_serial_write;
+	return 0;
+}
+EARLYCON_DECLARE(arc_uart, arc_early_console_setup);
+
 #endif	/* CONFIG_SERIAL_ARC_CONSOLE */
 
 static int arc_serial_probe(struct platform_device *pdev)
-- 
1.8.3.2

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
