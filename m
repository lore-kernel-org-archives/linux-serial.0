From: Huang Shijie <b32955@freescale.com>
Subject: [PATCH 2/2] serial: imx: remove the redandunt code
Date: Wed, 21 May 2014 08:56:29 +0800
Message-ID: <1400633789-31979-2-git-send-email-b32955@freescale.com>
References: <1400633789-31979-1-git-send-email-b32955@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1400633789-31979-1-git-send-email-b32955@freescale.com>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@linuxfoundation.org
Cc: linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Huang Shijie <b32955@freescale.com>
List-Id: linux-serial@vger.kernel.org

In the imx_startup(), we will reset the uart port which will reset all
the FIFOs, including the URXD.

So the code to clear the RX FIFO is redandunt. Just remove it.

Signed-off-by: Huang Shijie <b32955@freescale.com>
---
 drivers/tty/serial/imx.c |    9 ---------
 1 files changed, 0 insertions(+), 9 deletions(-)

diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
index 64901d0..febf400 100644
--- a/drivers/tty/serial/imx.c
+++ b/drivers/tty/serial/imx.c
@@ -1161,15 +1161,6 @@ static int imx_startup(struct uart_port *port)
 		temp |= UCR2_IRTS;
 	writel(temp, sport->port.membase + UCR2);
 
-	if (USE_IRDA(sport)) {
-		/* clear RX-FIFO */
-		int i = 64;
-		while ((--i > 0) &&
-			(readl(sport->port.membase + URXD0) & URXD_CHARRDY)) {
-			barrier();
-		}
-	}
-
 	if (!is_imx1_uart(sport)) {
 		temp = readl(sport->port.membase + UCR3);
 		temp |= IMX21_UCR3_RXDMUXSEL;
-- 
1.7.8
