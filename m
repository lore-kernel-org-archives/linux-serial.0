From: Miquel Raynal <miquel.raynal@free-electrons.com>
Subject: [PATCH v2 03/16] serial: mvebu-uart: use driver name when requesting an interrupt
Date: Fri, 13 Oct 2017 11:01:47 +0200
Message-ID: <20171013090200.31034-4-miquel.raynal@free-electrons.com>
References: <20171013090200.31034-1-miquel.raynal@free-electrons.com>
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <20171013090200.31034-1-miquel.raynal@free-electrons.com>
Sender: linux-gpio-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Linus Walleij <linus.walleij@linaro.org>, Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>, Gregory Clement <gregory.clement@free-electrons.com>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Jiri Slaby <jslaby@suse.com>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>
Cc: linux-serial@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Antoine Tenart <antoine.tenart@free-electrons.com>, Nadav Haklai <nadavh@marvell.com>, Wilson Ding <dingwei@marvell.com>, Yehuda Yitschak <yehuday@marvell.com>, Miquel Raynal <miquel.raynal@free-electrons.com>
List-Id: linux-serial@vger.kernel.org

From: Yehuda Yitschak <yehuday@marvell.com>

Use the driver name when requesting an interrupt for consistency.

Avoids possible confusion with DW8250 driver interrupt names in
/proc/interrupts.

Signed-off-by: Yehuda Yitschak <yehuday@marvell.com>
Signed-off-by: Miquel Raynal <miquel.raynal@free-electrons.com>
Reviewed-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
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

