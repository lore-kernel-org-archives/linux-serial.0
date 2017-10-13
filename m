From: Miquel Raynal <miquel.raynal@free-electrons.com>
Subject: [PATCH v2 07/16] serial: mvebu-uart: add function to change baudrate
Date: Fri, 13 Oct 2017 11:01:51 +0200
Message-ID: <20171013090200.31034-8-miquel.raynal@free-electrons.com>
References: <20171013090200.31034-1-miquel.raynal@free-electrons.com>
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <20171013090200.31034-1-miquel.raynal@free-electrons.com>
Sender: linux-gpio-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Linus Walleij <linus.walleij@linaro.org>, Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>, Gregory Clement <gregory.clement@free-electrons.com>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Jiri Slaby <jslaby@suse.com>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>
Cc: linux-serial@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Antoine Tenart <antoine.tenart@free-electrons.com>, Nadav Haklai <nadavh@marvell.com>, Wilson Ding <dingwei@marvell.com>, Allen Yan <yanwei@marvell.com>, Miquel Raynal <miquel.raynal@free-electrons.com>
List-Id: linux-serial@vger.kernel.org

From: Allen Yan <yanwei@marvell.com>

Until now, the first UART port baudrate was set by the bootloader.

Add a function allowing to change the baudrate. Changes may be done
from userspace but also at probe time by the kernel. Use the simplest
method: baudrate divisor.

Works for all UART ports until 230400 baud. To achieve higher baudrates,
software should implement the fractional divisor feature that allows
more accuracy for higher rates.

Signed-off-by: Allen Yan <yanwei@marvell.com>
[<miquel.raynal@free-electrons.com>: changed termios handling]
Signed-off-by: Miquel Raynal <miquel.raynal@free-electrons.com>
Reviewed-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
---
 drivers/tty/serial/mvebu-uart.c | 69 ++++++++++++++++++++++++++++++++++++++---
 1 file changed, 65 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/serial/mvebu-uart.c b/drivers/tty/serial/mvebu-uart.c
index e233f464d55a..5767196ec0a9 100644
--- a/drivers/tty/serial/mvebu-uart.c
+++ b/drivers/tty/serial/mvebu-uart.c
@@ -72,6 +72,7 @@
 				 | STAT_PAR_ERR | STAT_OVR_ERR)
 
 #define UART_BRDV		0x10
+#define  BRDV_BAUD_MASK         0x3FF
 
 #define MVEBU_NR_UARTS		1
 
@@ -344,6 +345,31 @@ static void mvebu_uart_shutdown(struct uart_port *port)
 	free_irq(port->irq, port);
 }
 
+static int mvebu_uart_baud_rate_set(struct uart_port *port, unsigned int baud)
+{
+	struct mvebu_uart *mvuart = to_mvuart(port);
+	unsigned int baud_rate_div;
+	u32 brdv;
+
+	if (IS_ERR(mvuart->clk))
+		return -PTR_ERR(mvuart->clk);
+
+	/*
+	 * The UART clock is divided by the value of the divisor to generate
+	 * UCLK_OUT clock, which is 16 times faster than the baudrate.
+	 * This prescaler can achieve all standard baudrates until 230400.
+	 * Higher baudrates could be achieved for the extended UART by using the
+	 * programmable oversampling stack (also called fractional divisor).
+	 */
+	baud_rate_div = DIV_ROUND_UP(port->uartclk, baud * 16);
+	brdv = readl(port->membase + UART_BRDV);
+	brdv &= ~BRDV_BAUD_MASK;
+	brdv |= baud_rate_div;
+	writel(brdv, port->membase + UART_BRDV);
+
+	return 0;
+}
+
 static void mvebu_uart_set_termios(struct uart_port *port,
 				   struct ktermios *termios,
 				   struct ktermios *old)
@@ -367,11 +393,30 @@ static void mvebu_uart_set_termios(struct uart_port *port,
 	if ((termios->c_cflag & CREAD) == 0)
 		port->ignore_status_mask |= STAT_RX_RDY(port) | STAT_BRK_ERR;
 
-	if (old)
-		tty_termios_copy_hw(termios, old);
+	/*
+	 * Maximum achievable frequency with simple baudrate divisor is 230400.
+	 * Since the error per bit frame would be of more than 15%, achieving
+	 * higher frequencies would require to implement the fractional divisor
+	 * feature.
+	 */
+	baud = uart_get_baud_rate(port, termios, old, 0, 230400);
+	if (mvebu_uart_baud_rate_set(port, baud)) {
+		/* No clock available, baudrate cannot be changed */
+		if (old)
+			baud = uart_get_baud_rate(port, old, NULL, 0, 230400);
+	} else {
+		tty_termios_encode_baud_rate(termios, baud, baud);
+		uart_update_timeout(port, termios->c_cflag, baud);
+	}
 
-	baud = uart_get_baud_rate(port, termios, old, 0, 460800);
-	uart_update_timeout(port, termios->c_cflag, baud);
+	/* Only the following flag changes are supported */
+	if (old) {
+		termios->c_iflag &= INPCK | IGNPAR;
+		termios->c_iflag |= old->c_iflag & ~(INPCK | IGNPAR);
+		termios->c_cflag &= CREAD | CBAUD;
+		termios->c_cflag |= old->c_cflag & ~(CREAD | CBAUD);
+		termios->c_lflag = old->c_lflag;
+	}
 
 	spin_unlock_irqrestore(&port->lock, flags);
 }
@@ -654,12 +699,28 @@ static int mvebu_uart_probe(struct platform_device *pdev)
 	if (!mvuart)
 		return -ENOMEM;
 
+	/* Get controller data depending on the compatible string */
 	mvuart->data = (struct mvebu_uart_driver_data *)match->data;
 	mvuart->port = port;
 
 	port->private_data = mvuart;
 	platform_set_drvdata(pdev, mvuart);
 
+	/* Get fixed clock frequency */
+	mvuart->clk = devm_clk_get(&pdev->dev, NULL);
+	if (IS_ERR(mvuart->clk)) {
+		if (PTR_ERR(mvuart->clk) == -EPROBE_DEFER)
+			return PTR_ERR(mvuart->clk);
+
+		if (IS_EXTENDED(port)) {
+			dev_err(&pdev->dev, "unable to get UART clock\n");
+			return PTR_ERR(mvuart->clk);
+		}
+	} else {
+		if (!clk_prepare_enable(mvuart->clk))
+			port->uartclk = clk_get_rate(mvuart->clk);
+	}
+
 	/* UART Soft Reset*/
 	writel(CTRL_SOFT_RST, port->membase + UART_CTRL(port));
 	udelay(1);
-- 
2.11.0

