From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH v3 13/33] serial: sh-sci: Improve DMA error messages
Date: Fri, 21 Aug 2015 20:02:37 +0200
Message-ID: <1440180177-6924-14-git-send-email-geert+renesas@glider.be>
References: <1440180177-6924-1-git-send-email-geert+renesas@glider.be>
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <1440180177-6924-1-git-send-email-geert+renesas@glider.be>
Sender: linux-sh-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>
Cc: Magnus Damm <magnus.damm@gmail.com>, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, Yoshihiro Kaneko <ykaneko0929@gmail.com>, Kazuya Mizuguchi <kazuya.mizuguchi.ks@renesas.com>, Koji Matsuoka <koji.matsuoka.xm@renesas.com>, Wolfram Sang <wsa@the-dreams.de>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>, linux-serial@vger.kernel.org, linux-sh@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>
List-Id: linux-serial@vger.kernel.org

Make the life of the driver developer/debugger easier:
  - Add __func__ prefix to identical messages,
  - Add DMA directions to messages,
  - Add TX failure messages,
  - Always use "cookie %d" for DMA cookies,
  - "#%d" is reserved for the DMA cookie/descriptor index.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
v3:
  - Rebased,

v2:
  - Add "cookie %d" and ""#%d" consistency.
---
 drivers/tty/serial/sh-sci.c | 27 ++++++++++++++++-----------
 1 file changed, 16 insertions(+), 11 deletions(-)

diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
index c4cb7a5a2b110753..340700a11b152952 100644
--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -1319,7 +1319,8 @@ static int sci_dma_rx_push(struct sci_port *s, size_t count)
 	} else if (s->active_rx == s->cookie_rx[1]) {
 		active = 1;
 	} else {
-		dev_err(port->dev, "cookie %d not found!\n", s->active_rx);
+		dev_err(port->dev, "%s: Rx cookie %d not found!\n", __func__,
+			s->active_rx);
 		return 0;
 	}
 
@@ -1345,8 +1346,8 @@ static void sci_dma_rx_complete(void *arg)
 	unsigned long flags;
 	int count;
 
-	dev_dbg(port->dev, "%s(%d) active #%d\n",
-		__func__, port->line, s->active_rx);
+	dev_dbg(port->dev, "%s(%d) active cookie %d\n", __func__, port->line,
+		s->active_rx);
 
 	spin_lock_irqsave(&port->lock, flags);
 
@@ -1418,12 +1419,12 @@ static void sci_submit_rx(struct sci_port *s)
 				s->cookie_rx[i] = -EINVAL;
 			}
 			dev_warn(s->port.dev,
-				 "failed to re-start DMA, using PIO\n");
+				 "Failed to re-start Rx DMA, using PIO\n");
 			sci_rx_dma_release(s, true);
 			return;
 		}
-		dev_dbg(s->port.dev, "%s(): cookie %d to #%d\n",
-			__func__, s->cookie_rx[i], i);
+		dev_dbg(s->port.dev, "%s(): cookie %d to #%d\n", __func__,
+			s->cookie_rx[i], i);
 	}
 
 	s->active_rx = s->cookie_rx[0];
@@ -1443,7 +1444,8 @@ static void work_fn_rx(struct work_struct *work)
 	} else if (s->active_rx == s->cookie_rx[1]) {
 		new = 1;
 	} else {
-		dev_err(port->dev, "cookie %d not found!\n", s->active_rx);
+		dev_err(port->dev, "%s: Rx cookie %d not found!\n", __func__,
+			s->active_rx);
 		return;
 	}
 	desc = s->desc_rx[new];
@@ -1482,7 +1484,7 @@ static void work_fn_rx(struct work_struct *work)
 
 	s->active_rx = s->cookie_rx[!new];
 
-	dev_dbg(port->dev, "%s: cookie %d #%d, new active #%d\n",
+	dev_dbg(port->dev, "%s: cookie %d #%d, new active cookie %d\n",
 		__func__, s->cookie_rx[new], new, s->active_rx);
 }
 
@@ -1516,6 +1518,7 @@ static void work_fn_tx(struct work_struct *work)
 			sg, s->sg_len_tx, DMA_MEM_TO_DEV,
 			DMA_PREP_INTERRUPT | DMA_CTRL_ACK);
 	if (!desc) {
+		dev_warn(port->dev, "Failed preparing Tx DMA descriptor\n");
 		/* switch to PIO */
 		sci_tx_dma_release(s, true);
 		return;
@@ -1704,13 +1707,15 @@ static void sci_request_dma(struct uart_port *port)
 			    UART_XMIT_SIZE,
 			    (uintptr_t)port->state->xmit.buf & ~PAGE_MASK);
 		nent = dma_map_sg(port->dev, &s->sg_tx, 1, DMA_TO_DEVICE);
-		if (!nent)
+		if (!nent) {
+			dev_warn(port->dev, "Failed mapping Tx DMA descriptor\n");
 			sci_tx_dma_release(s, false);
-		else
+		} else {
 			dev_dbg(port->dev, "%s: mapped %d@%p to %pad\n",
 				__func__,
 				sg_dma_len(&s->sg_tx), port->state->xmit.buf,
 				&sg_dma_address(&s->sg_tx));
+		}
 
 		s->sg_len_tx = nent;
 
@@ -1737,7 +1742,7 @@ static void sci_request_dma(struct uart_port *port)
 
 		if (!buf[0]) {
 			dev_warn(port->dev,
-				 "failed to allocate dma buffer, using PIO\n");
+				 "Failed to allocate Rx dma buffer, using PIO\n");
 			sci_rx_dma_release(s, true);
 			return;
 		}
-- 
1.9.1

