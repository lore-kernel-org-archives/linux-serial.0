From: Rob Herring <robh@kernel.org>
Subject: [PATCH v3 5/5] tty_port: register tty ports with serdev bus
Date: Wed, 25 Jan 2017 14:23:43 -0600
Message-ID: <20170125202343.30923-6-robh@kernel.org>
References: <20170125202343.30923-1-robh@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170125202343.30923-1-robh@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Marcel Holtmann <marcel@holtmann.org>, Jiri Slaby <jslaby@suse.com>, Sebastian Reichel <sre@kernel.org>, Arnd Bergmann <arnd@arndb.de>, "Dr . H . Nikolaus Schaller" <hns@goldelico.com>, Peter Hurley <peter@hurleysoftware.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Alan Cox <gnomes@lxorguk.ukuu.org.uk>
Cc: Loic Poulain <loic.poulain@intel.com>, Pavel Machek <pavel@ucw.cz>, NeilBrown <neil@brown.name>, Linus Walleij <linus.walleij@linaro.org>, linux-bluetooth@vger.kernel.org, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

Register a serdev controller with the serdev bus when a tty_port is
registered. This creates the serdev controller and create's serdev
devices for any DT child nodes of the tty_port's parent (i.e. the UART
device).

Signed-off-by: Rob Herring <robh@kernel.org>
Reviewed-By: Sebastian Reichel <sre@kernel.org>
---
v3:
- no change

v2:
- Skip creating the tty device file node when serdev_tty_port_register
  finds slave devices.

 drivers/tty/tty_port.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/tty/tty_port.c b/drivers/tty/tty_port.c
index 8d9886b06037..5cd3cd932293 100644
--- a/drivers/tty/tty_port.c
+++ b/drivers/tty/tty_port.c
@@ -16,6 +16,7 @@
 #include <linux/bitops.h>
 #include <linux/delay.h>
 #include <linux/module.h>
+#include <linux/serdev.h>
 
 static int tty_port_default_receive_buf(struct tty_port *port,
 					const unsigned char *p,
@@ -128,7 +129,15 @@ struct device *tty_port_register_device_attr(struct tty_port *port,
 		struct device *device, void *drvdata,
 		const struct attribute_group **attr_grp)
 {
+	struct device *dev;
+
 	tty_port_link_device(port, driver, index);
+
+	dev = serdev_tty_port_register(port, device, driver, index);
+	if (PTR_ERR(dev) != -ENODEV)
+		/* Skip creating cdev if we registered a serdev device */
+		return dev;
+
 	return tty_register_device_attr(driver, index, device, drvdata,
 			attr_grp);
 }
@@ -180,6 +189,9 @@ static void tty_port_destructor(struct kref *kref)
 	/* check if last port ref was dropped before tty release */
 	if (WARN_ON(port->itty))
 		return;
+
+	serdev_tty_port_unregister(port);
+
 	if (port->xmit_buf)
 		free_page((unsigned long)port->xmit_buf);
 	tty_port_destroy(port);
-- 
2.10.1
