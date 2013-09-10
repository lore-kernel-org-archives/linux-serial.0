From: Johan Hovold <jhovold-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 1/4] serial: tegra: fix tty-kref leak
Date: Tue, 10 Sep 2013 12:50:48 +0200
Message-ID: <1378810251-28499-2-git-send-email-jhovold@gmail.com>
References: <1378810251-28499-1-git-send-email-jhovold@gmail.com>
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1378810251-28499-1-git-send-email-jhovold-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>
Cc: Jiri Slaby <jslaby-AlSwsSmVLrQ@public.gmane.org>, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Johan Hovold <jhovold-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, stable-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-serial@vger.kernel.org

Fix potential tty-kref leak in stop_rx path.

Cc: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Cc: stable-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Signed-off-by: Johan Hovold <jhovold-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
 drivers/tty/serial/serial-tegra.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/serial-tegra.c b/drivers/tty/serial/serial-tegra.c
index d0d972f..0489a2b 100644
--- a/drivers/tty/serial/serial-tegra.c
+++ b/drivers/tty/serial/serial-tegra.c
@@ -732,7 +732,7 @@ static irqreturn_t tegra_uart_isr(int irq, void *data)
 static void tegra_uart_stop_rx(struct uart_port *u)
 {
 	struct tegra_uart_port *tup = to_tegra_uport(u);
-	struct tty_struct *tty = tty_port_tty_get(&tup->uport.state->port);
+	struct tty_struct *tty;
 	struct tty_port *port = &u->state->port;
 	struct dma_tx_state state;
 	unsigned long ier;
@@ -744,6 +744,8 @@ static void tegra_uart_stop_rx(struct uart_port *u)
 	if (!tup->rx_in_progress)
 		return;
 
+	tty = tty_port_tty_get(&tup->uport.state->port);
+
 	tegra_uart_wait_sym_time(tup, 1); /* wait a character interval */
 
 	ier = tup->ier_shadow;
-- 
1.8.3.2
