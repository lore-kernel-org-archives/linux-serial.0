From: "Matwey V. Kornilov" <matwey@sai.msu.ru>
Subject: [PATCH v3 3/5] tty: Implement default fallback serial8250_rs485_config
Date: Thu, 12 Nov 2015 17:33:54 +0300
Message-ID: <1447338836-8785-4-git-send-email-matwey@sai.msu.ru>
References: <1447338836-8785-1-git-send-email-matwey@sai.msu.ru>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1447338836-8785-1-git-send-email-matwey@sai.msu.ru>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@linuxfoundation.org, jslaby@suse.com, peter@hurleysoftware.com
Cc: "Matwey V. Kornilov" <matwey@sai.msu.ru>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

When 8250 driver doesn't have its own hardware RS485 support and doesn't
want to override rs485_config callback, then default
serial8250_rs485_config is used. It just stores supplied by user-space
config and sets SER_RS485_SOFTWARE

Signed-off-by: Matwey V. Kornilov <matwey@sai.msu.ru>
---
 drivers/tty/serial/8250/8250_core.c |  3 ++-
 drivers/tty/serial/8250/8250_port.c | 10 ++++++++++
 2 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/8250/8250_core.c b/drivers/tty/serial/8250/8250_core.c
index 3912646..71fabb0 100644
--- a/drivers/tty/serial/8250/8250_core.c
+++ b/drivers/tty/serial/8250/8250_core.c
@@ -986,7 +986,6 @@ int serial8250_register_8250_port(struct uart_8250_port *up)
 		uart->capabilities	= up->capabilities;
 		uart->port.throttle	= up->port.throttle;
 		uart->port.unthrottle	= up->port.unthrottle;
-		uart->port.rs485_config	= up->port.rs485_config;
 		uart->port.rs485	= up->port.rs485;
 		uart->dma		= up->dma;
 
@@ -1025,6 +1024,8 @@ int serial8250_register_8250_port(struct uart_8250_port *up)
 			uart->port.pm = up->port.pm;
 		if (up->port.handle_break)
 			uart->port.handle_break = up->port.handle_break;
+		if (up->port.rs485_config)
+			uart->port.rs485_config	= up->port.rs485_config;
 		if (up->dl_read)
 			uart->dl_read = up->dl_read;
 		if (up->dl_write)
diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
index 52d82d2..067ef55 100644
--- a/drivers/tty/serial/8250/8250_port.c
+++ b/drivers/tty/serial/8250/8250_port.c
@@ -2735,6 +2735,14 @@ serial8250_type(struct uart_port *port)
 	return uart_config[type].name;
 }
 
+static int serial8250_rs485_config(struct uart_port *port,
+				struct serial_rs485 *rs485)
+{
+	port->rs485 = *rs485;
+	port->rs485.flags |= SER_RS485_SOFTWARE;
+	return 0;
+}
+
 static const struct uart_ops serial8250_pops = {
 	.tx_empty	= serial8250_tx_empty,
 	.set_mctrl	= serial8250_set_mctrl,
@@ -2797,6 +2805,8 @@ void serial8250_set_defaults(struct uart_8250_port *up)
 		if (!up->dma->rx_dma)
 			up->dma->rx_dma = serial8250_rx_dma;
 	}
+
+	up->port.rs485_config = serial8250_rs485_config;
 }
 EXPORT_SYMBOL_GPL(serial8250_set_defaults);
 
-- 
2.6.2
