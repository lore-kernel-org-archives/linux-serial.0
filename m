From: Marcel Ziswiler <marcel@ziswiler.com>
Subject: [PATCH v1 3/3] serial: tegra: fix some spelling mistakes
Date: Thu,  1 Nov 2018 02:52:30 +0100
Message-ID: <20181101015230.27310-4-marcel@ziswiler.com>
References: <20181101015230.27310-1-marcel@ziswiler.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181101015230.27310-1-marcel@ziswiler.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Marcel Ziswiler <marcel.ziswiler@toradex.com>, Thierry Reding <thierry.reding@gmail.com>, Jiri Slaby <jslaby@suse.com>, Jonathan Hunter <jonathanh@nvidia.com>, linux-serial@vger.kernel.org, Laxman Dewangan <ldewangan@nvidia.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
List-Id: linux-serial@vger.kernel.org

From: Marcel Ziswiler <marcel.ziswiler@toradex.com>

Fix a few spelling mistakes I stumbled upon while debugging a customers
UART issues.

Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>

---

 drivers/tty/serial/serial-tegra.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/tty/serial/serial-tegra.c b/drivers/tty/serial/serial-tegra.c
index af2a29cfbbe9..d5269aaaf9b2 100644
--- a/drivers/tty/serial/serial-tegra.c
+++ b/drivers/tty/serial/serial-tegra.c
@@ -746,7 +746,7 @@ static void tegra_uart_stop_rx(struct uart_port *u)
 	if (!tup->rx_in_progress)
 		return;
 
-	tegra_uart_wait_sym_time(tup, 1); /* wait a character interval */
+	tegra_uart_wait_sym_time(tup, 1); /* wait one character interval */
 
 	ier = tup->ier_shadow;
 	ier &= ~(UART_IER_RDI | UART_IER_RLSI | UART_IER_RTOIE |
@@ -887,7 +887,7 @@ static int tegra_uart_hw_init(struct tegra_uart_port *tup)
 	 *
 	 * EORD is different interrupt than RX_TIMEOUT - RX_TIMEOUT occurs when
 	 * the DATA is sitting in the FIFO and couldn't be transferred to the
-	 * DMA as the DMA size alignment(4 bytes) is not met. EORD will be
+	 * DMA as the DMA size alignment (4 bytes) is not met. EORD will be
 	 * triggered when there is a pause of the incomming data stream for 4
 	 * characters long.
 	 *
@@ -1079,7 +1079,7 @@ static void tegra_uart_set_termios(struct uart_port *u,
 	if (tup->rts_active)
 		set_rts(tup, false);
 
-	/* Clear all interrupts as configuration is going to be change */
+	/* Clear all interrupts as configuration is going to be changed */
 	tegra_uart_write(tup, tup->ier_shadow | UART_IER_RDI, UART_IER);
 	tegra_uart_read(tup, UART_IER);
 	tegra_uart_write(tup, 0, UART_IER);
@@ -1165,10 +1165,10 @@ static void tegra_uart_set_termios(struct uart_port *u,
 	/* update the port timeout based on new settings */
 	uart_update_timeout(u, termios->c_cflag, baud);
 
-	/* Make sure all write has completed */
+	/* Make sure all writes have completed */
 	tegra_uart_read(tup, UART_IER);
 
-	/* Reenable interrupt */
+	/* Re-enable interrupt */
 	tegra_uart_write(tup, tup->ier_shadow, UART_IER);
 	tegra_uart_read(tup, UART_IER);
 
-- 
2.14.5
