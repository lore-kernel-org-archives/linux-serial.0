From: Peter Senna Tschudin <peter.senna@collabora.com>
Subject: [PATCH] imx-serial: RX DMA startup latency
Date: Sun, 14 May 2017 14:35:15 +0200
Message-ID: <20170514123515.15794-1-peter.senna@collabora.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Cc: Peter Senna Tschudin <peter.senna@collabora.com>, Sascha Hauer <s.hauer@pengutronix.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

18a4208 introduced a change to reduce the RX DMA latency on the first reception
when the serial port was opened for reading. However it was claiming a hardirq
unsafe lock after a hardirq safe lock which is not allowed and causes lockdep
to complain verbosely.

This patch changes the code to always start RX DMA earlier, instead of
relying on the flags used to open the serial port removing the code that
was looking for the serial file flags.

CC: Sascha Hauer <s.hauer@pengutronix.de>
Signed-off-by: Peter Senna Tschudin <peter.senna@collabora.com>
---
Tested on iMX53.

 drivers/tty/serial/imx.c | 26 +++++---------------------
 1 file changed, 5 insertions(+), 21 deletions(-)

diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
index 33509b4..64e16b3 100644
--- a/drivers/tty/serial/imx.c
+++ b/drivers/tty/serial/imx.c
@@ -1340,29 +1340,13 @@ static int imx_startup(struct uart_port *port)
 	imx_enable_ms(&sport->port);
 
 	/*
-	 * If the serial port is opened for reading start RX DMA immediately
-	 * instead of waiting for RX FIFO interrupts. In our iMX53 the average
-	 * delay for the first reception dropped from approximately 35000
-	 * microseconds to 1000 microseconds.
+	 * Start RX DMA immediately instead of waiting for RX FIFO interrupts.
+	 * In our iMX53 the average delay for the first reception dropped from
+	 * approximately 35000 microseconds to 1000 microseconds.
 	 */
 	if (sport->dma_is_enabled) {
-		struct tty_struct *tty = sport->port.state->port.tty;
-		struct tty_file_private *file_priv;
-		int readcnt = 0;
-
-		spin_lock(&tty->files_lock);
-
-		if (!list_empty(&tty->tty_files))
-			list_for_each_entry(file_priv, &tty->tty_files, list)
-				if (!(file_priv->file->f_flags & O_WRONLY))
-					readcnt++;
-
-		spin_unlock(&tty->files_lock);
-
-		if (readcnt > 0) {
-			imx_disable_rx_int(sport);
-			start_rx_dma(sport);
-		}
+		imx_disable_rx_int(sport);
+		start_rx_dma(sport);
 	}
 
 	spin_unlock_irqrestore(&sport->port.lock, flags);
-- 
2.9.3
