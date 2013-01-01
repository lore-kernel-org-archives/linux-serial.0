From: Thomas Abraham <thomas.abraham@linaro.org>
Subject: [PATCH] serial: samsung: remove the use of statically remapped controller address
Date: Tue,  1 Jan 2013 00:21:55 -0800
Message-ID: <1357028515-17794-1-git-send-email-thomas.abraham@linaro.org>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-pa0-f47.google.com ([209.85.220.47]:42550 "EHLO
	mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752033Ab3AAI3F (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 1 Jan 2013 03:29:05 -0500
Received: by mail-pa0-f47.google.com with SMTP id fa10so7455574pad.20
        for <linux-serial@vger.kernel.org>; Tue, 01 Jan 2013 00:29:04 -0800 (PST)
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: gregkh@linuxfoundation.org, alan@linux.intel.com, kgene.kim@samsung.com, linux-samsung-soc@vger.kernel.org

The address S3C_VA_UART is a statically ioremapped address. The driver
should not be using this. Instead, the driver should setup a mapping
during probe.

Cc: Kukjin Kim <kgene.kim@samsung.com>
Signed-off-by: Thomas Abraham <thomas.abraham@linaro.org>
---
 drivers/tty/serial/samsung.c |    8 ++++++--
 1 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/samsung.c b/drivers/tty/serial/samsung.c
index e514b3a..d6c4f659 100644
--- a/drivers/tty/serial/samsung.c
+++ b/drivers/tty/serial/samsung.c
@@ -47,7 +47,6 @@
 #include <asm/irq.h>
 
 #include <mach/hardware.h>
-#include <mach/map.h>
 
 #include <plat/regs-serial.h>
 #include <plat/clock.h>
@@ -1143,8 +1142,13 @@ static int s3c24xx_serial_init_port(struct s3c24xx_uart_port *ourport,
 
 	dbg("resource %p (%lx..%lx)\n", res, res->start, res->end);
 
+	port->membase = devm_ioremap(port->dev, res->start, resource_size(res));
+	if (!port->membase) {
+		dev_err(port->dev, "failed to remap controller address\n");
+		return -EBUSY;
+	}
+
 	port->mapbase = res->start;
-	port->membase = S3C_VA_UART + (res->start & 0xfffff);
 	ret = platform_get_irq(platdev, 0);
 	if (ret < 0)
 		port->irq = 0;
-- 
1.7.5.4

