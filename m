From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH] serial/of_serial: make it endian safe
Date: Sun, 10 Oct 2010 18:14:07 +0200
Message-ID: <20101010161407.GA15105@Chamillionaire.breakpoint.cc>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from Chamillionaire.breakpoint.cc ([85.10.199.196]:51880 "EHLO
	Chamillionaire.breakpoint.cc" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753060Ab0JJQOI (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Sun, 10 Oct 2010 12:14:08 -0400
Content-Disposition: inline
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Grant Likely <grant.likely@secretlab.ca>
Cc: linux-serial@vger.kernel.org

it works currently since Microblaze and Power are both BE.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 drivers/serial/of_serial.c |   14 +++++++-------
 1 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/serial/of_serial.c b/drivers/serial/of_serial.c
index 2af8fd1..012ef07 100644
--- a/drivers/serial/of_serial.c
+++ b/drivers/serial/of_serial.c
@@ -31,8 +31,8 @@ static int __devinit of_platform_serial_setup(struct platform_device *ofdev,
 {
 	struct resource resource;
 	struct device_node *np = ofdev->dev.of_node;
-	const unsigned int *clk, *spd;
-	const u32 *prop;
+	const __be32 *clk, *spd;
+	const __be32 *prop;
 	int ret, prop_size;
 
 	memset(port, 0, sizeof *port);
@@ -55,24 +55,24 @@ static int __devinit of_platform_serial_setup(struct platform_device *ofdev,
 	/* Check for shifted address mapping */
 	prop = of_get_property(np, "reg-offset", &prop_size);
 	if (prop && (prop_size == sizeof(u32)))
-		port->mapbase += *prop;
+		port->mapbase += be32_to_cpup(prop);
 
 	/* Check for registers offset within the devices address range */
 	prop = of_get_property(np, "reg-shift", &prop_size);
 	if (prop && (prop_size == sizeof(u32)))
-		port->regshift = *prop;
+		port->regshift = be32_to_cpup(prop);
 
 	port->irq = irq_of_parse_and_map(np, 0);
 	port->iotype = UPIO_MEM;
 	port->type = type;
-	port->uartclk = *clk;
+	port->uartclk = be32_to_cpup(clk);
 	port->flags = UPF_SHARE_IRQ | UPF_BOOT_AUTOCONF | UPF_IOREMAP
 		| UPF_FIXED_PORT | UPF_FIXED_TYPE;
 	port->dev = &ofdev->dev;
 	/* If current-speed was set, then try not to change it. */
 	if (spd)
-		port->custom_divisor = *clk / (16 * (*spd));
-
+		port->custom_divisor = be32_to_cpup(clk) /
+			(16 * (be32_to_cpup(spd)));
 	return 0;
 }
 
-- 
1.7.2.3

