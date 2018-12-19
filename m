From: Ryan Case <ryandcase@chromium.org>
Subject: [PATCH] tty: serial: qcom_geni_serial: Fix UART hang
Date: Wed, 19 Dec 2018 12:33:53 -0800
Message-ID: <20181219203353.172335-1-ryandcase@chromium.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>
Cc: Evan Green <evgreen@chromium.org>, Doug Anderson <dianders@chromium.org>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, Ryan Case <ryandcase@chromium.org>
List-Id: linux-serial@vger.kernel.org

If a serial console write occured while a UART transmit command was
waiting for a done signal then no further data would be sent until
something new kicked the system into gear. If there is already data
waiting in the circular buffer we must re-enable the tx watermark so we
receive the expected interrupts.

Signed-off-by: Ryan Case <ryandcase@chromium.org>
---

 drivers/tty/serial/qcom_geni_serial.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/tty/serial/qcom_geni_serial.c b/drivers/tty/serial/qcom_geni_serial.c
index 0c93beb69e73..a694a47747c7 100644
--- a/drivers/tty/serial/qcom_geni_serial.c
+++ b/drivers/tty/serial/qcom_geni_serial.c
@@ -442,6 +442,7 @@ static void qcom_geni_serial_console_write(struct console *co, const char *s,
 	bool locked = true;
 	unsigned long flags;
 	u32 geni_status;
+	u32 irq_en;
 
 	WARN_ON(co->index < 0 || co->index >= GENI_UART_CONS_PORTS);
 
@@ -476,6 +477,13 @@ static void qcom_geni_serial_console_write(struct console *co, const char *s,
 		 * has been sent, in which case we need to look for done first.
 		 */
 		qcom_geni_serial_poll_tx_done(uport);
+
+		if (uart_circ_chars_pending(&uport->state->xmit)) {
+			irq_en = readl_relaxed(uport->membase +
+					SE_GENI_M_IRQ_EN);
+			writel_relaxed(irq_en | M_TX_FIFO_WATERMARK_EN,
+					uport->membase + SE_GENI_M_IRQ_EN);
+		}
 	}
 
 	__qcom_geni_serial_console_write(uport, s, count);
-- 
2.20.1.415.g653613c723-goog
