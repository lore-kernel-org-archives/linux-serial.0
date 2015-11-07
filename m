From: "Matwey V. Kornilov" <matwey@sai.msu.ru>
Subject: [PATCH v2 3/3] tty: Add software emulated RS485 support for 8250
Date: Sat,  7 Nov 2015 13:09:36 +0300
Message-ID: <1446890976-1817-3-git-send-email-matwey@sai.msu.ru>
References: <1446890976-1817-1-git-send-email-matwey@sai.msu.ru>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1446890976-1817-1-git-send-email-matwey@sai.msu.ru>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@linuxfoundation.org, jslaby@suse.com
Cc: "Matwey V. Kornilov" <matwey@sai.msu.ru>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, matwey.kornilov@gmail.com
List-Id: linux-serial@vger.kernel.org

Implementation of software emulation of RS485 direction handling is based
on omap-serial driver.  It is acts as the following. At transmission start,
RTS is set (if required) and receiver is off (if required). At transmission
stop, RTS is set (if required) and fifo is flushed.

Signed-off-by: Matwey V. Kornilov <matwey@sai.msu.ru>
---
 drivers/tty/serial/8250/8250_port.c | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
index 52d82d2..a9291f7 100644
--- a/drivers/tty/serial/8250/8250_port.c
+++ b/drivers/tty/serial/8250/8250_port.c
@@ -559,7 +559,37 @@ static void serial8250_rpm_put_tx(struct uart_8250_port *p)
 	pm_runtime_mark_last_busy(p->port.dev);
 	pm_runtime_put_autosuspend(p->port.dev);
 }
+static void serial8250_stop_rx(struct uart_port *port);
+static void serial8250_rs485_start_tx(struct uart_8250_port *p)
+{
+	if (p->capabilities & UART_CAP_HW485 || !(p->port.rs485.flags & SER_RS485_ENABLED))
+		return;
+
+	if (p->port.rs485.flags & SER_RS485_RTS_ON_SEND) {
+		serial_port_out(&p->port, UART_MCR, UART_MCR_RTS);
+		if (p->port.rs485.delay_rts_before_send > 0)
+			mdelay(p->port.rs485.delay_rts_before_send);
+	}
+	if (!(p->port.rs485.flags & SER_RS485_RX_DURING_TX))
+		serial8250_stop_rx(&p->port);
+}
+static void serial8250_rs485_stop_tx(struct uart_8250_port *p)
+{
+	if (p->capabilities & UART_CAP_HW485 || !(p->port.rs485.flags & SER_RS485_ENABLED))
+		return;
 
+	if (p->port.rs485.flags & SER_RS485_RTS_AFTER_SEND) {
+		if (p->port.rs485.delay_rts_after_send > 0)
+			mdelay(p->port.rs485.delay_rts_after_send);
+		serial_port_out(&p->port, UART_MCR, UART_MCR_RTS);
+	}
+	/*
+	* Empty the RX FIFO, we are not interested in anything
+	* received during the half-duplex transmission.
+	*/
+	if (!(p->port.rs485.flags & SER_RS485_RX_DURING_TX))
+		serial8250_clear_fifos(p);
+}
 /*
  * IER sleep support.  UARTs which have EFRs need the "extended
  * capability" bit enabled.  Note that on XR16C850s, we need to
@@ -1309,6 +1339,7 @@ static void serial8250_stop_tx(struct uart_port *port)
 		up->acr |= UART_ACR_TXDIS;
 		serial_icr_write(up, UART_ACR, up->acr);
 	}
+	serial8250_rs485_stop_tx(up);
 	serial8250_rpm_put(up);
 }
 
@@ -1317,6 +1348,7 @@ static void serial8250_start_tx(struct uart_port *port)
 	struct uart_8250_port *up = up_to_u8250p(port);
 
 	serial8250_rpm_get_tx(up);
+	serial8250_rs485_start_tx(up);
 
 	if (up->dma && !up->dma->tx_dma(up))
 		return;
-- 
2.6.2
