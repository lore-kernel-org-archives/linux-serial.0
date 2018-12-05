From: Michal Simek <michal.simek@xilinx.com>
Subject: [PATCH] serial: uartps: Fix interrupt mask issue to handle the RX interrupts properly
Date: Wed,  5 Dec 2018 14:21:28 +0100
Message-ID: <903d6b4f614a395d063f95bfc4658a6944526958.1544016085.git.michal.simek@xilinx.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, monstr@monstr.eu, michal.simek@xilinx.com, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
Cc: Nava kishore Manne <nava.manne@xilinx.com>, Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-serial@vger.kernel.org

From: Nava kishore Manne <nava.manne@xilinx.com>

This patch Correct the RX interrupt mask value to handle the
RX interrupts properly.

Fixes: c8dbdc842d30 ("serial: xuartps: Rewrite the interrupt handling logic")
Signed-off-by: Nava kishore Manne <navam@xilinx.com>
Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---

 drivers/tty/serial/xilinx_uartps.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/xilinx_uartps.c b/drivers/tty/serial/xilinx_uartps.c
index c6d38617d622..094f2958cb2b 100644
--- a/drivers/tty/serial/xilinx_uartps.c
+++ b/drivers/tty/serial/xilinx_uartps.c
@@ -123,7 +123,7 @@
 #define CDNS_UART_IXR_RXTRIG	0x00000001 /* RX FIFO trigger interrupt */
 #define CDNS_UART_IXR_RXFULL	0x00000004 /* RX FIFO full interrupt. */
 #define CDNS_UART_IXR_RXEMPTY	0x00000002 /* RX FIFO empty interrupt. */
-#define CDNS_UART_IXR_MASK	0x00001FFF /* Valid bit mask */
+#define CDNS_UART_IXR_RXMASK	0x000021e7 /* Valid RX bit mask */
 
 	/*
 	 * Do not enable parity error interrupt for the following
@@ -364,7 +364,7 @@ static irqreturn_t cdns_uart_isr(int irq, void *dev_id)
 		cdns_uart_handle_tx(dev_id);
 		isrstatus &= ~CDNS_UART_IXR_TXEMPTY;
 	}
-	if (isrstatus & CDNS_UART_IXR_MASK)
+	if (isrstatus & CDNS_UART_IXR_RXMASK)
 		cdns_uart_handle_rx(dev_id, isrstatus);
 
 	spin_unlock(&port->lock);
-- 
1.9.1
