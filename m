From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH v3 33/33] serial: sh-sci: Don't call sci_dma_rx_push() if no data has arrived
Date: Fri, 21 Aug 2015 20:02:57 +0200
Message-ID: <1440180177-6924-34-git-send-email-geert+renesas@glider.be>
References: <1440180177-6924-1-git-send-email-geert+renesas@glider.be>
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <1440180177-6924-1-git-send-email-geert+renesas@glider.be>
Sender: linux-sh-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>
Cc: Magnus Damm <magnus.damm@gmail.com>, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, Yoshihiro Kaneko <ykaneko0929@gmail.com>, Kazuya Mizuguchi <kazuya.mizuguchi.ks@renesas.com>, Koji Matsuoka <koji.matsuoka.xm@renesas.com>, Wolfram Sang <wsa@the-dreams.de>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>, linux-serial@vger.kernel.org, linux-sh@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>
List-Id: linux-serial@vger.kernel.org

On receive DMA time-out, avoid calling sci_dma_rx_push() if no data was
transferred by the timed out DMA request.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
v3:
  - New.
---
 drivers/tty/serial/sh-sci.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
index ffcbf6eaf5f98723..d8b73e791a554823 100644
--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -1467,10 +1467,11 @@ static void work_fn_rx(struct work_struct *work)
 		dev_dbg(port->dev, "Read %u bytes with cookie %d\n", read,
 			s->active_rx);
 
-		count = sci_dma_rx_push(s, s->rx_buf[new], read);
-
-		if (count)
-			tty_flip_buffer_push(&port->state->port);
+		if (read) {
+			count = sci_dma_rx_push(s, s->rx_buf[new], read);
+			if (count)
+				tty_flip_buffer_push(&port->state->port);
+		}
 
 		spin_unlock_irqrestore(&port->lock, flags);
 
-- 
1.9.1

