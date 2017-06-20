From: Clemens Gruber <clemens.gruber@pqgruber.com>
Subject: [PATCH] serial: imx: disable DMA for RS-485 on i.MX6 SMP
Date: Tue, 20 Jun 2017 17:37:01 +0200
Message-ID: <20170620153701.12626-1-clemens.gruber@pqgruber.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Fabio Estevam <fabio.estevam@nxp.com>, u.kleine-koenig@pengutronix.de, linux-kernel@vger.kernel.org, Clemens Gruber <clemens.gruber@pqgruber.com>, stable@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

DMA support for half-duplex RS-485 never worked correctly on i.MX6Q/D
due to an undiscovered SMP-related bug, instead of the real data being
sent out, the rest of the transmit buffer is sent (xmit->tail jumps over
xmit->head in imx_transmit_buffer and UART_XMIT_SIZE bytes are sent out)
More details: https://lkml.org/lkml/2017/1/4/579

Disable it for that configuration until the bug is found and fixed.

We need to know at probe time if we can enable DMA. (RS-485 could be
enabled after that). Let's therefore only enable DMA if it is not an
i.MX6Q/D UART with uart-has-rtscts in the DT and CONFIG_SMP enabled.

Fixes: 17b8f2a3fdca ("serial: imx: add support for half duplex rs485")
Cc: <stable@vger.kernel.org>
Signed-off-by: Clemens Gruber <clemens.gruber@pqgruber.com>
---
 drivers/tty/serial/imx.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
index bbefddd92bfe..000949f686a4 100644
--- a/drivers/tty/serial/imx.c
+++ b/drivers/tty/serial/imx.c
@@ -1277,8 +1277,14 @@ static int imx_startup(struct uart_port *port)
 
 	writel(temp & ~UCR4_DREN, sport->port.membase + UCR4);
 
-	/* Can we enable the DMA support? */
-	if (!uart_console(port) && !sport->dma_is_inited)
+	/*
+	 * Can we enable the DMA support?
+	 * RS-485 DMA is broken on i.MX6D/Q SMP systems. Do not use DMA on
+	 * UARTs with RTS/CTS to prevent misbehavior until the bug is fixed.
+	 */
+	if (!uart_console(port) && !sport->dma_is_inited &&
+	    !(sport->have_rtscts && is_imx6q_uart(sport) &&
+	      IS_ENABLED(CONFIG_SMP)))
 		imx_uart_dma_init(sport);
 
 	spin_lock_irqsave(&sport->port.lock, flags);
-- 
2.13.1
