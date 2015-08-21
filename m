From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH v3 22/33] serial: sh-sci: Stop acknowledging DMA transmit completions
Date: Fri, 21 Aug 2015 20:02:46 +0200
Message-ID: <1440180177-6924-23-git-send-email-geert+renesas@glider.be>
References: <1440180177-6924-1-git-send-email-geert+renesas@glider.be>
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <1440180177-6924-1-git-send-email-geert+renesas@glider.be>
Sender: linux-sh-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>
Cc: Magnus Damm <magnus.damm@gmail.com>, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, Yoshihiro Kaneko <ykaneko0929@gmail.com>, Kazuya Mizuguchi <kazuya.mizuguchi.ks@renesas.com>, Koji Matsuoka <koji.matsuoka.xm@renesas.com>, Wolfram Sang <wsa@the-dreams.de>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>, linux-serial@vger.kernel.org, linux-sh@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>
List-Id: linux-serial@vger.kernel.org

As dmaengine_prep_slave_sg() is called with the DMA_CTRL_ACK flag set
for DMA transmit requests, there's no need to explicitly acknowledge DMA
transmit requests in the DMA transmit completion callback.

Hence remove the call to async_tx_ack(), and remove the now unused
dma_async_tx_descriptor pointer in the sci_port structure.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
v3:
  - No changes,

v2:
  - New.
---
 drivers/tty/serial/sh-sci.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
index 049036dfb6ddf32c..1191a6c486640983 100644
--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -104,7 +104,6 @@ struct sci_port {
 	struct dma_chan			*chan_rx;
 
 #ifdef CONFIG_SERIAL_SH_SCI_DMA
-	struct dma_async_tx_descriptor	*desc_tx;
 	struct dma_async_tx_descriptor	*desc_rx[2];
 	dma_cookie_t			cookie_tx;
 	dma_cookie_t			cookie_rx[2];
@@ -1285,9 +1284,6 @@ static void sci_dma_tx_complete(void *arg)
 
 	port->icount.tx += s->tx_dma_len;
 
-	async_tx_ack(s->desc_tx);
-	s->desc_tx = NULL;
-
 	if (uart_circ_chars_pending(xmit) < WAKEUP_CHARS)
 		uart_write_wakeup(port);
 
@@ -1528,7 +1524,6 @@ static void work_fn_tx(struct work_struct *work)
 				   DMA_TO_DEVICE);
 
 	spin_lock_irq(&port->lock);
-	s->desc_tx = desc;
 	desc->callback = sci_dma_tx_complete;
 	desc->callback_param = s;
 	spin_unlock_irq(&port->lock);
-- 
1.9.1

