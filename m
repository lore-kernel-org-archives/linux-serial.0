From: Michal Simek <michal.simek@xilinx.com>
Subject: [PATCH 3/4] serial: xuartps: Do not enable parity error interrupt
Date: Mon, 17 Aug 2015 09:22:33 +0200
Message-ID: <d586f20ceb4a1f355ccf8817c95877d11c14b824.1439796149.git.michal.simek@xilinx.com>
References: <5b154ba97bcd79e49e2131152eb2fc1761594a6c.1439796149.git.michal.simek@xilinx.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <5b154ba97bcd79e49e2131152eb2fc1761594a6c.1439796149.git.michal.simek@xilinx.com>
In-Reply-To: <5b154ba97bcd79e49e2131152eb2fc1761594a6c.1439796149.git.michal.simek@xilinx.com>
References: <5b154ba97bcd79e49e2131152eb2fc1761594a6c.1439796149.git.michal.simek@xilinx.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, monstr@monstr.eu
Cc: Anirudha Sarangi <anirudha.sarangi@xilinx.com>, =?UTF-8?q?S=C3=B6ren=20Brinkmann?= <soren.brinkmann@xilinx.com>, Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-arm-kernel@lists.infradead.org
List-Id: linux-serial@vger.kernel.org

From: Anirudha Sarangi <anirudha.sarangi@xilinx.com>

The patch makes changes not to enable parity error interrupt.
With the current implementation, each parity error results in
two distinct interrupts (almost always). The first one is normal
parity error interrupt with no data in the fifo and the second one
is a proper Rx interrupt with the received data in the fifo. By
disabling parity error interrupt we still ensure handling of
parity errors as for the Rx fifo interrupt the parity error still
shows up in the interrupt status register. Considering the fact
that the by default INPCK and IGNPAR are not set, this is the
optimal implementation for parity error handling.

Signed-off-by: Anirudha Sarangi <anirudh@xilinx.com>
Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---

 drivers/tty/serial/xilinx_uartps.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/xilinx_uartps.c b/drivers/tty/serial/xilinx_uartps.c
index c4437e8929ff..2dc26e5f1384 100644
--- a/drivers/tty/serial/xilinx_uartps.c
+++ b/drivers/tty/serial/xilinx_uartps.c
@@ -803,8 +803,18 @@ static int cdns_uart_startup(struct uart_port *port)
 	writel(readl(port->membase + CDNS_UART_ISR_OFFSET),
 			port->membase + CDNS_UART_ISR_OFFSET);
 
-	/* Set the Interrupt Registers with desired interrupts */
-	writel(CDNS_UART_IXR_TXEMPTY | CDNS_UART_IXR_PARITY |
+	/*
+	 * Set the Interrupt Registers with desired interrupts. Do not
+	 * enable parity error interrupt for the following reason:
+	 * When parity error interrupt is enabled, each Rx parity error always
+	 * results in 2 events. The first one being parity error interrupt
+	 * and the second one with a proper Rx interrupt with the incoming data.
+	 * Disabling parity error interrupt ensures better handling of parity
+	 * error events. With this change, for a parity error case, we get a
+	 * Rx interrupt with parity error set in ISR register and we still
+	 * handle parity errors in the desired way.
+	 */
+	writel(CDNS_UART_IXR_TXEMPTY |
 		CDNS_UART_IXR_FRAMING | CDNS_UART_IXR_OVERRUN |
 		CDNS_UART_IXR_RXTRIG | CDNS_UART_IXR_TOUT,
 		port->membase + CDNS_UART_IER_OFFSET);
-- 
2.3.5
