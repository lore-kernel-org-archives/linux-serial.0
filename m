From: Bjorn Andersson <bjorn.andersson@linaro.org>
Subject: [PATCH v2] tty: serial: msm: Don't reconfigure same baud rate
Date: Thu, 16 Jun 2016 11:24:35 -0700
Message-ID: <1466101475-8851-1-git-send-email-bjorn.andersson@linaro.org>
References: <1465844571-1229-1-git-send-email-bjorn.andersson@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1465844571-1229-1-git-send-email-bjorn.andersson@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Andy Gross <andy.gross@linaro.org>, Stephen Boyd <sboyd@codeaurora.org>, David Brown <david.brown@linaro.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

msm_set_termios() is called whenever the tty is opened. Setting the baud
rate requires a full reset of the msm serial block, even when the rate
is unchanged. In the case when the same uart is used as console this
reset will discard any console output data still being clocked out of
the TX fifo.

By skipping the rate-change in the case where the baud rate is unchanged
since last request we can avoid the reset and the discarding of the
data.

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
 drivers/tty/serial/msm_serial.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/drivers/tty/serial/msm_serial.c b/drivers/tty/serial/msm_serial.c
index b7d80bd57db9..206149f104fa 100644
--- a/drivers/tty/serial/msm_serial.c
+++ b/drivers/tty/serial/msm_serial.c
@@ -76,6 +76,7 @@ struct msm_port {
 	bool			break_detected;
 	struct msm_dma		tx_dma;
 	struct msm_dma		rx_dma;
+	unsigned int		last_baud;
 };
 
 static void msm_handle_tx(struct uart_port *port);
@@ -1072,11 +1073,16 @@ static void msm_set_termios(struct uart_port *port, struct ktermios *termios,
 	if (dma->chan) /* Terminate if any */
 		msm_stop_dma(port, dma);
 
-	/* calculate and set baud rate */
+	/* calculate and set baud rate, if changed from last request */
 	baud = uart_get_baud_rate(port, termios, old, 300, 4000000);
-	baud = msm_set_baud_rate(port, baud, &flags);
-	if (tty_termios_baud_rate(termios))
-		tty_termios_encode_baud_rate(termios, baud, baud);
+	if (baud != msm_port->last_baud) {
+		msm_port->last_baud = baud;
+
+		baud = msm_set_baud_rate(port, baud, &flags);
+		if (tty_termios_baud_rate(termios))
+			tty_termios_encode_baud_rate(termios, baud, baud);
+		uart_update_timeout(port, termios->c_cflag, baud);
+	}
 
 	/* calculate parity */
 	mr = msm_read(port, UART_MR2);
@@ -1134,8 +1140,6 @@ static void msm_set_termios(struct uart_port *port, struct ktermios *termios,
 	if (termios->c_iflag & (IGNBRK | BRKINT | PARMRK))
 		port->read_status_mask |= UART_SR_RX_BREAK;
 
-	uart_update_timeout(port, termios->c_cflag, baud);
-
 	/* Try to use DMA */
 	msm_start_rx_dma(msm_port);
 
-- 
2.5.0
