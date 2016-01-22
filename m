From: John Ogness <john.ogness@linutronix.de>
Subject: [PATCH REPOST] tty: serial: 8250: omap: restore registers on shutdown
Date: Fri, 22 Jan 2016 17:28:34 +0100
Message-ID: <87vb6llgst.fsf@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@linuxfoundation.org
Cc: peter@hurleysoftware.com, bigeasy@linutronix.de, tony@atomide.com, nsekhar@ti.com, peter.ujfalusi@ti.com, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

If DMA is active during a shutdown, a delayed restore of the
registers may be pending. The restore must be performed after
the DMA is stopped, otherwise the delayed restore remains
pending and will fire upon the first DMA TX complete of a
totally different serial session.

Signed-off-by: John Ogness <john.ogness@linutronix.de>
---
 This patch was originally posted and discussed here:
 http://lkml.kernel.org/r/87egjp2r4a.fsf@linutronix.de

 The patch was not accepted because Peter expressed dissatisfaction with
 the entire deferred implementation. (This patch fixes a bug in that
 implementation.) However, no alternative solution was determined and the
 bug continues to exist.

 Although we can certainly continue to debate about an alternate solution
 to the deferred implementation, I think it makes sense to at least fix
 the existing bug until an alternative exists.

 The bug can be easily produced with a `kill -9` on a process transmitting
 on the serial port.

 patch against next-20160122

 drivers/tty/serial/8250/8250_omap.c |    8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/8250/8250_omap.c b/drivers/tty/serial/8250/8250_omap.c
index a2c0734..0ffec67 100644
--- a/drivers/tty/serial/8250/8250_omap.c
+++ b/drivers/tty/serial/8250/8250_omap.c
@@ -664,9 +664,15 @@ static void omap_8250_shutdown(struct uart_port *port)
 	up->ier = 0;
 	serial_out(up, UART_IER, 0);
 
-	if (up->dma)
+	if (up->dma) {
 		serial8250_release_dma(up);
 
+		if (priv->delayed_restore) {
+			priv->delayed_restore = 0;
+			omap8250_restore_regs(up);
+		}
+	}
+
 	/*
 	 * Disable break condition and FIFOs
 	 */
-- 
1.7.10.4
