From: "Matwey V. Kornilov" <matwey@sai.msu.ru>
Subject: [PATCH v2 2/3] tty: Implement default fallback serial8250_rs485_config
Date: Sat,  7 Nov 2015 13:09:35 +0300
Message-ID: <1446890976-1817-2-git-send-email-matwey@sai.msu.ru>
References: <1446890976-1817-1-git-send-email-matwey@sai.msu.ru>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1446890976-1817-1-git-send-email-matwey@sai.msu.ru>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@linuxfoundation.org, jslaby@suse.com
Cc: "Matwey V. Kornilov" <matwey@sai.msu.ru>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, matwey.kornilov@gmail.com
List-Id: linux-serial@vger.kernel.org

When 8250 driver doesn't have its own hardware RS485 support and doesn't
want to override rs485_config callback, then default
serial8250_rs485_config is used. It just stores supplied by user-space
config.

Signed-off-by: Matwey V. Kornilov <matwey@sai.msu.ru>
---
 drivers/tty/serial/8250/8250_core.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/tty/serial/8250/8250_core.c b/drivers/tty/serial/8250/8250_core.c
index 3912646..8f292da 100644
--- a/drivers/tty/serial/8250/8250_core.c
+++ b/drivers/tty/serial/8250/8250_core.c
@@ -395,6 +395,12 @@ static void serial8250_release_rsa_resource(struct uart_8250_port *up)
 	}
 }
 #endif
+static int serial8250_rs485_config(struct uart_port *port,
+				struct serial_rs485 *rs485)
+{
+	port->rs485 = *rs485;
+	return 0;
+}
 
 static const struct uart_ops *base_ops;
 static struct uart_ops univ8250_port_ops;
@@ -990,6 +996,10 @@ int serial8250_register_8250_port(struct uart_8250_port *up)
 		uart->port.rs485	= up->port.rs485;
 		uart->dma		= up->dma;
 
+		/* Use software RS485 support when hardware one is not available */
+		if (!(uart->capabilities & UART_CAP_HW485) && !uart->port.rs485_config)
+			uart->port.rs485_config = serial8250_rs485_config;
+
 		/* Take tx_loadsz from fifosize if it wasn't set separately */
 		if (uart->port.fifosize && !uart->tx_loadsz)
 			uart->tx_loadsz = uart->port.fifosize;
-- 
2.6.2
