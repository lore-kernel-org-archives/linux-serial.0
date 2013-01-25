From: John Crispin <blogic@openwrt.org>
Subject: [PATCH 2/2] serial: of: allow au1x00 and rt288x to load from OF
Date: Fri, 25 Jan 2013 11:50:08 +0100
Message-ID: <1359111008-9998-2-git-send-email-blogic@openwrt.org>
References: <1359111008-9998-1-git-send-email-blogic@openwrt.org>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from nbd.name ([46.4.11.11]:52130 "EHLO nbd.name"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753393Ab3AYKw4 (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Fri, 25 Jan 2013 05:52:56 -0500
In-Reply-To: <1359111008-9998-1-git-send-email-blogic@openwrt.org>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Alan Cox <alan@linux.intel.com>
Cc: linux-serial@vger.kernel.org, linux-mips@linux-mips.org, John Crispin <blogic@openwrt.org>

In order to make serial_8250 loadable via OF on Au1x00 and Ralink WiSoC we need
to default the iotype to UPIO_AU.

Signed-off-by: John Crispin <blogic@openwrt.org>
---
 drivers/tty/serial/of_serial.c |    4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/tty/serial/of_serial.c b/drivers/tty/serial/of_serial.c
index e7cae1c..72e9743 100644
--- a/drivers/tty/serial/of_serial.c
+++ b/drivers/tty/serial/of_serial.c
@@ -97,7 +97,11 @@ static int of_platform_serial_setup(struct platform_device *ofdev,
 		port->regshift = prop;
 
 	port->irq = irq_of_parse_and_map(np, 0);
+#if defined(CONFIG_MIPS_ALCHEMY) || defined(CONFIG_SERIAL_8250_RT288X)
+	port->iotype = UPIO_AU;
+#else
 	port->iotype = UPIO_MEM;
+#endif
 	if (of_property_read_u32(np, "reg-io-width", &prop) == 0) {
 		switch (prop) {
 		case 1:
-- 
1.7.10.4

