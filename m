From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH v4 09/10] serial: sh-sci: Pause DMA engine and get DMA status again
Date: Fri, 18 Sep 2015 13:08:32 +0200
Message-ID: <1442574513-20648-10-git-send-email-geert+renesas@glider.be>
References: <1442574513-20648-1-git-send-email-geert+renesas@glider.be>
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <1442574513-20648-1-git-send-email-geert+renesas@glider.be>
Sender: linux-sh-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>
Cc: Muhammad Hamza Farooq <mfarooq@visteon.com>, Magnus Damm <magnus.damm@gmail.com>, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, Yoshihiro Kaneko <ykaneko0929@gmail.com>, Kazuya Mizuguchi <kazuya.mizuguchi.ks@renesas.com>, Koji Matsuoka <koji.matsuoka.xm@renesas.com>, Wolfram Sang <wsa@the-dreams.de>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>, linux-serial@vger.kernel.org, linux-sh@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>
List-Id: linux-serial@vger.kernel.org

From: Muhammad Hamza Farooq <mfarooq@visteon.com>

Occasionally, DMA transaction completes _after_ DMA engine is stopped.
Verify if the transaction has not finished before forcing the engine to
stop and push the data

Signed-off-by: Muhammad Hamza Farooq <mfarooq@visteon.com>
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
v4:
  - New.
---
 drivers/tty/serial/sh-sci.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
index 9406fe227bc76c96..b1d1ce1986e6c064 100644
--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -1277,6 +1277,7 @@ static bool filter(struct dma_chan *chan, void *slave)
 static void rx_timer_fn(unsigned long arg)
 {
 	struct sci_port *s = (struct sci_port *)arg;
+	struct dma_chan *chan = s->chan_rx;
 	struct uart_port *port = &s->port;
 	struct dma_tx_state state;
 	enum dma_status status;
@@ -1305,6 +1306,21 @@ static void rx_timer_fn(unsigned long arg)
 		return;
 	}
 
+	dmaengine_pause(chan);
+
+	/*
+	 * sometimes DMA transfer doesn't stop even if it is stopped and
+	 * data keeps on coming until transaction is complete so check
+	 * for DMA_COMPLETE again
+	 * Let packet complete handler take care of the packet
+	 */
+	status = dmaengine_tx_status(s->chan_rx, s->active_rx, &state);
+	if (status == DMA_COMPLETE) {
+		spin_unlock_irqrestore(&port->lock, flags);
+		dev_dbg(port->dev, "Transaction complete after DMA engine was stopped");
+		return;
+	}
+
 	/* Handle incomplete DMA receive */
 	dmaengine_terminate_all(s->chan_rx);
 	read = sg_dma_len(&s->sg_rx[active]) - state.residue;
-- 
1.9.1

