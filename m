From: Jamie Iles <jamie@jamieiles.com>
Subject: [PATCH 2/2] tty: of_serial: support for 32 bit accesses
Date: Wed, 15 Jun 2011 13:49:59 +0100
Message-ID: <1308142199-17972-2-git-send-email-jamie@jamieiles.com>
References: <1308142199-17972-1-git-send-email-jamie@jamieiles.com>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:57612 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752145Ab1FOMuJ (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 15 Jun 2011 08:50:09 -0400
Received: by mail-wy0-f174.google.com with SMTP id 21so272261wya.19
        for <linux-serial@vger.kernel.org>; Wed, 15 Jun 2011 05:50:08 -0700 (PDT)
In-Reply-To: <1308142199-17972-1-git-send-email-jamie@jamieiles.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org, devicetree-discuss@lists.ozlabs.org
Cc: Jamie Iles <jamie@jamieiles.com>, Alan Cox <alan@linux.intel.com>, Grant Likely <grant.likely@secretlab.ca>

Some platforms e.g. TI Davinci require 32-bit accesses to the UARTs.
The of_serial driver currently registers all UARTs as UPIO_MEM.  Add a
new attribute "io-width" to allow the port to be registered with
different IO width requirements.

Cc: Alan Cox <alan@linux.intel.com>
Cc: Grant Likely <grant.likely@secretlab.ca>
Signed-off-by: Jamie Iles <jamie@jamieiles.com>
---
 .../devicetree/bindings/tty/serial/of-serial.txt   |    3 +++
 drivers/tty/serial/of_serial.c                     |   17 +++++++++++++++++
 2 files changed, 20 insertions(+), 0 deletions(-)

diff --git a/Documentation/devicetree/bindings/tty/serial/of-serial.txt b/Documentation/devicetree/bindings/tty/serial/of-serial.txt
index b0c52c2..1771cda 100644
--- a/Documentation/devicetree/bindings/tty/serial/of-serial.txt
+++ b/Documentation/devicetree/bindings/tty/serial/of-serial.txt
@@ -21,6 +21,9 @@ Optional properties:
 - reg-shift : quantity to shift the register offsets by.
 - used-by-rtas : set to indicate that the port is in use by the firmware and
   should not be registered.
+- io-width : the size (in bytes) of the IO accesses that should be performed
+  on the device.  There are some systems that require 32-bit accesses to the
+  UART (e.g. TI davinci).
 
 Example:
 
diff --git a/drivers/tty/serial/of_serial.c b/drivers/tty/serial/of_serial.c
index 4675243..50810a0 100644
--- a/drivers/tty/serial/of_serial.c
+++ b/drivers/tty/serial/of_serial.c
@@ -65,6 +65,23 @@ static int __devinit of_platform_serial_setup(struct platform_device *ofdev,
 
 	port->irq = irq_of_parse_and_map(np, 0);
 	port->iotype = UPIO_MEM;
+	prop = of_get_property(np, "io-width", &prop_size);
+	if (prop && (prop_size == sizeof(u32))) {
+		switch (be32_to_cpup(prop)) {
+		case 1:
+			port->iotype = UPIO_MEM;
+			break;
+		case 4:
+			port->iotype = UPIO_MEM32;
+			break;
+		default:
+			dev_warn(&ofdev->dev,
+				 "unsupported io width (%d bytes)\n",
+				 be32_to_cpup(prop));
+			return -EINVAL;
+		}
+	}
+
 	port->type = type;
 	port->uartclk = be32_to_cpup(clk);
 	port->flags = UPF_SHARE_IRQ | UPF_BOOT_AUTOCONF | UPF_IOREMAP
-- 
1.7.4.1

