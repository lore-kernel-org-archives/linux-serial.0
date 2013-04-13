From: John Crispin <blogic@openwrt.org>
Subject: [PATCH 3/3] tty: of_serial: initialize port.iosize from resource
Date: Sat, 13 Apr 2013 11:33:38 +0200
Message-ID: <1365845618-16040-4-git-send-email-blogic@openwrt.org>
References: <1365845618-16040-1-git-send-email-blogic@openwrt.org>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from nbd.name ([46.4.11.11]:39375 "EHLO nbd.name"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752244Ab3DMJho (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Sat, 13 Apr 2013 05:37:44 -0400
In-Reply-To: <1365845618-16040-1-git-send-email-blogic@openwrt.org>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-mips@linux-mips.org, linux-serial@vger.kernel.org, Gabor Juhos <juhosg@openwrt.org>

From: Gabor Juhos <juhosg@openwrt.org>

Signed-off-by: Gabor Juhos <juhosg@openwrt.org>
---
 drivers/tty/serial/of_serial.c |    6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/of_serial.c b/drivers/tty/serial/of_serial.c
index 42f8550..e4be45b 100644
--- a/drivers/tty/serial/of_serial.c
+++ b/drivers/tty/serial/of_serial.c
@@ -88,10 +88,14 @@ static int of_platform_serial_setup(struct platform_device *ofdev,
 
 	spin_lock_init(&port->lock);
 	port->mapbase = resource.start;
+	port->iosize = resource_size(&resource);
 
 	/* Check for shifted address mapping */
-	if (of_property_read_u32(np, "reg-offset", &prop) == 0)
+	if (of_property_read_u32(np, "reg-offset", &prop) == 0) {
 		port->mapbase += prop;
+		if (prop > port->iosize)
+			port->iosize -= prop;
+	}
 
 	/* Check for registers offset within the devices address range */
 	if (of_property_read_u32(np, "reg-shift", &prop) == 0)
-- 
1.7.10.4

