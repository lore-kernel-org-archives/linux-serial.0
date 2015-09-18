From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH v4 05/10] serial: sh-sci: Remove timer on shutdown of port
Date: Fri, 18 Sep 2015 13:08:28 +0200
Message-ID: <1442574513-20648-6-git-send-email-geert+renesas@glider.be>
References: <1442574513-20648-1-git-send-email-geert+renesas@glider.be>
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <1442574513-20648-1-git-send-email-geert+renesas@glider.be>
Sender: linux-sh-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>
Cc: Muhammad Hamza Farooq <mfarooq@visteon.com>, Magnus Damm <magnus.damm@gmail.com>, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, Yoshihiro Kaneko <ykaneko0929@gmail.com>, Kazuya Mizuguchi <kazuya.mizuguchi.ks@renesas.com>, Koji Matsuoka <koji.matsuoka.xm@renesas.com>, Wolfram Sang <wsa@the-dreams.de>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>, linux-serial@vger.kernel.org, linux-sh@vger.kernel.org, Aleksandar Mitev <amitev@visteon.com>, Geert Uytterhoeven <geert+renesas@glider.be>
List-Id: linux-serial@vger.kernel.org

From: Aleksandar Mitev <amitev@visteon.com>

This prevents DMA timer timeout that can trigger after the port has
been closed.

Signed-off-by: Aleksandar Mitev <amitev@visteon.com>
[geert: Move del_timer_sync() outside spinlock to avoid circular locking
        dependency between rx_timer_fn() and del_timer_sync()]
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
v4:
  - New.
---
 drivers/tty/serial/sh-sci.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
index ac9ce8f1ff799a48..36a11110acf4cab5 100644
--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -1810,6 +1810,14 @@ static void sci_shutdown(struct uart_port *port)
 	sci_stop_tx(port);
 	spin_unlock_irqrestore(&port->lock, flags);
 
+#ifdef CONFIG_SERIAL_SH_SCI_DMA
+	if (s->chan_rx) {
+		dev_dbg(port->dev, "%s(%d) deleting rx_timer\n", __func__,
+			port->line);
+		del_timer_sync(&s->rx_timer);
+	}
+#endif
+
 	sci_free_dma(port);
 	sci_free_irq(s);
 }
-- 
1.9.1

