From: Joe Perches <joe@perches.com>
Subject: [PATCH] serial: sh-sci: Neaten dev_<level> uses
Date: Tue, 11 Mar 2014 10:10:46 -0700
Message-ID: <1394557846.21085.54.camel@joe-AO722>
References: <1394532680-4264-1-git-send-email-geert@linux-m68k.org>
	 <1394548060.21085.45.camel@joe-AO722>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from smtprelay0051.hostedemail.com ([216.40.44.51]:59585 "EHLO
	smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751648AbaCKRKu (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 11 Mar 2014 13:10:50 -0400
In-Reply-To: <1394548060.21085.45.camel@joe-AO722>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Simon Horman <horms+renesas@verge.net.au>, Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, linux-serial@vger.kernel.org, linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org, Geert Uytterhoeven <geert+renesas@linux-m68k.org>

Add missing newlines and coalesce formats.
Realign arguments.

Signed-off-by: Joe Perches <joe@perches.com>
---
 drivers/tty/serial/sh-sci.c | 38 ++++++++++++++++++--------------------
 1 file changed, 18 insertions(+), 20 deletions(-)

diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
index 0cb5237..eee159c 100644
--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -788,7 +788,7 @@ static int sci_handle_errors(struct uart_port *port)
 		if (tty_insert_flip_char(tport, 0, TTY_OVERRUN))
 			copied++;
 
-		dev_notice(port->dev, "overrun error");
+		dev_notice(port->dev, "overrun error\n");
 	}
 
 	if (status & SCxSR_FER(port)) {
@@ -830,7 +830,7 @@ static int sci_handle_errors(struct uart_port *port)
 		if (tty_insert_flip_char(tport, 0, TTY_PARITY))
 			copied++;
 
-		dev_notice(port->dev, "parity error");
+		dev_notice(port->dev, "parity error\n");
 	}
 
 	if (copied)
@@ -1290,7 +1290,8 @@ static void sci_dma_rx_complete(void *arg)
 	unsigned long flags;
 	int count;
 
-	dev_dbg(port->dev, "%s(%d) active #%d\n", __func__, port->line, s->active_rx);
+	dev_dbg(port->dev, "%s(%d) active #%d\n",
+		__func__, port->line, s->active_rx);
 
 	spin_lock_irqsave(&port->lock, flags);
 
@@ -1366,8 +1367,8 @@ static void sci_submit_rx(struct sci_port *s)
 			sci_rx_dma_release(s, true);
 			return;
 		}
-		dev_dbg(s->port.dev, "%s(): cookie %d to #%d\n", __func__,
-			s->cookie_rx[i], i);
+		dev_dbg(s->port.dev, "%s(): cookie %d to #%d\n",
+			__func__, s->cookie_rx[i], i);
 	}
 
 	s->active_rx = s->cookie_rx[0];
@@ -1426,8 +1427,8 @@ static void work_fn_rx(struct work_struct *work)
 
 	s->active_rx = s->cookie_rx[!new];
 
-	dev_dbg(port->dev, "%s: cookie %d #%d, new active #%d\n", __func__,
-		s->cookie_rx[new], new, s->active_rx);
+	dev_dbg(port->dev, "%s: cookie %d #%d, new active #%d\n",
+		__func__, s->cookie_rx[new], new, s->active_rx);
 }
 
 static void work_fn_tx(struct work_struct *work)
@@ -1480,8 +1481,8 @@ static void work_fn_tx(struct work_struct *work)
 		return;
 	}
 
-	dev_dbg(port->dev, "%s: %p: %d...%d, cookie %d\n", __func__,
-		xmit->buf, xmit->tail, xmit->head, s->cookie_tx);
+	dev_dbg(port->dev, "%s: %p: %d...%d, cookie %d\n",
+		__func__, xmit->buf, xmit->tail, xmit->head, s->cookie_tx);
 
 	dma_async_issue_pending(chan);
 }
@@ -1600,8 +1601,8 @@ static bool filter(struct dma_chan *chan, void *slave)
 {
 	struct sh_dmae_slave *param = slave;
 
-	dev_dbg(chan->device->dev, "%s: slave ID %d\n", __func__,
-		param->shdma_slave.slave_id);
+	dev_dbg(chan->device->dev, "%s: slave ID %d\n",
+		__func__, param->shdma_slave.slave_id);
 
 	chan->private = &param->shdma_slave;
 	return true;
@@ -1630,8 +1631,7 @@ static void sci_request_dma(struct uart_port *port)
 	dma_cap_mask_t mask;
 	int nent;
 
-	dev_dbg(port->dev, "%s: port %d\n", __func__,
-		port->line);
+	dev_dbg(port->dev, "%s: port %d\n", __func__, port->line);
 
 	if (s->cfg->dma_slave_tx <= 0 || s->cfg->dma_slave_rx <= 0)
 		return;
@@ -1659,7 +1659,8 @@ static void sci_request_dma(struct uart_port *port)
 		if (!nent)
 			sci_tx_dma_release(s, false);
 		else
-			dev_dbg(port->dev, "%s: mapped %d@%p to %pad\n", __func__,
+			dev_dbg(port->dev, "%s: mapped %d@%p to %pad\n",
+				__func__,
 				sg_dma_len(&s->sg_tx), port->state->xmit.buf,
 				&sg_dma_address(&s->sg_tx));
 
@@ -1933,8 +1934,7 @@ static void sci_set_termios(struct uart_port *port, struct ktermios *termios,
 	if (s->chan_rx) {
 		s->rx_timeout = (port->timeout - HZ / 50) * s->buf_len_rx * 3 /
 			port->fifosize / 2;
-		dev_dbg(port->dev,
-			"DMA Rx t-out %ums, tty t-out %u jiffies\n",
+		dev_dbg(port->dev, "DMA Rx t-out %ums, tty t-out %u jiffies\n",
 			s->rx_timeout * 1000 / HZ, port->timeout);
 		if (s->rx_timeout < msecs_to_jiffies(20))
 			s->rx_timeout = msecs_to_jiffies(20);
@@ -2502,11 +2502,9 @@ static int sci_probe_single(struct platform_device *dev,
 
 	/* Sanity check */
 	if (unlikely(index >= SCI_NPORTS)) {
-		dev_notice(&dev->dev, "Attempting to register port "
-			   "%d when only %d are available.\n",
+		dev_notice(&dev->dev, "Attempting to register port %d when only %d are available\n",
 			   index+1, SCI_NPORTS);
-		dev_notice(&dev->dev, "Consider bumping "
-			   "CONFIG_SERIAL_SH_SCI_NR_UARTS!\n");
+		dev_notice(&dev->dev, "Consider bumping CONFIG_SERIAL_SH_SCI_NR_UARTS!\n");
 		return -EINVAL;
 	}
 


