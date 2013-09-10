From: Johan Hovold <jhovold@gmail.com>
Subject: [PATCH 3/4] serial: pch_uart: fix tty-kref leak in dma-rx path
Date: Tue, 10 Sep 2013 12:50:50 +0200
Message-ID: <1378810251-28499-4-git-send-email-jhovold@gmail.com>
References: <1378810251-28499-1-git-send-email-jhovold@gmail.com>
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <1378810251-28499-1-git-send-email-jhovold@gmail.com>
Sender: stable-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jslaby@suse.cz>, Stephen Warren <swarren@wwwdotorg.org>, linux-serial@vger.kernel.org, linux-tegra@vger.kernel.org, Johan Hovold <jhovold@gmail.com>, stable@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

Fix tty_kref leak when tty_buffer_request room fails in dma-rx path.

Note that the tty ref isn't really needed anymore, but as the leak has
always been there, fixing it before removing should makes it easier to
backport the fix.

Cc: stable@vger.kernel.org
Signed-off-by: Johan Hovold <jhovold@gmail.com>
---
 drivers/tty/serial/pch_uart.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/pch_uart.c b/drivers/tty/serial/pch_uart.c
index f0161d6..2c5a3e4 100644
--- a/drivers/tty/serial/pch_uart.c
+++ b/drivers/tty/serial/pch_uart.c
@@ -685,11 +685,12 @@ static int dma_push_rx(struct eg20t_port *priv, int size)
 		dev_warn(port->dev, "Rx overrun: dropping %u bytes\n",
 			 size - room);
 	if (!room)
-		return room;
+		goto out;
 
 	tty_insert_flip_string(tport, sg_virt(&priv->sg_rx), size);
 
 	port->icount.rx += room;
+out:
 	tty_kref_put(tty);
 
 	return room;
-- 
1.8.3.2
