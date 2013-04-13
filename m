From: John Crispin <blogic@openwrt.org>
Subject: [PATCH 1/3] tty: of_serial: allow rt288x-uart to load from OF
Date: Sat, 13 Apr 2013 11:33:36 +0200
Message-ID: <1365845618-16040-2-git-send-email-blogic@openwrt.org>
References: <1365845618-16040-1-git-send-email-blogic@openwrt.org>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from nbd.name ([46.4.11.11]:39367 "EHLO nbd.name"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751826Ab3DMJho (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Sat, 13 Apr 2013 05:37:44 -0400
In-Reply-To: <1365845618-16040-1-git-send-email-blogic@openwrt.org>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-mips@linux-mips.org, linux-serial@vger.kernel.org, John Crispin <blogic@openwrt.org>

In order to make serial_8250 loadable via OF on Ralink WiSoC we need to default
the iotype to UPIO_RT.

Signed-off-by: John Crispin <blogic@openwrt.org>
---
 drivers/tty/serial/of_serial.c |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/of_serial.c b/drivers/tty/serial/of_serial.c
index b025d54..42f8550 100644
--- a/drivers/tty/serial/of_serial.c
+++ b/drivers/tty/serial/of_serial.c
@@ -98,7 +98,10 @@ static int of_platform_serial_setup(struct platform_device *ofdev,
 		port->regshift = prop;
 
 	port->irq = irq_of_parse_and_map(np, 0);
-	port->iotype = UPIO_MEM;
+	if (of_device_is_compatible(np, "ralink,rt2880-uart"))
+		port->iotype = UPIO_AU;
+	else
+		port->iotype = UPIO_MEM;
 	if (of_property_read_u32(np, "reg-io-width", &prop) == 0) {
 		switch (prop) {
 		case 1:
-- 
1.7.10.4

