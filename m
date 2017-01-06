From: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: [PATCH 9/9] tty_port: register tty ports with serdev bus
Date: Fri,  6 Jan 2017 10:26:35 -0600
Message-ID: <20170106162635.19677-10-robh@kernel.org>
References: <20170106162635.19677-1-robh@kernel.org>
Return-path: <linux-bluetooth-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170106162635.19677-1-robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Sender: linux-bluetooth-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Marcel Holtmann <marcel-kz+m5ild9QBg9hUCZPvPmw@public.gmane.org>, Jiri Slaby <jslaby-IBi9RG/b67k@public.gmane.org>, Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, "Dr . H . Nikolaus Schaller" <hns-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org>, Peter Hurley <peter-WaGBZJeGNqdsbIuE7sb01tBPR1lH4CV8@public.gmane.org>, Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Alan Cox <gnomes-qBU/x9rampVanCEyBjwyrvXRex20P6io@public.gmane.org>
Cc: Loic Poulain <loic.poulain-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>, NeilBrown <neil-+NVA1uvv1dVBDLzU/O5InQ@public.gmane.org>, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linux-bluetooth-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-serial@vger.kernel.org

Register a serdev controller with the serdev bus when a tty_port is
registered. This creates the serdev controller and create's serdev
devices for any DT child nodes of the tty_port's parent (i.e. the UART
device).

Signed-off-by: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
---
 drivers/tty/tty_port.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/tty_port.c b/drivers/tty/tty_port.c
index 232a8cbf47bc..032786e5509e 100644
--- a/drivers/tty/tty_port.c
+++ b/drivers/tty/tty_port.c
@@ -16,6 +16,7 @@
 #include <linux/bitops.h>
 #include <linux/delay.h>
 #include <linux/module.h>
+#include <linux/serdev.h>
 
 static int tty_port_default_receive_buf(struct tty_port *port,
 					const unsigned char *p,
@@ -125,9 +126,17 @@ struct device *tty_port_register_device_attr(struct tty_port *port,
 		struct device *device, void *drvdata,
 		const struct attribute_group **attr_grp)
 {
+	struct device *ttydev;
+
 	tty_port_link_device(port, driver, index);
-	return tty_register_device_attr(driver, index, device, drvdata,
+	ttydev = tty_register_device_attr(driver, index, device, drvdata,
 			attr_grp);
+	if (!ttydev)
+		return NULL;
+
+	serdev_tty_port_register(port, device, driver, index);
+	return ttydev;
+
 }
 EXPORT_SYMBOL_GPL(tty_port_register_device_attr);
 
@@ -177,6 +186,9 @@ static void tty_port_destructor(struct kref *kref)
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
