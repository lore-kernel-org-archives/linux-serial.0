From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH v3 27/33] serial: sh-sci: Pass scatterlist to sci_dma_rx_push()
Date: Fri, 21 Aug 2015 20:02:51 +0200
Message-ID: <1440180177-6924-28-git-send-email-geert+renesas@glider.be>
References: <1440180177-6924-1-git-send-email-geert+renesas@glider.be>
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <1440180177-6924-1-git-send-email-geert+renesas@glider.be>
Sender: linux-sh-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>
Cc: Magnus Damm <magnus.damm@gmail.com>, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, Yoshihiro Kaneko <ykaneko0929@gmail.com>, Kazuya Mizuguchi <kazuya.mizuguchi.ks@renesas.com>, Koji Matsuoka <koji.matsuoka.xm@renesas.com>, Wolfram Sang <wsa@the-dreams.de>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>, linux-serial@vger.kernel.org, linux-sh@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>
List-Id: linux-serial@vger.kernel.org

Currently sci_dma_rx_push() has to find the active scatterlist itself,
but in some cases the caller already knows.

Hence let the caller pass the scatterlist, and introduce a helper to
find the active DMA request while we're at it.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
v3:
  - Use "cookie %d" for DMA cookies,

v2:
  - New.
---
 drivers/tty/serial/sh-sci.c | 48 ++++++++++++++++++++++-----------------------
 1 file changed, 24 insertions(+), 24 deletions(-)

diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
index 35e24b726fe605d1..2b44004e5115fa59 100644
--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -1301,24 +1301,15 @@ static void sci_dma_tx_complete(void *arg)
 }
 
 /* Locking: called with port lock held */
-static int sci_dma_rx_push(struct sci_port *s, size_t count)
+static int sci_dma_rx_push(struct sci_port *s, struct scatterlist *sg,
+			   size_t count)
 {
 	struct uart_port *port = &s->port;
 	struct tty_port *tport = &port->state->port;
-	int i, active, room;
+	int i, room;
 
 	room = tty_buffer_request_room(tport, count);
 
-	if (s->active_rx == s->cookie_rx[0]) {
-		active = 0;
-	} else if (s->active_rx == s->cookie_rx[1]) {
-		active = 1;
-	} else {
-		dev_err(port->dev, "%s: Rx cookie %d not found!\n", __func__,
-			s->active_rx);
-		return 0;
-	}
-
 	if (room < count)
 		dev_warn(port->dev, "Rx overrun: dropping %zu bytes\n",
 			 count - room);
@@ -1326,27 +1317,41 @@ static int sci_dma_rx_push(struct sci_port *s, size_t count)
 		return room;
 
 	for (i = 0; i < room; i++)
-		tty_insert_flip_char(tport, ((u8 *)sg_virt(&s->sg_rx[active]))[i],
-				     TTY_NORMAL);
+		tty_insert_flip_char(tport, ((u8 *)sg_virt(sg))[i], TTY_NORMAL);
 
 	port->icount.rx += room;
 
 	return room;
 }
 
+static int sci_dma_rx_find_active(struct sci_port *s)
+{
+	unsigned int i;
+
+	for (i = 0; i < ARRAY_SIZE(s->cookie_rx); i++)
+		if (s->active_rx == s->cookie_rx[i])
+			return i;
+
+	dev_err(s->port.dev, "%s: Rx cookie %d not found!\n", __func__,
+		s->active_rx);
+	return -1;
+}
+
 static void sci_dma_rx_complete(void *arg)
 {
 	struct sci_port *s = arg;
 	struct uart_port *port = &s->port;
 	unsigned long flags;
-	int count;
+	int active, count = 0;
 
 	dev_dbg(port->dev, "%s(%d) active cookie %d\n", __func__, port->line,
 		s->active_rx);
 
 	spin_lock_irqsave(&port->lock, flags);
 
-	count = sci_dma_rx_push(s, s->buf_len_rx);
+	active = sci_dma_rx_find_active(s);
+	if (active >= 0)
+		count = sci_dma_rx_push(s, &s->sg_rx[active], s->buf_len_rx);
 
 	mod_timer(&s->rx_timer, jiffies + s->rx_timeout);
 
@@ -1445,13 +1450,8 @@ static void work_fn_rx(struct work_struct *work)
 	int new;
 
 	spin_lock_irqsave(&port->lock, flags);
-	if (s->active_rx == s->cookie_rx[0]) {
-		new = 0;
-	} else if (s->active_rx == s->cookie_rx[1]) {
-		new = 1;
-	} else {
-		dev_err(port->dev, "%s: Rx cookie %d not found!\n", __func__,
-			s->active_rx);
+	new = sci_dma_rx_find_active(s);
+	if (new < 0) {
 		spin_unlock_irqrestore(&port->lock, flags);
 		return;
 	}
@@ -1468,7 +1468,7 @@ static void work_fn_rx(struct work_struct *work)
 		dev_dbg(port->dev, "Read %u bytes with cookie %d\n", read,
 			s->active_rx);
 
-		count = sci_dma_rx_push(s, read);
+		count = sci_dma_rx_push(s, &s->sg_rx[new], read);
 
 		if (count)
 			tty_flip_buffer_push(&port->state->port);
-- 
1.9.1

