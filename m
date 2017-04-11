From: Johan Hovold <johan@kernel.org>
Subject: [PATCH 4/4] serial: enable serdev support
Date: Tue, 11 Apr 2017 19:07:31 +0200
Message-ID: <20170411170731.4085-5-johan@kernel.org>
References: <20170411170731.4085-1-johan@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170411170731.4085-1-johan@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Rob Herring <robh@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Johan Hovold <johan@kernel.org>
List-Id: linux-serial@vger.kernel.org

Enable serdev support by using the new device-registration helpers.

Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/tty/serial/serial_core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
index 3fe56894974a..9f5eb0ced359 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -2785,7 +2785,7 @@ int uart_add_one_port(struct uart_driver *drv, struct uart_port *uport)
 	 * Register the port whether it's detected or not.  This allows
 	 * setserial to be used to alter this port's parameters.
 	 */
-	tty_dev = tty_port_register_device_attr(port, drv->tty_driver,
+	tty_dev = tty_port_register_device_attr_serdev(port, drv->tty_driver,
 			uport->line, uport->dev, port, uport->tty_groups);
 	if (likely(!IS_ERR(tty_dev))) {
 		device_set_wakeup_capable(tty_dev, 1);
@@ -2848,7 +2848,7 @@ int uart_remove_one_port(struct uart_driver *drv, struct uart_port *uport)
 	/*
 	 * Remove the devices from the tty layer
 	 */
-	tty_unregister_device(drv->tty_driver, uport->line);
+	tty_port_unregister_device(port, drv->tty_driver, uport->line);
 
 	tty = tty_port_tty_get(port);
 	if (tty) {
-- 
2.12.2
