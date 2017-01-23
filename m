From: Michal Simek <michal.simek@xilinx.com>
Subject: [PATCH] serial: xuartps: Enable uart loopback mode
Date: Mon, 23 Jan 2017 13:26:08 +0100
Message-ID: <db906bd31d3db0e29d87cd545e4c4e9096106bcc.1485174366.git.michal.simek@xilinx.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, monstr@monstr.eu
Cc: Yasir-Khan <yasir_khan@mentor.com>, =?UTF-8?q?S=C3=B6ren=20Brinkmann?= <soren.brinkmann@xilinx.com>, Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-arm-kernel@lists.infradead.org
List-Id: linux-serial@vger.kernel.org

From: Yasir-Khan <yasir_khan@mentor.com>

This patch adds xilinx uart loopback support by modifying the
cdns_uart_set_mctrl function to handle the switch to loopback mode.
After this patch, the loopback mode can be enabled/disabled by
setting/clearing the TIOCM_LOOP modem bit via TIOCMBIS/TIOCMBIC
ioctls respectively.

Signed-off-by: Yasir-Khan <yasir_khan@mentor.com>
Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---

 drivers/tty/serial/xilinx_uartps.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/tty/serial/xilinx_uartps.c b/drivers/tty/serial/xilinx_uartps.c
index dd4c02fa4820..ad77d0ed0c46 100644
--- a/drivers/tty/serial/xilinx_uartps.c
+++ b/drivers/tty/serial/xilinx_uartps.c
@@ -93,6 +93,7 @@
 #define CDNS_UART_MR_CLKSEL		0x00000001  /* Pre-scalar selection */
 #define CDNS_UART_MR_CHMODE_L_LOOP	0x00000200  /* Local loop back mode */
 #define CDNS_UART_MR_CHMODE_NORM	0x00000000  /* Normal mode */
+#define CDNS_UART_MR_CHMODE_MASK	0x00000300  /* Mask for mode bits */
 
 #define CDNS_UART_MR_STOPMODE_2_BIT	0x00000080  /* 2 stop bits */
 #define CDNS_UART_MR_STOPMODE_1_BIT	0x00000000  /* 1 stop bit */
@@ -998,17 +999,25 @@ static unsigned int cdns_uart_get_mctrl(struct uart_port *port)
 static void cdns_uart_set_mctrl(struct uart_port *port, unsigned int mctrl)
 {
 	u32 val;
+	u32 mode_reg;
 
 	val = readl(port->membase + CDNS_UART_MODEMCR);
+	mode_reg = readl(port->membase + CDNS_UART_MR);
 
 	val &= ~(CDNS_UART_MODEMCR_RTS | CDNS_UART_MODEMCR_DTR);
+	mode_reg &= ~CDNS_UART_MR_CHMODE_MASK;
 
 	if (mctrl & TIOCM_RTS)
 		val |= CDNS_UART_MODEMCR_RTS;
 	if (mctrl & TIOCM_DTR)
 		val |= CDNS_UART_MODEMCR_DTR;
+	if (mctrl & TIOCM_LOOP)
+		mode_reg |= CDNS_UART_MR_CHMODE_L_LOOP;
+	else
+		mode_reg |= CDNS_UART_MR_CHMODE_NORM;
 
 	writel(val, port->membase + CDNS_UART_MODEMCR);
+	writel(mode_reg, port->membase + CDNS_UART_MR);
 }
 
 #ifdef CONFIG_CONSOLE_POLL
-- 
1.9.1
