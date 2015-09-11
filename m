From: kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org
Subject: [PATCH 1/4] serial: of-serial: allow for a custom clock divider different from 16
Date: Fri, 11 Sep 2015 12:20:50 +0000
Message-ID: <1441974053-2630-2-git-send-email-kernel@martin.sperl.org>
References: <1441974053-2630-1-git-send-email-kernel@martin.sperl.org>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1441974053-2630-1-git-send-email-kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Lee Jones <lee-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Jiri Slaby <jslaby-IBi9RG/b67k@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
List-Id: linux-serial@vger.kernel.org

From: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>

The bcm2835 SOC has an auxiliary uart that is compatible to ns16550.
the only difference is that it has an internal clock divider of 8
instead of 16.

The net result is that the baud-rate is twice the baud-rate requested.

This patch allows to configure an alternate clock-divider in the
device-tree, which then scales the clock coming from the clock
framework to get scaled by 16/divider.

Signed-off-by: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
---
 drivers/tty/serial/of_serial.c |   14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/tty/serial/of_serial.c b/drivers/tty/serial/of_serial.c
index afae58a..2fcbfee 100644
--- a/drivers/tty/serial/of_serial.c
+++ b/drivers/tty/serial/of_serial.c
@@ -65,6 +65,7 @@ static int of_platform_serial_setup(struct platform_device *ofdev,
 	struct resource resource;
 	struct device_node *np = ofdev->dev.of_node;
 	u32 clk, spd, prop;
+	u64 clk_scaled;
 	int ret;
 
 	memset(port, 0, sizeof *port);
@@ -84,6 +85,19 @@ static int of_platform_serial_setup(struct platform_device *ofdev,
 
 		clk = clk_get_rate(info->clk);
 	}
+	/* a custom clock divider instead of the default 16
+	 * this (as of now) does not change the low level behaviour
+	 * but only scales the clock accordingly
+	 */
+	if (of_property_read_u32(np, "clock-divider", &spd) == 0) {
+		clk_scaled = (u64) clk * 16;
+		do_div(clk_scaled, spd);
+		dev_info(&ofdev->dev,
+			"scaling clock %uHz to %uHz to allow a clock divider of %u\n",
+			clk, (u32)clk_scaled, spd);
+		clk = (u32) clk_scaled;
+	}
+
 	/* If current-speed was set, then try not to change it. */
 	if (of_property_read_u32(np, "current-speed", &spd) == 0)
 		port->custom_divisor = clk / (16 * spd);
-- 
1.7.10.4

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
