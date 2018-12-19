From: Matthias Kaehlcke <mka@chromium.org>
Subject: [PATCH] tty: serial: qcom_geni_serial: Fix wrap around of TX buffer
Date: Wed, 19 Dec 2018 10:17:47 -0800
Message-ID: <20181219181747.118278-1-mka@chromium.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Mukesh Kumar Savaliya <msavaliy@codeaurora.org>, Ryan Case <ryandcase@chromium.org>, Douglas Anderson <dianders@chromium.org>, Evan Green <evgreen@chromium.org>, Matthias Kaehlcke <mka@chromium.org>
List-Id: linux-serial@vger.kernel.org

Before commit a1fee899e5bed ("tty: serial: qcom_geni_serial: Fix
softlock") the size of TX transfers was limited to the TX FIFO size,
and wrap arounds of the UART circular buffer were split into two
transfers. With the commit wrap around are allowed within a transfer.
The TX FIFO of the geni serial port uses a word size of 4 bytes. In
case of a circular buffer wrap within a transfer the driver currently
may write an incomplete word to the FIFO, with some bytes containing
data from the circular buffer and others being zero. Since the
transfer isn't completed yet the zero bytes are sent as if they were
actual data.

Handle wrap arounds of the TX buffer properly and ensure that words
written to the TX FIFO always contain valid data (unless the transfer
is completed).

Fixes: a1fee899e5bed ("tty: serial: qcom_geni_serial: Fix softlock")
Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
---
 drivers/tty/serial/qcom_geni_serial.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/tty/serial/qcom_geni_serial.c b/drivers/tty/serial/qcom_geni_serial.c
index cf7a95e339ad9..2ee2d3286a6b4 100644
--- a/drivers/tty/serial/qcom_geni_serial.c
+++ b/drivers/tty/serial/qcom_geni_serial.c
@@ -744,7 +744,7 @@ static void qcom_geni_serial_handle_tx(struct uart_port *uport, bool done,
 	avail *= port->tx_bytes_pw;
 
 	tail = xmit->tail;
-	chunk = min3(avail, pending, (size_t)(UART_XMIT_SIZE - tail));
+	chunk = min(avail, pending);
 	if (!chunk)
 		goto out_write_wakeup;
 
@@ -766,19 +766,21 @@ static void qcom_geni_serial_handle_tx(struct uart_port *uport, bool done,
 
 		memset(buf, 0, ARRAY_SIZE(buf));
 		tx_bytes = min_t(size_t, remaining, port->tx_bytes_pw);
-		for (c = 0; c < tx_bytes ; c++)
-			buf[c] = xmit->buf[tail + c];
+
+		for (c = 0; c < tx_bytes ; c++) {
+			buf[c] = xmit->buf[tail++];
+			tail &= UART_XMIT_SIZE - 1;
+		}
 
 		iowrite32_rep(uport->membase + SE_GENI_TX_FIFOn, buf, 1);
 
 		i += tx_bytes;
-		tail += tx_bytes;
 		uport->icount.tx += tx_bytes;
 		remaining -= tx_bytes;
 		port->tx_remaining -= tx_bytes;
 	}
 
-	xmit->tail = tail & (UART_XMIT_SIZE - 1);
+	xmit->tail = tail;
 
 	/*
 	 * The tx fifo watermark is level triggered and latched. Though we had
-- 
2.20.0.405.gbc1bbc6f85-goog
