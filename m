From: yegorslists@googlemail.com
Subject: [PATCH] Fixes: e490c9144cfa ("tty: Add software emulated RS485 support for 8250")
Date: Wed, 23 Mar 2016 09:56:43 +0100
Message-ID: <1458723403-11565-1-git-send-email-yegorslists@googlemail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: gregkh@linuxfoundation.org, peter@hurleysoftware.com, linux-kernel@vger.kernel.org, bigeasy@linutronix.de, Yegor Yefremov <yegorslists@googlemail.com>, "Matwey V. Kornilov" <matwey@sai.msu.ru>
List-Id: linux-serial@vger.kernel.org

From: Yegor Yefremov <yegorslists@googlemail.com>

When in half-duplex mode RX will be disabled before TX, but not
enabled after deactivating transmitter. This patch enables
UART_IER_RLSI and UART_IER_RDI interrupts after TX is over.

Cc: Matwey V. Kornilov <matwey@sai.msu.ru>
Signed-off-by: Yegor Yefremov <yegorslists@googlemail.com>
---
 drivers/tty/serial/8250/8250_port.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
index e213da0..00ad263 100644
--- a/drivers/tty/serial/8250/8250_port.c
+++ b/drivers/tty/serial/8250/8250_port.c
@@ -1403,9 +1403,18 @@ static void __do_stop_tx_rs485(struct uart_8250_port *p)
 	/*
 	 * Empty the RX FIFO, we are not interested in anything
 	 * received during the half-duplex transmission.
+	 * Enable previously disabled RX interrupts.
 	 */
-	if (!(p->port.rs485.flags & SER_RS485_RX_DURING_TX))
+	if (!(p->port.rs485.flags & SER_RS485_RX_DURING_TX)) {
 		serial8250_clear_fifos(p);
+
+		serial8250_rpm_get(p);
+
+		p->ier |= UART_IER_RLSI | UART_IER_RDI;
+		serial_port_out(&p->port, UART_IER, p->ier);
+
+		serial8250_rpm_put(p);
+	}
 }
 
 static void serial8250_em485_handle_stop_tx(unsigned long arg)
-- 
2.1.4
