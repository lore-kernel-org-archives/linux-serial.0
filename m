From: Johan Hovold <jhovold-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 4/4] serial: pch_uart: remove unnecessary tty_port_tty_get
Date: Tue, 10 Sep 2013 12:50:51 +0200
Message-ID: <1378810251-28499-5-git-send-email-jhovold@gmail.com>
References: <1378810251-28499-1-git-send-email-jhovold@gmail.com>
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1378810251-28499-1-git-send-email-jhovold-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>
Cc: Jiri Slaby <jslaby-AlSwsSmVLrQ@public.gmane.org>, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Johan Hovold <jhovold-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-serial@vger.kernel.org

Remove unused tty-reference from dma-rx path which was left after the
recent tty-port conversions.

Also remove a redundant port initialisation while at it.

Signed-off-by: Johan Hovold <jhovold-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
 drivers/tty/serial/pch_uart.c | 12 +-----------
 1 file changed, 1 insertion(+), 11 deletions(-)

diff --git a/drivers/tty/serial/pch_uart.c b/drivers/tty/serial/pch_uart.c
index 2c5a3e4..44077c0 100644
--- a/drivers/tty/serial/pch_uart.c
+++ b/drivers/tty/serial/pch_uart.c
@@ -667,31 +667,21 @@ static int pop_tx_x(struct eg20t_port *priv, unsigned char *buf)
 
 static int dma_push_rx(struct eg20t_port *priv, int size)
 {
-	struct tty_struct *tty;
 	int room;
 	struct uart_port *port = &priv->port;
 	struct tty_port *tport = &port->state->port;
 
-	port = &priv->port;
-	tty = tty_port_tty_get(tport);
-	if (!tty) {
-		dev_dbg(priv->port.dev, "%s:tty is busy now", __func__);
-		return 0;
-	}
-
 	room = tty_buffer_request_room(tport, size);
 
 	if (room < size)
 		dev_warn(port->dev, "Rx overrun: dropping %u bytes\n",
 			 size - room);
 	if (!room)
-		goto out;
+		return 0;
 
 	tty_insert_flip_string(tport, sg_virt(&priv->sg_rx), size);
 
 	port->icount.rx += room;
-out:
-	tty_kref_put(tty);
 
 	return room;
 }
-- 
1.8.3.2
