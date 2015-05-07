From: Sebastian Andrzej Siewior <sebastian@breakpoint.cc>
Subject: [PATCH] serial: imx: Revert "initialized DMA w/o HW flow enabled"
Date: Thu, 7 May 2015 22:24:39 +0200
Message-ID: <20150507202439.GA4717@breakpoint.cc>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@linuxfoundation.org
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>, jiwang <jiada_wang@mentor.com>, jslaby@suse.cz, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, anton_bondarenko@mentor.com, dirk.behme@de.bosch.com, Nicolae Rosia <nicolae.rosia@gmail.com>, Fabio Estevam <fabio.estevam@freescale.com>
List-Id: linux-serial@vger.kernel.org

From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

This basically reverts commit 068500e08dc8 ("serial: imx: initialized
DMA w/o HW flow enabled") simply because it does not work as expected
without additional magic which I am not aware of. The DMA mode is only
used for non-console UARTs so the "standard" boot test won't notice this.

I tested it on various IMX6 (S and Q) boards and the default SDMA firmware
that is included in ROM does work properly. The SDMA interrupt counter does
not stop increment (which means the SDMA does not stop working or the ACK
is working) and I see a lot of 0x00 (sometimes other bytes) which are added
to the tty buffer which are not part of the data transfer.
Jiada claimed that there is a firmware which makes it work but failed to
provide me a link to the firmware. All he said was that it can not be
shipped as part of the kernel due to license issues. I've found a firmware
blob in the FSL-tree but this firmware causes only TTY-overflows an *no*
data is transmitted.

Currently I see no other way out.

Fixes: 068500e08dc8 ("serial: imx: initialized DMA w/o HW flow enabled")
Cc: Fabio Estevam <fabio.estevam@freescale.com>
Cc: Jiada Wang <jiada_wang@mentor.com>
Cc: nicolae.rosia@gmail.com
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 drivers/tty/serial/imx.c | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
index 8aff0b4d8ddf..e686c75fa4dc 100644
--- a/drivers/tty/serial/imx.c
+++ b/drivers/tty/serial/imx.c
@@ -1113,11 +1113,6 @@ static int imx_startup(struct uart_port *port)
 
 	writel(temp & ~UCR4_DREN, sport->port.membase + UCR4);
 
-	/* Can we enable the DMA support? */
-	if (is_imx6q_uart(sport) && !uart_console(port) &&
-	    !sport->dma_is_inited)
-		imx_uart_dma_init(sport);
-
 	spin_lock_irqsave(&sport->port.lock, flags);
 	/* Reset fifo's and state machines */
 	i = 100;
@@ -1308,6 +1303,17 @@ imx_set_termios(struct uart_port *port, struct ktermios *termios,
 			} else {
 				ucr2 |= UCR2_CTSC;
 			}
+
+			/*
+			 * Can we enable the DMA support? Be aware that
+			 * at least IMX6 needs to load external SDMA firmware in
+			 * order work properly. The in-ROM firmware is not
+			 * wokring properly.
+			 */
+			if ((ucr2 & UCR2_CTSC) && is_imx6q_uart(sport) &&
+			    !uart_console(port) && !sport->dma_is_inited)
+				imx_uart_dma_init(sport);
+
 		} else {
 			termios->c_cflag &= ~CRTSCTS;
 		}
@@ -1424,6 +1430,8 @@ imx_set_termios(struct uart_port *port, struct ktermios *termios,
 	if (UART_ENABLE_MS(&sport->port, termios->c_cflag))
 		imx_enable_ms(&sport->port);
 
+	if (sport->dma_is_inited && !sport->dma_is_enabled)
+		imx_enable_dma(sport);
 	spin_unlock_irqrestore(&sport->port.lock, flags);
 }
 
-- 
2.1.4
