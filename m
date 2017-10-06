From: Miquel Raynal <miquel.raynal-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: [PATCH 03/16] serial: mvebu-uart: use driver name when requesting an interrupt
Date: Fri,  6 Oct 2017 12:13:31 +0200
Message-ID: <20171006101344.15590-4-miquel.raynal@free-electrons.com>
References: <20171006101344.15590-1-miquel.raynal@free-electrons.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20171006101344.15590-1-miquel.raynal-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Jason Cooper <jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org>, Andrew Lunn <andrew-g2DYL2Zd6BY@public.gmane.org>, Gregory Clement <gregory.clement-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Sebastian Hesselbarth <sebastian.hesselbarth-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Jiri Slaby <jslaby-IBi9RG/b67k@public.gmane.org>, Catalin Marinas <catalin.marinas-5wv7dgnIgG8@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Cc: linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-gpio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Thomas Petazzoni <thomas.petazzoni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Antoine Tenart <antoine.tenart-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Nadav Haklai <nadavh-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Wilson Ding <dingwei-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Yehuda Yitschak <yehuday-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Miquel Raynal <miquel.raynal-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
List-Id: linux-serial@vger.kernel.org

From: Yehuda Yitschak <yehuday-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>

Use the driver name when requesting an interrupt for consistency.

Avoids possible confusion with DW8250 driver interrupt names in
/proc/interrupts.

Signed-off-by: Yehuda Yitschak <yehuday-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>
Signed-off-by: Miquel Raynal <miquel.raynal-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
---
 drivers/tty/serial/mvebu-uart.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/serial/mvebu-uart.c b/drivers/tty/serial/mvebu-uart.c
index 45b57c294d13..7e0a3e9fee15 100644
--- a/drivers/tty/serial/mvebu-uart.c
+++ b/drivers/tty/serial/mvebu-uart.c
@@ -90,6 +90,7 @@
 #define MVEBU_NR_UARTS		1
 
 #define MVEBU_UART_TYPE		"mvebu-uart"
+#define DRIVER_NAME		"mvebu_serial"
 
 static struct uart_port mvebu_uart_ports[MVEBU_NR_UARTS];
 
@@ -287,8 +288,8 @@ static int mvebu_uart_startup(struct uart_port *port)
 	udelay(1);
 	writel(CTRL_RX_INT, port->membase + UART_CTRL);
 
-	ret = request_irq(port->irq, mvebu_uart_isr, port->irqflags, "serial",
-			  port);
+	ret = request_irq(port->irq, mvebu_uart_isr, port->irqflags,
+			  DRIVER_NAME, port);
 	if (ret) {
 		dev_err(port->dev, "failed to request irq\n");
 		return ret;
@@ -538,7 +539,7 @@ console_initcall(mvebu_uart_console_init);
 
 static struct uart_driver mvebu_uart_driver = {
 	.owner			= THIS_MODULE,
-	.driver_name		= "mvebu_serial",
+	.driver_name		= DRIVER_NAME,
 	.dev_name		= "ttyMV",
 	.nr			= MVEBU_NR_UARTS,
 #ifdef CONFIG_SERIAL_MVEBU_CONSOLE
-- 
2.11.0

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
