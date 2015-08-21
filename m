From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH v3 28/33] serial: sh-sci: Use tty_insert_flip_string() for DMA receive
Date: Fri, 21 Aug 2015 20:02:52 +0200
Message-ID: <1440180177-6924-29-git-send-email-geert+renesas@glider.be>
References: <1440180177-6924-1-git-send-email-geert+renesas@glider.be>
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <1440180177-6924-1-git-send-email-geert+renesas@glider.be>
Sender: linux-sh-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>
Cc: Magnus Damm <magnus.damm@gmail.com>, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, Yoshihiro Kaneko <ykaneko0929@gmail.com>, Kazuya Mizuguchi <kazuya.mizuguchi.ks@renesas.com>, Koji Matsuoka <koji.matsuoka.xm@renesas.com>, Wolfram Sang <wsa@the-dreams.de>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>, linux-serial@vger.kernel.org, linux-sh@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>
List-Id: linux-serial@vger.kernel.org

Switch from using tty_buffer_request_room() and looping over
tty_insert_flip_char() to tty_insert_flip_string().
Keep track of buffer overruns in the icount structure, like
serial_core.c does.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
v3:
  - New.
---
 drivers/tty/serial/sh-sci.c | 20 ++++++++------------
 1 file changed, 8 insertions(+), 12 deletions(-)

diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
index 2b44004e5115fa59..57b1cc1da67d228a 100644
--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -1306,22 +1306,18 @@ static int sci_dma_rx_push(struct sci_port *s, struct scatterlist *sg,
 {
 	struct uart_port *port = &s->port;
 	struct tty_port *tport = &port->state->port;
-	int i, room;
+	int copied;
 
-	room = tty_buffer_request_room(tport, count);
-
-	if (room < count)
+	copied = tty_insert_flip_string(tport, sg_virt(sg), count);
+	if (copied < count) {
 		dev_warn(port->dev, "Rx overrun: dropping %zu bytes\n",
-			 count - room);
-	if (!room)
-		return room;
-
-	for (i = 0; i < room; i++)
-		tty_insert_flip_char(tport, ((u8 *)sg_virt(sg))[i], TTY_NORMAL);
+			 count - copied);
+		port->icount.buf_overrun++;
+	}
 
-	port->icount.rx += room;
+	port->icount.rx += copied;
 
-	return room;
+	return copied;
 }
 
 static int sci_dma_rx_find_active(struct sci_port *s)
-- 
1.9.1

