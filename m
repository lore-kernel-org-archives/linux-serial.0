From: Thierry Reding <thierry.reding-RM9K5IK7kjKj5M59NBduVrNAH6kLmebB@public.gmane.org>
Subject: [PATCH] serial: tegra: Switch to using struct tty_port
Date: Thu, 17 Jan 2013 14:31:45 +0100
Message-ID: <1358429505-31746-1-git-send-email-thierry.reding@avionic-design.de>
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Alan Cox <alan-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Cc: Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Jiri Slaby <jslaby-AlSwsSmVLrQ@public.gmane.org>, Stephen Warren <swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Laxman Dewangan <ldewangan-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-serial@vger.kernel.org

Many of the tty functions were converted to use a struct tty_port
instead of a struct tty_struct. Update the Tegra driver accordingly to
avoid build breakage.

Signed-off-by: Thierry Reding <thierry.reding-RM9K5IK7kjKj5M59NBduVrNAH6kLmebB@public.gmane.org>
---
 drivers/tty/serial/serial-tegra.c | 27 +++++++++++++++------------
 1 file changed, 15 insertions(+), 12 deletions(-)

diff --git a/drivers/tty/serial/serial-tegra.c b/drivers/tty/serial/serial-tegra.c
index cc4072f..30d6ff6 100644
--- a/drivers/tty/serial/serial-tegra.c
+++ b/drivers/tty/serial/serial-tegra.c
@@ -504,7 +504,7 @@ static void tegra_uart_handle_tx_pio(struct tegra_uart_port *tup)
 }
 
 static void tegra_uart_handle_rx_pio(struct tegra_uart_port *tup,
-		struct tty_struct *tty)
+		struct tty_port *tty)
 {
 	do {
 		char flag = TTY_NORMAL;
@@ -527,7 +527,7 @@ static void tegra_uart_handle_rx_pio(struct tegra_uart_port *tup,
 }
 
 static void tegra_uart_copy_rx_to_tty(struct tegra_uart_port *tup,
-		struct tty_struct *tty, int count)
+		struct tty_port *tty, int count)
 {
 	int copied;
 
@@ -554,6 +554,7 @@ static void tegra_uart_rx_dma_complete(void *args)
 	struct uart_port *u = &tup->uport;
 	int count = tup->rx_bytes_requested;
 	struct tty_struct *tty = tty_port_tty_get(&tup->uport.state->port);
+	struct tty_port *port = &u->state->port;
 	unsigned long flags;
 
 	async_tx_ack(tup->rx_dma_desc);
@@ -565,11 +566,11 @@ static void tegra_uart_rx_dma_complete(void *args)
 
 	/* If we are here, DMA is stopped */
 	if (count)
-		tegra_uart_copy_rx_to_tty(tup, tty, count);
+		tegra_uart_copy_rx_to_tty(tup, port, count);
 
-	tegra_uart_handle_rx_pio(tup, tty);
+	tegra_uart_handle_rx_pio(tup, port);
 	if (tty) {
-		tty_flip_buffer_push(tty);
+		tty_flip_buffer_push(port);
 		tty_kref_put(tty);
 	}
 	tegra_uart_start_rx_dma(tup);
@@ -585,6 +586,7 @@ static void tegra_uart_handle_rx_dma(struct tegra_uart_port *tup)
 {
 	struct dma_tx_state state;
 	struct tty_struct *tty = tty_port_tty_get(&tup->uport.state->port);
+	struct tty_port *port = &tup->uport.state->port;
 	int count;
 
 	/* Deactivate flow control to stop sender */
@@ -597,11 +599,11 @@ static void tegra_uart_handle_rx_dma(struct tegra_uart_port *tup)
 
 	/* If we are here, DMA is stopped */
 	if (count)
-		tegra_uart_copy_rx_to_tty(tup, tty, count);
+		tegra_uart_copy_rx_to_tty(tup, port, count);
 
-	tegra_uart_handle_rx_pio(tup, tty);
+	tegra_uart_handle_rx_pio(tup, port);
 	if (tty) {
-		tty_flip_buffer_push(tty);
+		tty_flip_buffer_push(port);
 		tty_kref_put(tty);
 	}
 	tegra_uart_start_rx_dma(tup);
@@ -724,6 +726,7 @@ static void tegra_uart_stop_rx(struct uart_port *u)
 {
 	struct tegra_uart_port *tup = to_tegra_uport(u);
 	struct tty_struct *tty = tty_port_tty_get(&tup->uport.state->port);
+	struct tty_port *port = &u->state->port;
 	struct dma_tx_state state;
 	unsigned long ier;
 	int count;
@@ -747,13 +750,13 @@ static void tegra_uart_stop_rx(struct uart_port *u)
 		dmaengine_tx_status(tup->rx_dma_chan, tup->rx_cookie, &state);
 		async_tx_ack(tup->rx_dma_desc);
 		count = tup->rx_bytes_requested - state.residue;
-		tegra_uart_copy_rx_to_tty(tup, tty, count);
-		tegra_uart_handle_rx_pio(tup, tty);
+		tegra_uart_copy_rx_to_tty(tup, port, count);
+		tegra_uart_handle_rx_pio(tup, port);
 	} else {
-		tegra_uart_handle_rx_pio(tup, tty);
+		tegra_uart_handle_rx_pio(tup, port);
 	}
 	if (tty) {
-		tty_flip_buffer_push(tty);
+		tty_flip_buffer_push(port);
 		tty_kref_put(tty);
 	}
 	return;
-- 
1.8.1.1
