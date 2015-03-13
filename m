From: Jiada Wang <jiada_wang@mentor.com>
Subject: [PATCH] serial: imx: protect Soft Reset of port with lock
Date: Fri, 13 Mar 2015 15:38:11 +0900
Message-ID: <1426228691-20529-1-git-send-email-jiada_wang@mentor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: gregkh@linuxfoundation.org, jslaby@suse.cz, linux-serial@vger.kernel.org
Cc: jiada_wang@mentor.com, linux-arm-kernel@lists.infradead.org
List-Id: linux-serial@vger.kernel.org

Previously Soft Reset (clear of SRST bit in UCR2 register)
of UART in startup is not protected by lock, which may have race
with console_write, as console_write may occur at anytime even
when UART port is shutdown.

To avoid this race, protect Soft reset of UART port with spin_lock.

Signed-off-by: Jiada Wang <jiada_wang@mentor.com>
---
 drivers/tty/serial/imx.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
index 0eb29b1..f81ccb1 100644
--- a/drivers/tty/serial/imx.c
+++ b/drivers/tty/serial/imx.c
@@ -1165,6 +1165,12 @@ static int imx_startup(struct uart_port *port)
 
 	writel(temp & ~UCR4_DREN, sport->port.membase + UCR4);
 
+	/* Can we enable the DMA support? */
+	if (is_imx6q_uart(sport) && !uart_console(port) &&
+	    !sport->dma_is_inited)
+		imx_uart_dma_init(sport);
+
+	spin_lock_irqsave(&sport->port.lock, flags);
 	/* Reset fifo's and state machines */
 	i = 100;
 
@@ -1175,12 +1181,6 @@ static int imx_startup(struct uart_port *port)
 	while (!(readl(sport->port.membase + UCR2) & UCR2_SRST) && (--i > 0))
 		udelay(1);
 
-	/* Can we enable the DMA support? */
-	if (is_imx6q_uart(sport) && !uart_console(port) &&
-	    !sport->dma_is_inited)
-		imx_uart_dma_init(sport);
-
-	spin_lock_irqsave(&sport->port.lock, flags);
 	/*
 	 * Finally, clear and enable interrupts
 	 */
-- 
1.9.3
