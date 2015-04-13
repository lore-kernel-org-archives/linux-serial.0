From: Jiada Wang <jiada_wang@mentor.com>
Subject: [PATCH v2] serial: imx: protect Soft Reset of port with lock
Date: Mon, 13 Apr 2015 18:31:43 +0900
Message-ID: <1428917503-27324-1-git-send-email-jiada_wang@mentor.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@linuxfoundation.org, jslaby@suse.cz
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, jiada_wang@mentor.com
List-Id: linux-serial@vger.kernel.org

Previously Soft Reset (clear of SRST bit in UCR2 register)
of UART in startup is not protected by lock, which may have race
with console_write, as console_write may occur at anytime even
when UART port is shutdown.

To avoid this race, protect Soft reset of UART port with spin_lock.

Signed-off-by: Jiada Wang <jiada_wang@mentor.com>
---
 drivers/tty/serial/imx.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
index c8cfa06..38717c7 100644
--- a/drivers/tty/serial/imx.c
+++ b/drivers/tty/serial/imx.c
@@ -1114,6 +1114,12 @@ static int imx_startup(struct uart_port *port)
 
 	writel(temp & ~UCR4_DREN, sport->port.membase + UCR4);
 
+	/* Can we enable the DMA support? */
+	if (is_imx6q_uart(sport) && !uart_console(port) &&
+	    !sport->dma_is_inited)
+		imx_uart_dma_init(sport);
+
+	spin_lock_irqsave(&sport->port.lock, flags);
 	/* Reset fifo's and state machines */
 	i = 100;
 
@@ -1124,13 +1130,6 @@ static int imx_startup(struct uart_port *port)
 	while (!(readl(sport->port.membase + UCR2) & UCR2_SRST) && (--i > 0))
 		udelay(1);
 
-	/* Can we enable the DMA support? */
-	if (is_imx6q_uart(sport) && !uart_console(port) &&
-	    !sport->dma_is_inited)
-		imx_uart_dma_init(sport);
-
-	spin_lock_irqsave(&sport->port.lock, flags);
-
 	/*
 	 * Finally, clear and enable interrupts
 	 */
-- 
1.9.3
