From: Greg Kroah-Hartman <gregkh@suse.de>
Subject: [PATCH 21/79] tty: of_serial: add support for the DesignWare 8250
Date: Wed, 26 Oct 2011 14:12:26 +0200
Message-ID: <1319631204-23262-21-git-send-email-gregkh@suse.de>
References: <20111026114236.GA22180@kroah.com>
 <1319631204-23262-1-git-send-email-gregkh@suse.de>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:60960 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932852Ab1JZMNg (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Wed, 26 Oct 2011 08:13:36 -0400
In-Reply-To: <1319631204-23262-1-git-send-email-gregkh@suse.de>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: Jamie Iles <jamie@jamieiles.com>, Alan Cox <alan@linux.intel.com>, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@suse.de>

From: Jamie Iles <jamie@jamieiles.com>

Support the DesignWare 8250 by a new compatible string and registering
the DesignWare helpers.  If the registration of the helpers fails, then
continue as a normal 8250 as we may still get some useful debug out.

Cc: Alan Cox <alan@linux.intel.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Jamie Iles <jamie@jamieiles.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---
 .../devicetree/bindings/tty/serial/of-serial.txt   |    1 +
 drivers/tty/serial/of_serial.c                     |    7 +++++++
 2 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/Documentation/devicetree/bindings/tty/serial/of-serial.txt b/Documentation/devicetree/bindings/tty/serial/of-serial.txt
index b8b27b0..b7ceaaa 100644
--- a/Documentation/devicetree/bindings/tty/serial/of-serial.txt
+++ b/Documentation/devicetree/bindings/tty/serial/of-serial.txt
@@ -3,6 +3,7 @@
 Required properties:
 - compatible : one of:
 	- "ns8250"
+	- "ns8250dw"
 	- "ns16450"
 	- "ns16550a"
 	- "ns16550"
diff --git a/drivers/tty/serial/of_serial.c b/drivers/tty/serial/of_serial.c
index e58cece..024926c 100644
--- a/drivers/tty/serial/of_serial.c
+++ b/drivers/tty/serial/of_serial.c
@@ -78,6 +78,12 @@ static int __devinit of_platform_serial_setup(struct platform_device *ofdev,
 		}
 	}
 
+	if (of_device_is_compatible(np, "ns8250dw")) {
+		ret = serial8250_use_designware_io(port);
+		if (ret)
+			dev_warn(&ofdev->dev, "unable to register DesignWare 8250 helpers, continuing as a normal 8250\n");
+	}
+
 	port->type = type;
 	port->uartclk = clk;
 	port->flags = UPF_SHARE_IRQ | UPF_BOOT_AUTOCONF | UPF_IOREMAP
@@ -176,6 +182,7 @@ static int of_platform_serial_remove(struct platform_device *ofdev)
  */
 static struct of_device_id __devinitdata of_platform_serial_table[] = {
 	{ .compatible = "ns8250",   .data = (void *)PORT_8250, },
+	{ .compatible = "ns8250dw", .data = (void *)PORT_8250, },
 	{ .compatible = "ns16450",  .data = (void *)PORT_16450, },
 	{ .compatible = "ns16550a", .data = (void *)PORT_16550A, },
 	{ .compatible = "ns16550",  .data = (void *)PORT_16550, },
-- 
1.7.7

