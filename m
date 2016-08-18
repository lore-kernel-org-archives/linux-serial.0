From: Rob Herring <robh@kernel.org>
Subject: [RFC PATCH 3/3] tty: serial_core: add uart controller registration
Date: Wed, 17 Aug 2016 20:14:45 -0500
Message-ID: <20160818011445.22726-4-robh@kernel.org>
References: <20160818011445.22726-1-robh@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160818011445.22726-1-robh@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Marcel Holtmann <marcel@holtmann.org>, Jiri Slaby <jslaby@suse.com>, Sebastian Reichel <sre@kernel.org>
Cc: Pavel Machek <pavel@ucw.cz>, Peter Hurley <peter@hurleysoftware.com>, NeilBrown <neil@brown.name>, "Dr . H . Nikolaus Schaller" <hns@goldelico.com>, Arnd Bergmann <arnd@arndb.de>, Linus Walleij <linus.walleij@linaro.org>, linux-bluetooth@vger.kernel.org, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

Register serial ports with the uart device core as a controller and add
a receive handler call.

Signed-off-by: Rob Herring <robh@kernel.org>
---
 drivers/tty/serial/serial_core.c | 8 ++++++++
 include/linux/serial_core.h      | 1 +
 2 files changed, 9 insertions(+)

diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
index 9dd444f..1552fee 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -34,6 +34,7 @@
 #include <linux/serial_core.h>
 #include <linux/delay.h>
 #include <linux/mutex.h>
+#include <linux/uart_device.h>
 
 #include <asm/irq.h>
 #include <asm/uaccess.h>
@@ -2800,6 +2801,10 @@ int uart_add_one_port(struct uart_driver *drv, struct uart_port *uport)
 
 	uart_configure_port(drv, state, uport);
 
+	uport->ctrlr = uart_controller_alloc(uport->dev, 0);
+	uport->ctrlr->port = uport;
+	uart_controller_add(uport->ctrlr);
+
 	num_groups = 2;
 	if (uport->attr_group)
 		num_groups++;
@@ -3027,6 +3032,9 @@ void uart_insert_char(struct uart_port *port, unsigned int status,
 {
 	struct tty_port *tport = &port->state->port;
 
+	if (uart_controller_rx(port->ctrlr, ch) >= 0)
+		return;
+
 	if ((status & port->ignore_status_mask & ~overrun) == 0)
 		if (tty_insert_flip_char(tport, ch, flag) == 0)
 			++port->icount.buf_overrun;
diff --git a/include/linux/serial_core.h b/include/linux/serial_core.h
index a27ca1f..7cde6a9 100644
--- a/include/linux/serial_core.h
+++ b/include/linux/serial_core.h
@@ -155,6 +155,7 @@ struct uart_port {
 
 	unsigned int		read_status_mask;	/* driver specific */
 	unsigned int		ignore_status_mask;	/* driver specific */
+	struct uart_controller	*ctrlr;
 	struct uart_state	*state;			/* pointer to parent state */
 	struct uart_icount	icount;			/* statistics */
 
-- 
2.9.2
