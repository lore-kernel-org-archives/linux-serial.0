From: Johan Hovold <johan@kernel.org>
Subject: [RFC PATCH 2/3] USB: serial: enable serdev support
Date: Fri, 25 May 2018 14:52:56 +0200
Message-ID: <20180525125257.29124-3-johan@kernel.org>
References: <20180525125257.29124-1-johan@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180525125257.29124-1-johan@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Rob Herring <robh+dt@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>, Johan Hovold <johan@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

Enable serdev support by using the serdev opt-in tty-port registration
helpers.

FIXME: serdev core always allocates and registers a serdev controller
during port registration only to immediately roll back in the common
case when there is no serdev slave defined in firmware

FIXME: serdev does not support hotplugging (e.g. tty port hangups)

Not-signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/usb/serial/bus.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/serial/bus.c b/drivers/usb/serial/bus.c
index eb0195cf37dd..5f574a418c52 100644
--- a/drivers/usb/serial/bus.c
+++ b/drivers/usb/serial/bus.c
@@ -60,8 +60,9 @@ static int usb_serial_device_probe(struct device *dev)
 	}
 
 	minor = port->minor;
-	tty_dev = tty_port_register_device(&port->port, usb_serial_tty_driver,
-					   minor, dev);
+	tty_dev = tty_port_register_device_serdev(&port->port,
+							usb_serial_tty_driver,
+							minor, dev);
 	if (IS_ERR(tty_dev)) {
 		retval = PTR_ERR(tty_dev);
 		goto err_port_remove;
@@ -105,7 +106,7 @@ static int usb_serial_device_remove(struct device *dev)
 	autopm_err = usb_autopm_get_interface(port->serial->interface);
 
 	minor = port->minor;
-	tty_unregister_device(usb_serial_tty_driver, minor);
+	tty_port_unregister_device(&port->port, usb_serial_tty_driver, minor);
 
 	driver = port->serial->type;
 	if (driver->port_remove)
-- 
2.17.0
