From: Miquel Raynal <miquel.raynal@bootlin.com>
Subject: [PATCH 1/2] serial: mvebu-uart: clarify the baud rate derivation
Date: Fri, 23 Nov 2018 16:45:29 +0100
Message-ID: <20181123154530.8022-1-miquel.raynal@bootlin.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, Nadav Haklai <nadavh@marvell.com>, Antoine Tenart <antoine.tenart@bootlin.com>, Maxime Chevallier <maxime.chevallier@bootlin.com>, Gregory Clement <gregory.clement@bootlin.com>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Russell King <linux@armlinux.org.uk>, Marc Zyngier <marc.zyngier@arm.com>, Miquel Raynal <miquel.raynal@bootlin.com>
List-Id: linux-serial@vger.kernel.org

The current comment in ->set_baud_rate() is rather incomplete as it
fails to describe what are the actual stages for the baudrate
derivation. Replace this comment with something more explicit and
close to the functional specification. Also adapt the variable names
to it.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 drivers/tty/serial/mvebu-uart.c | 22 ++++++++++++++--------
 1 file changed, 14 insertions(+), 8 deletions(-)

diff --git a/drivers/tty/serial/mvebu-uart.c b/drivers/tty/serial/mvebu-uart.c
index 170e446a2f62..df6e4d8cdbd6 100644
--- a/drivers/tty/serial/mvebu-uart.c
+++ b/drivers/tty/serial/mvebu-uart.c
@@ -72,6 +72,7 @@
 #define  BRDV_BAUD_MASK         0x3FF
 
 #define UART_OSAMP		0x14
+#define  OSAMP_DEFAULT_DIVISOR	16
 
 #define MVEBU_NR_UARTS		2
 
@@ -444,23 +445,28 @@ static void mvebu_uart_shutdown(struct uart_port *port)
 static int mvebu_uart_baud_rate_set(struct uart_port *port, unsigned int baud)
 {
 	struct mvebu_uart *mvuart = to_mvuart(port);
-	unsigned int baud_rate_div;
+	unsigned int d_divisor, m_divisor;
 	u32 brdv;
 
 	if (IS_ERR(mvuart->clk))
 		return -PTR_ERR(mvuart->clk);
 
 	/*
-	 * The UART clock is divided by the value of the divisor to generate
-	 * UCLK_OUT clock, which is 16 times faster than the baudrate.
-	 * This prescaler can achieve all standard baudrates until 230400.
-	 * Higher baudrates could be achieved for the extended UART by using the
-	 * programmable oversampling stack (also called fractional divisor).
+	 * The baudrate is derived from the UART clock thanks to two divisors:
+	 *   > D ("baud generator"): can divide the clock from 2 to 2^10 - 1.
+	 *   > M ("fractional divisor"): allows a better accuracy for
+	 *     baudrates higher than 230400.
+	 *
+	 * As the derivation of M is rather complicated, the code sticks to its
+	 * default value (x16) when all the prescalers are zeroed, and only
+	 * makes use of D to configure the desired baudrate.
 	 */
-	baud_rate_div = DIV_ROUND_UP(port->uartclk, baud * 16);
+	m_divisor = OSAMP_DEFAULT_DIVISOR;
+	d_divisor = DIV_ROUND_UP(port->uartclk, baud * m_divisor);
+
 	brdv = readl(port->membase + UART_BRDV);
 	brdv &= ~BRDV_BAUD_MASK;
-	brdv |= baud_rate_div;
+	brdv |= d_divisor;
 	writel(brdv, port->membase + UART_BRDV);
 
 	return 0;
-- 
2.19.1
