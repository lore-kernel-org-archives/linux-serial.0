From: Sascha Hauer <s.hauer@pengutronix.de>
Subject: [PATCH 2/4] serial: 8250: Add LED trigger support
Date: Wed, 23 Nov 2016 11:01:04 +0100
Message-ID: <20161123100106.15969-3-s.hauer@pengutronix.de>
References: <20161123100106.15969-1-s.hauer@pengutronix.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20161123100106.15969-1-s.hauer@pengutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, kernel@pengutronix.de, Sascha Hauer <s.hauer@pengutronix.de>
List-Id: linux-serial@vger.kernel.org

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 drivers/tty/serial/8250/8250_core.c | 12 ++++++++++--
 drivers/tty/serial/8250/8250_port.c |  4 ++++
 2 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_core.c b/drivers/tty/serial/8250/8250_core.c
index 240a361..bbcd2539 100644
--- a/drivers/tty/serial/8250/8250_core.c
+++ b/drivers/tty/serial/8250/8250_core.c
@@ -581,6 +581,7 @@ serial8250_register_ports(struct uart_driver *drv, struct device *dev)
 			up->port.flags |= UPF_NO_TXEN_TEST;
 
 		uart_add_one_port(drv, &up->port);
+		uart_add_led_triggers(drv, &up->port);
 	}
 }
 
@@ -974,8 +975,10 @@ int serial8250_register_8250_port(struct uart_8250_port *up)
 
 	uart = serial8250_find_match_or_unused(&up->port);
 	if (uart && uart->port.type != PORT_8250_CIR) {
-		if (uart->port.dev)
+		if (uart->port.dev) {
 			uart_remove_one_port(&serial8250_reg, &uart->port);
+			uart_remove_led_triggers(&uart->port);
+		}
 
 		uart->port.iobase       = up->port.iobase;
 		uart->port.membase      = up->port.membase;
@@ -1047,8 +1050,11 @@ int serial8250_register_8250_port(struct uart_8250_port *up)
 
 			ret = uart_add_one_port(&serial8250_reg,
 						&uart->port);
-			if (ret == 0)
+			if (ret == 0) {
+				uart_add_led_triggers(&serial8250_reg,
+						&uart->port);
 				ret = uart->port.line;
+			}
 		} else {
 			dev_info(uart->port.dev,
 				"skipping CIR port at 0x%lx / 0x%llx, IRQ %d\n",
@@ -1087,6 +1093,7 @@ void serial8250_unregister_port(int line)
 	}
 
 	uart_remove_one_port(&serial8250_reg, &uart->port);
+	uart_remove_led_triggers(&uart->port);
 	if (serial8250_isa_devs) {
 		uart->port.flags &= ~UPF_BOOT_AUTOCONF;
 		if (skip_txen_test)
@@ -1095,6 +1102,7 @@ void serial8250_unregister_port(int line)
 		uart->port.dev = &serial8250_isa_devs->dev;
 		uart->capabilities = 0;
 		uart_add_one_port(&serial8250_reg, &uart->port);
+		uart_add_led_triggers(&serial8250_reg, &uart->port);
 	} else {
 		uart->port.dev = NULL;
 	}
diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
index 1731b98..c301ec1 100644
--- a/drivers/tty/serial/8250/8250_port.c
+++ b/drivers/tty/serial/8250/8250_port.c
@@ -1703,6 +1703,8 @@ unsigned char serial8250_rx_chars(struct uart_8250_port *up, unsigned char lsr)
 	struct uart_port *port = &up->port;
 	int max_count = 256;
 
+	uart_led_trigger_rx(port);
+
 	do {
 		serial8250_read_char(up, lsr);
 		if (--max_count == 0)
@@ -1736,6 +1738,8 @@ void serial8250_tx_chars(struct uart_8250_port *up)
 		return;
 	}
 
+	uart_led_trigger_tx(port);
+
 	count = up->tx_loadsz;
 	do {
 		serial_out(up, UART_TX, xmit->buf[xmit->tail]);
-- 
2.10.2
