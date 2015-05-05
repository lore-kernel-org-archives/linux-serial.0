From: Jon Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH 5/8] serial: tegra: Use unsigned types for RX and TX byte counts
Date: Tue, 5 May 2015 15:17:56 +0100
Message-ID: <1430835479-6613-6-git-send-email-jonathanh@nvidia.com>
References: <1430835479-6613-1-git-send-email-jonathanh@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1430835479-6613-1-git-send-email-jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Laxman Dewangan <ldewangan-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Jiri Slaby <jslaby-AlSwsSmVLrQ@public.gmane.org>
Cc: linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Jon Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
List-Id: linux-serial@vger.kernel.org

The function tty_insert_flip_string() takes an argument "size" which is
of type size_t. This is an unsigned type. Update the count,
rx_bytes_requested and tx_bytes_requested in the tegra serial driver to
be unsigned integers so that an unsigned type is passed to
tty_insert_flip_string().

Signed-off-by: Jon Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
---
 drivers/tty/serial/serial-tegra.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/drivers/tty/serial/serial-tegra.c b/drivers/tty/serial/serial-tegra.c
index 17d8a08b047b..a5312e4b6393 100644
--- a/drivers/tty/serial/serial-tegra.c
+++ b/drivers/tty/serial/serial-tegra.c
@@ -131,8 +131,8 @@ struct tegra_uart_port {
 	struct dma_async_tx_descriptor		*rx_dma_desc;
 	dma_cookie_t				tx_cookie;
 	dma_cookie_t				rx_cookie;
-	int					tx_bytes_requested;
-	int					rx_bytes_requested;
+	unsigned int				tx_bytes_requested;
+	unsigned int				rx_bytes_requested;
 };
 
 static void tegra_uart_start_next_tx(struct tegra_uart_port *tup);
@@ -408,7 +408,7 @@ static void tegra_uart_tx_dma_complete(void *args)
 	struct circ_buf *xmit = &tup->uport.state->xmit;
 	struct dma_tx_state state;
 	unsigned long flags;
-	int count;
+	unsigned int count;
 
 	dmaengine_tx_status(tup->tx_dma_chan, tup->rx_cookie, &state);
 	count = tup->tx_bytes_requested - state.residue;
@@ -500,7 +500,7 @@ static void tegra_uart_stop_tx(struct uart_port *u)
 	struct tegra_uart_port *tup = to_tegra_uport(u);
 	struct circ_buf *xmit = &tup->uport.state->xmit;
 	struct dma_tx_state state;
-	int count;
+	unsigned int count;
 
 	if (tup->tx_in_progress != TEGRA_UART_TX_DMA)
 		return;
@@ -550,7 +550,8 @@ static void tegra_uart_handle_rx_pio(struct tegra_uart_port *tup,
 }
 
 static void tegra_uart_copy_rx_to_tty(struct tegra_uart_port *tup,
-		struct tty_port *tty, int count)
+				      struct tty_port *tty,
+				      unsigned int count)
 {
 	int copied;
 
@@ -579,7 +580,7 @@ static void tegra_uart_rx_dma_complete(void *args)
 {
 	struct tegra_uart_port *tup = args;
 	struct uart_port *u = &tup->uport;
-	int count = tup->rx_bytes_requested;
+	unsigned int count = tup->rx_bytes_requested;
 	struct tty_struct *tty = tty_port_tty_get(&tup->uport.state->port);
 	struct tty_port *port = &u->state->port;
 	unsigned long flags;
@@ -628,7 +629,7 @@ static void tegra_uart_handle_rx_dma(struct tegra_uart_port *tup,
 	struct tty_struct *tty = tty_port_tty_get(&tup->uport.state->port);
 	struct tty_port *port = &tup->uport.state->port;
 	struct uart_port *u = &tup->uport;
-	int count;
+	unsigned int count;
 
 	/* Deactivate flow control to stop sender */
 	if (tup->rts_active)
-- 
1.9.1
