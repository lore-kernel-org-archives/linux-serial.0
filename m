From: Michal Simek <michal.simek@xilinx.com>
Subject: [PATCH] serial: uartps: Enable automatic flow control
Date: Mon,  3 Sep 2018 15:05:37 +0200
Message-ID: <2e3db53f40db4ce52000f39461c9b0e534e8ec2c.1535979935.git.michal.simek@xilinx.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, monstr@monstr.eu
Cc: Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-arm-kernel@lists.infradead.org
List-Id: linux-serial@vger.kernel.org

Enable automatic flow control which should ensure that there is no
mainteinance in connection for zcu100 BT case.

Signed-off-by: Michal Simek <michal.simek@xilinx.com>
Acked-by: Nava kishore Manne <navam@xilinx.com>
---

 drivers/tty/serial/xilinx_uartps.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/tty/serial/xilinx_uartps.c b/drivers/tty/serial/xilinx_uartps.c
index a48f19b1b88f..e5d90611c03f 100644
--- a/drivers/tty/serial/xilinx_uartps.c
+++ b/drivers/tty/serial/xilinx_uartps.c
@@ -1003,13 +1003,12 @@ static void cdns_uart_set_mctrl(struct uart_port *port, unsigned int mctrl)
 	val = readl(port->membase + CDNS_UART_MODEMCR);
 	mode_reg = readl(port->membase + CDNS_UART_MR);
 
-	val &= ~(CDNS_UART_MODEMCR_RTS | CDNS_UART_MODEMCR_DTR);
+	val &= ~(CDNS_UART_MODEMCR_RTS | CDNS_UART_MODEMCR_DTR |
+		 CDNS_UART_MODEMCR_FCM);
 	mode_reg &= ~CDNS_UART_MR_CHMODE_MASK;
 
-	if (mctrl & TIOCM_RTS)
-		val |= CDNS_UART_MODEMCR_RTS;
-	if (mctrl & TIOCM_DTR)
-		val |= CDNS_UART_MODEMCR_DTR;
+	if (mctrl & TIOCM_RTS || mctrl & TIOCM_DTR)
+		val |= CDNS_UART_MODEMCR_FCM;
 	if (mctrl & TIOCM_LOOP)
 		mode_reg |= CDNS_UART_MR_CHMODE_L_LOOP;
 	else
-- 
1.9.1
