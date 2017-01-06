From: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: [PATCH 3/9] tty_port: make tty_port_register_device wrap tty_port_register_device_attr
Date: Fri,  6 Jan 2017 10:26:29 -0600
Message-ID: <20170106162635.19677-4-robh@kernel.org>
References: <20170106162635.19677-1-robh@kernel.org>
Return-path: <linux-bluetooth-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170106162635.19677-1-robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Sender: linux-bluetooth-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Marcel Holtmann <marcel-kz+m5ild9QBg9hUCZPvPmw@public.gmane.org>, Jiri Slaby <jslaby-IBi9RG/b67k@public.gmane.org>, Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, "Dr . H . Nikolaus Schaller" <hns-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org>, Peter Hurley <peter-WaGBZJeGNqdsbIuE7sb01tBPR1lH4CV8@public.gmane.org>, Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Alan Cox <gnomes-qBU/x9rampVanCEyBjwyrvXRex20P6io@public.gmane.org>
Cc: Loic Poulain <loic.poulain-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>, NeilBrown <neil-+NVA1uvv1dVBDLzU/O5InQ@public.gmane.org>, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linux-bluetooth-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-serial@vger.kernel.org

tty_register_device is just a wrapper for tty_register_device_attr with
NULL passed for drvdata and attr_grp. So similarly make
tty_port_register_device a wrapper of tty_port_register_device_attr so that
additions don't have to be made in both functions.

Signed-off-by: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
---
 drivers/tty/tty_port.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/tty/tty_port.c b/drivers/tty/tty_port.c
index 606d9e5bf28f..1d8804843103 100644
--- a/drivers/tty/tty_port.c
+++ b/drivers/tty/tty_port.c
@@ -67,8 +67,7 @@ struct device *tty_port_register_device(struct tty_port *port,
 		struct tty_driver *driver, unsigned index,
 		struct device *device)
 {
-	tty_port_link_device(port, driver, index);
-	return tty_register_device(driver, index, device);
+	return tty_port_register_device_attr(port, driver, index, device, NULL, NULL);
 }
 EXPORT_SYMBOL_GPL(tty_port_register_device);
 
-- 
2.10.1
