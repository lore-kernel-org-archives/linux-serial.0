From: Lucas Stach <dev@lynxeye.de>
Subject: [PATCH] serial: of-serial: fetch line number from DT
Date: Mon,  3 Nov 2014 23:16:54 +0100
Message-ID: <1415053014-29778-1-git-send-email-dev@lynxeye.de>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from ns.lynxeye.de ([87.118.118.114]:50495 "EHLO lynxeye.de"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750810AbaKCWPv (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Mon, 3 Nov 2014 17:15:51 -0500
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jslaby@suse.cz>, linux-serial@vger.kernel.org

The general agreed way to specify a fixed line number
for a serial console is to provide a "serial" alias
in the devicetree. Start parsing this property in
of_serial.

Signed-off-by: Lucas Stach <dev@lynxeye.de>
---
 drivers/tty/serial/of_serial.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/tty/serial/of_serial.c b/drivers/tty/serial/of_serial.c
index 8bc2563..920a831 100644
--- a/drivers/tty/serial/of_serial.c
+++ b/drivers/tty/serial/of_serial.c
@@ -101,6 +101,10 @@ static int of_platform_serial_setup(struct platform_device *ofdev,
 	if (of_property_read_u32(np, "fifo-size", &prop) == 0)
 		port->fifosize = prop;
 
+	/* Check for a fixed line number */
+	if ((ret = of_alias_get_id(np, "serial")) >= 0)
+		port->line = ret;
+
 	port->irq = irq_of_parse_and_map(np, 0);
 	port->iotype = UPIO_MEM;
 	if (of_property_read_u32(np, "reg-io-width", &prop) == 0) {
-- 
1.9.3

