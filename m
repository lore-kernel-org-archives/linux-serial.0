From: Michal Simek <michal.simek@xilinx.com>
Subject: [PATCH] serial: xuartps: Fix the early_console junk character issue
Date: Wed,  4 Apr 2018 12:20:47 +0200
Message-ID: <6698032e594f5f921f25c4a7e235e0cee5521087.1522837245.git.michal.simek@xilinx.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, monstr@monstr.eu, agraf@suse.de
Cc: Nava kishore Manne <nava.manne@xilinx.com>, Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-arm-kernel@lists.infradead.org
List-Id: linux-serial@vger.kernel.org

From: Nava kishore Manne <nava.manne@xilinx.com>

In the early_console_setup is trying to access the unregister clock value,
so we are receiving some garbage clk value because of this wrong clk value
the early_console_setup is fail to set the required console baud rate.

This path fix this issue.

Signed-off-by: Nava kishore Manne <navam@xilinx.com>
Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---

 drivers/tty/serial/xilinx_uartps.c | 27 +--------------------------
 1 file changed, 1 insertion(+), 26 deletions(-)

diff --git a/drivers/tty/serial/xilinx_uartps.c b/drivers/tty/serial/xilinx_uartps.c
index 19d370779767..4176c3a0b4e8 100644
--- a/drivers/tty/serial/xilinx_uartps.c
+++ b/drivers/tty/serial/xilinx_uartps.c
@@ -1130,34 +1130,9 @@ static void cdns_early_write(struct console *con, const char *s,
 static int __init cdns_early_console_setup(struct earlycon_device *device,
 					   const char *opt)
 {
-	struct uart_port *port = &device->port;
-
-	if (!port->membase)
+	if (!device->port.membase)
 		return -ENODEV;
 
-	/* initialise control register */
-	writel(CDNS_UART_CR_TX_EN|CDNS_UART_CR_TXRST|CDNS_UART_CR_RXRST,
-	       port->membase + CDNS_UART_CR);
-
-	/* only set baud if specified on command line - otherwise
-	 * assume it has been initialized by a boot loader.
-	 */
-	if (device->baud) {
-		u32 cd = 0, bdiv = 0;
-		u32 mr;
-		int div8;
-
-		cdns_uart_calc_baud_divs(port->uartclk, device->baud,
-					 &bdiv, &cd, &div8);
-		mr = CDNS_UART_MR_PARITY_NONE;
-		if (div8)
-			mr |= CDNS_UART_MR_CLKSEL;
-
-		writel(mr,   port->membase + CDNS_UART_MR);
-		writel(cd,   port->membase + CDNS_UART_BAUDGEN);
-		writel(bdiv, port->membase + CDNS_UART_BAUDDIV);
-	}
-
 	device->con->write = cdns_early_write;
 
 	return 0;
-- 
1.9.1
