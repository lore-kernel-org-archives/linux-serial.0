From: Huang Shijie <b32955@freescale.com>
Subject: [PATCH 1/2 bugfix] serial: imx: reset the uart port all the time
Date: Wed, 21 May 2014 08:56:28 +0800
Message-ID: <1400633789-31979-1-git-send-email-b32955@freescale.com>
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
To: gregkh@linuxfoundation.org
Cc: Huang Shijie <b32955@freescale.com>, linux-arm-kernel@lists.infradead.org, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

Current code resets the uart port only when it supports the irda mode.
In actually, we also need to reset the uart port in the non-irda mode.
A hang was caught in the following case:

    UART A transmits data to the other end. But the transmission maybe
    terminated. In some corner case, the TX FIFO maybe not empty.

The kernel will hang at the imx_set_termios():
	............................................................
	while (!(readl(sport->port.membase + USR2) & USR2_TXDC))
		barrier();
	............................................................

This patch resets the uart port all the time in the imx_startup().
And fix the hang.

Signed-off-by: Huang Shijie <b32955@freescale.com>
---
 drivers/tty/serial/imx.c |   22 ++++++++++------------
 1 files changed, 10 insertions(+), 12 deletions(-)

diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
index 3b6c1a2..64901d0 100644
--- a/drivers/tty/serial/imx.c
+++ b/drivers/tty/serial/imx.c
@@ -1070,7 +1070,7 @@ static void imx_disable_dma(struct imx_port *sport)
 static int imx_startup(struct uart_port *port)
 {
 	struct imx_port *sport = (struct imx_port *)port;
-	int retval;
+	int retval, i;
 	unsigned long flags, temp;
 
 	retval = clk_prepare_enable(sport->clk_per);
@@ -1098,17 +1098,15 @@ static int imx_startup(struct uart_port *port)
 
 	writel(temp & ~UCR4_DREN, sport->port.membase + UCR4);
 
-	if (USE_IRDA(sport)) {
-		/* reset fifo's and state machines */
-		int i = 100;
-		temp = readl(sport->port.membase + UCR2);
-		temp &= ~UCR2_SRST;
-		writel(temp, sport->port.membase + UCR2);
-		while (!(readl(sport->port.membase + UCR2) & UCR2_SRST) &&
-		    (--i > 0)) {
-			udelay(1);
-		}
-	}
+	/* Reset fifo's and state machines */
+	i = 100;
+
+	temp = readl(sport->port.membase + UCR2);
+	temp &= ~UCR2_SRST;
+	writel(temp, sport->port.membase + UCR2);
+
+	while (!(readl(sport->port.membase + UCR2) & UCR2_SRST) && (--i > 0))
+		udelay(1);
 
 	/*
 	 * Allocate the IRQ(s) i.MX1 has three interrupts whereas later
-- 
1.7.8
