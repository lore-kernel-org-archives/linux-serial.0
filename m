From: Greg Kroah-Hartman <gregkh@suse.de>
Subject: [PATCH 65/76] tty/serial: Relax the device_type restriction from of_serial
Date: Wed, 16 Mar 2011 14:12:35 -0700
Message-ID: <1300309966-5745-65-git-send-email-gregkh@suse.de>
References: <20110316205746.GA2938@kroah.com>
 <1300309966-5745-1-git-send-email-gregkh@suse.de>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from kroah.org ([198.145.64.141]:33107 "EHLO coco.kroah.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754331Ab1CPVPK (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Wed, 16 Mar 2011 17:15:10 -0400
In-Reply-To: <1300309966-5745-1-git-send-email-gregkh@suse.de>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: Grant Likely <grant.likely@secretlab.ca>, Greg Kroah-Hartman <gregkh@suse.de>

From: Grant Likely <grant.likely@secretlab.ca>

There is no need to test for a device_type property in ns8250
compatible serial ports.  device_type is an OpenFirmware property that
is not required when using the flattened tree representation.

Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---
 drivers/tty/serial/of_serial.c |   18 +++++++++---------
 1 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/tty/serial/of_serial.c b/drivers/tty/serial/of_serial.c
index 5c7abe4..6a18ca6 100644
--- a/drivers/tty/serial/of_serial.c
+++ b/drivers/tty/serial/of_serial.c
@@ -160,17 +160,17 @@ static int of_platform_serial_remove(struct platform_device *ofdev)
  * A few common types, add more as needed.
  */
 static struct of_device_id __devinitdata of_platform_serial_table[] = {
-	{ .type = "serial", .compatible = "ns8250",   .data = (void *)PORT_8250, },
-	{ .type = "serial", .compatible = "ns16450",  .data = (void *)PORT_16450, },
-	{ .type = "serial", .compatible = "ns16550a", .data = (void *)PORT_16550A, },
-	{ .type = "serial", .compatible = "ns16550",  .data = (void *)PORT_16550, },
-	{ .type = "serial", .compatible = "ns16750",  .data = (void *)PORT_16750, },
-	{ .type = "serial", .compatible = "ns16850",  .data = (void *)PORT_16850, },
+	{ .compatible = "ns8250",   .data = (void *)PORT_8250, },
+	{ .compatible = "ns16450",  .data = (void *)PORT_16450, },
+	{ .compatible = "ns16550a", .data = (void *)PORT_16550A, },
+	{ .compatible = "ns16550",  .data = (void *)PORT_16550, },
+	{ .compatible = "ns16750",  .data = (void *)PORT_16750, },
+	{ .compatible = "ns16850",  .data = (void *)PORT_16850, },
 #ifdef CONFIG_SERIAL_OF_PLATFORM_NWPSERIAL
-	{ .type = "serial", .compatible = "ibm,qpace-nwp-serial",
-					.data = (void *)PORT_NWPSERIAL, },
+	{ .compatible = "ibm,qpace-nwp-serial",
+		.data = (void *)PORT_NWPSERIAL, },
 #endif
-	{ .type = "serial",			      .data = (void *)PORT_UNKNOWN, },
+	{ .type = "serial",         .data = (void *)PORT_UNKNOWN, },
 	{ /* end of list */ },
 };
 
-- 
1.7.4.1

