From: Gabor Juhos <juhosg@openwrt.org>
Subject: [PATCH] tty: of_serial: add no-loopback-test property
Date: Sat, 14 Jul 2012 14:06:20 +0200
Message-ID: <1342267580-3672-1-git-send-email-juhosg@openwrt.org>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from arrakis.dune.hu ([78.24.191.176]:49692 "EHLO arrakis.dune.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753108Ab2GNMOi (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Sat, 14 Jul 2012 08:14:38 -0400
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Grant Likely <grant.likely@secretlab.ca>
Cc: Alan Cox <alan@linux.intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Rob Landley <rob@landley.net>, devicetree-discuss@lists.ozlabs.org, linux-serial@vger.kernel.org, Gabor Juhos <juhosg@openwrt.org>

The loopback test mode is not implemented in all
NS16550 compatible UARTs. The 8250 driver uses the
UPF_SKIP_TEST flag to indicate this, however it is
not possible to set this flag via device-tree.

Add a new 'no-loopback-test' property, and modify
the of_serial driver to set the UPF_SKIP_TEST flag
if the property is present.

Signed-off-by: Gabor Juhos <juhosg@openwrt.org>
---
 .../devicetree/bindings/tty/serial/of-serial.txt   |    2 ++
 drivers/tty/serial/of_serial.c                     |    4 ++++
 2 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/Documentation/devicetree/bindings/tty/serial/of-serial.txt b/Documentation/devicetree/bindings/tty/serial/of-serial.txt
index b8b27b0..0e83e45 100644
--- a/Documentation/devicetree/bindings/tty/serial/of-serial.txt
+++ b/Documentation/devicetree/bindings/tty/serial/of-serial.txt
@@ -24,6 +24,8 @@ Optional properties:
   accesses to the UART (e.g. TI davinci).
 - used-by-rtas : set to indicate that the port is in use by the OpenFirmware
   RTAS and should not be registered.
+- no-loopback-test: set to indicate that the port does not implements loopback
+  test mode
 
 Example:
 
diff --git a/drivers/tty/serial/of_serial.c b/drivers/tty/serial/of_serial.c
index 5410c06..301e5e3 100644
--- a/drivers/tty/serial/of_serial.c
+++ b/drivers/tty/serial/of_serial.c
@@ -105,6 +105,10 @@ static int __devinit of_platform_serial_setup(struct platform_device *ofdev,
 	port->uartclk = clk;
 	port->flags = UPF_SHARE_IRQ | UPF_BOOT_AUTOCONF | UPF_IOREMAP
 		| UPF_FIXED_PORT | UPF_FIXED_TYPE;
+
+	if (of_find_property(np, "no-loopback-test", NULL))
+		port->flags |= UPF_SKIP_TEST;
+
 	port->dev = &ofdev->dev;
 
 	if (type == PORT_TEGRA)
-- 
1.7.2.1

