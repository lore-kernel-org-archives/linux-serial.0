From: John Ogness <john.ogness@linutronix.de>
Subject: [PATCH 4/4] tty: serial: 8250: omap: consume spurious interrupts
Date: Fri, 22 Jan 2016 11:27:56 +0100
Message-ID: <87si1pq577.fsf@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@linuxfoundation.org
Cc: vinod.koul@intel.com, dan.j.williams@intel.com, peter@hurleysoftware.com, bigeasy@linutronix.de, tony@atomide.com, nsekhar@ti.com, peter.ujfalusi@ti.com, dmaengine@vger.kernel.org, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

It has been seen that spurious interrupts are generated when the
DMA engine is in use. By disabling timeout interrupts (~IER_RDI)
this phenomenon goes away, but this driver relies on the timeout
interrupts, so we just consume the spurious interrupts.

Since we are consuming spurious interrupts, the irq cannot be
shared with other drivers. (It is never really shared anyway.)

Signed-off-by: John Ogness <john.ogness@linutronix.de>
---
 patch against next-20160122

 drivers/tty/serial/8250/8250_omap.c |   10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_omap.c b/drivers/tty/serial/8250/8250_omap.c
index ef7a60b..004b85a 100644
--- a/drivers/tty/serial/8250/8250_omap.c
+++ b/drivers/tty/serial/8250/8250_omap.c
@@ -630,7 +630,7 @@ static int omap_8250_startup(struct uart_port *port)
 	}
 #endif
 
-	ret = request_irq(port->irq, omap8250_irq, IRQF_SHARED,
+	ret = request_irq(port->irq, omap8250_irq, 0,
 			  dev_name(port->dev), port);
 	if (ret < 0)
 		goto err;
@@ -1112,8 +1112,14 @@ static int omap_8250_dma_handle_irq(struct uart_port *port, unsigned int iir)
 	unsigned char status;
 	int dma_err;
 
+	/*
+	 * It has been seen that spurious interrupts are generated when the
+	 * DMA engine is in use. By disabling timeout interrupts (~IER_RDI)
+	 * this phenomenon goes away, but this driver relies on the timeout
+	 * interrupts, so we just consume the spurious interrupts.
+	 */
 	if (iir & UART_IIR_NO_INT)
-		return 0;
+		return 1;
 
 	spin_lock(&port->lock);
 
-- 
1.7.10.4
