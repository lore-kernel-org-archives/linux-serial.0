From: Greg Kroah-Hartman <gregkh@suse.de>
Subject: [PATCH 22/79] Revert "tty: of_serial: add support for the DesignWare 8250"
Date: Wed, 26 Oct 2011 14:12:27 +0200
Message-ID: <1319631204-23262-22-git-send-email-gregkh@suse.de>
References: <20111026114236.GA22180@kroah.com>
 <1319631204-23262-1-git-send-email-gregkh@suse.de>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:60964 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932798Ab1JZMNh (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Wed, 26 Oct 2011 08:13:37 -0400
In-Reply-To: <1319631204-23262-1-git-send-email-gregkh@suse.de>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@suse.de>, Alan Cox <alan@linux.intel.com>, Arnd Bergmann <arnd@arndb.de>, Jamie Iles <jamie@jamieiles.com>

This reverts commit 14a8d47d4e9f51372996914c16bdbf1c34e209b5.

It causes a build error that needs to be resolved differently.

Cc: Alan Cox <alan@linux.intel.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Jamie Iles <jamie@jamieiles.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---
 .../devicetree/bindings/tty/serial/of-serial.txt   |    1 -
 drivers/tty/serial/of_serial.c                     |    7 -------
 2 files changed, 0 insertions(+), 8 deletions(-)

diff --git a/Documentation/devicetree/bindings/tty/serial/of-serial.txt b/Documentation/devicetree/bindings/tty/serial/of-serial.txt
index b7ceaaa..b8b27b0 100644
--- a/Documentation/devicetree/bindings/tty/serial/of-serial.txt
+++ b/Documentation/devicetree/bindings/tty/serial/of-serial.txt
@@ -3,7 +3,6 @@
 Required properties:
 - compatible : one of:
 	- "ns8250"
-	- "ns8250dw"
 	- "ns16450"
 	- "ns16550a"
 	- "ns16550"
diff --git a/drivers/tty/serial/of_serial.c b/drivers/tty/serial/of_serial.c
index 024926c..e58cece 100644
--- a/drivers/tty/serial/of_serial.c
+++ b/drivers/tty/serial/of_serial.c
@@ -78,12 +78,6 @@ static int __devinit of_platform_serial_setup(struct platform_device *ofdev,
 		}
 	}
 
-	if (of_device_is_compatible(np, "ns8250dw")) {
-		ret = serial8250_use_designware_io(port);
-		if (ret)
-			dev_warn(&ofdev->dev, "unable to register DesignWare 8250 helpers, continuing as a normal 8250\n");
-	}
-
 	port->type = type;
 	port->uartclk = clk;
 	port->flags = UPF_SHARE_IRQ | UPF_BOOT_AUTOCONF | UPF_IOREMAP
@@ -182,7 +176,6 @@ static int of_platform_serial_remove(struct platform_device *ofdev)
  */
 static struct of_device_id __devinitdata of_platform_serial_table[] = {
 	{ .compatible = "ns8250",   .data = (void *)PORT_8250, },
-	{ .compatible = "ns8250dw", .data = (void *)PORT_8250, },
 	{ .compatible = "ns16450",  .data = (void *)PORT_16450, },
 	{ .compatible = "ns16550a", .data = (void *)PORT_16550A, },
 	{ .compatible = "ns16550",  .data = (void *)PORT_16550, },
-- 
1.7.7

