From: Johan Hovold <johan@kernel.org>
Subject: [PATCH v2 2/2] serial: enable serdev support
Date: Thu, 18 May 2017 17:33:01 +0200
Message-ID: <20170518153301.28885-3-johan@kernel.org>
References: <20170518153301.28885-1-johan@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170518153301.28885-1-johan@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Rob Herring <robh@kernel.org>, Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Johan Hovold <johan@kernel.org>
List-Id: linux-serial@vger.kernel.org

Enable serdev support by using the new device-registration helpers.

Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/tty/serial/serial_core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
index bc6caea6099f..13bfd5dcffce 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -2782,7 +2782,7 @@ int uart_add_one_port(struct uart_driver *drv, struct uart_port *uport)
 	 * Register the port whether it's detected or not.  This allows
 	 * setserial to be used to alter this port's parameters.
 	 */
-	tty_dev = tty_port_register_device_attr(port, drv->tty_driver,
+	tty_dev = tty_port_register_device_attr_serdev(port, drv->tty_driver,
 			uport->line, uport->dev, port, uport->tty_groups);
 	if (likely(!IS_ERR(tty_dev))) {
 		device_set_wakeup_capable(tty_dev, 1);
@@ -2845,7 +2845,7 @@ int uart_remove_one_port(struct uart_driver *drv, struct uart_port *uport)
 	/*
 	 * Remove the devices from the tty layer
 	 */
-	tty_unregister_device(drv->tty_driver, uport->line);
+	tty_port_unregister_device(port, drv->tty_driver, uport->line);
 
 	tty = tty_port_tty_get(port);
 	if (tty) {
-- 
2.13.0
