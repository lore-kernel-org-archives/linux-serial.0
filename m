From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH v4 08/10] serial: sh-sci: Do not terminate DMA engine when race condition occurs
Date: Fri, 18 Sep 2015 13:08:31 +0200
Message-ID: <1442574513-20648-9-git-send-email-geert+renesas@glider.be>
References: <1442574513-20648-1-git-send-email-geert+renesas@glider.be>
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <1442574513-20648-1-git-send-email-geert+renesas@glider.be>
Sender: linux-sh-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>
Cc: Muhammad Hamza Farooq <mfarooq@visteon.com>, Magnus Damm <magnus.damm@gmail.com>, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, Yoshihiro Kaneko <ykaneko0929@gmail.com>, Kazuya Mizuguchi <kazuya.mizuguchi.ks@renesas.com>, Koji Matsuoka <koji.matsuoka.xm@renesas.com>, Wolfram Sang <wsa@the-dreams.de>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>, linux-serial@vger.kernel.org, linux-sh@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>
List-Id: linux-serial@vger.kernel.org

From: Muhammad Hamza Farooq <mfarooq@visteon.com>

When DMA packet completion and timer expiry take place at the same time,
do not terminate the DMA engine, leading by submission of new
descriptors, as the DMA communication hasn't necessarily stopped here.

Signed-off-by: Muhammad Hamza Farooq <mfarooq@visteon.com>
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
v4:
  - New.
---
 drivers/tty/serial/sh-sci.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
index 84c15152e111b084..9406fe227bc76c96 100644
--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -1296,9 +1296,14 @@ static void rx_timer_fn(unsigned long arg)
 	}
 
 	status = dmaengine_tx_status(s->chan_rx, s->active_rx, &state);
-	if (status == DMA_COMPLETE)
+	if (status == DMA_COMPLETE) {
 		dev_dbg(port->dev, "Cookie %d #%d has already completed\n",
 			s->active_rx, active);
+		spin_unlock_irqrestore(&port->lock, flags);
+
+		/* Let packet complete handler take care of the packet */
+		return;
+	}
 
 	/* Handle incomplete DMA receive */
 	dmaengine_terminate_all(s->chan_rx);
-- 
1.9.1

