From: Alexander Savchenko <oleksandr.savchenko@ti.com>
Subject: [PATCH] OMAP: UART: Fix the revision register read.
Date: Mon, 8 Jul 2013 10:28:57 +0300
Message-ID: <1373268537-3198-1-git-send-email-oleksandr.savchenko@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:55323 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751036Ab3GHH3P (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Mon, 8 Jul 2013 03:29:15 -0400
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: gregkh@linuxfoundation.org, jslaby@suse.cz
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Ruchika Kharwar <ruchika@ti.com>, Alexander Savchenko <oleksandr.savchenko@ti.com>

From: Ruchika Kharwar <ruchika@ti.com>

The revision register is a 32 bit register. The serial_in() function reads
only the lower 16 bits of the register. This leads to an incorrect computation
of the Module revision.

Signed-off-by: Ruchika Kharwar <ruchika@ti.com>
[oleksandr.savchenko@ti.com: add some whitespaces]
Signed-off-by: Alexander Savchenko <oleksandr.savchenko@ti.com>
---
 drivers/tty/serial/omap-serial.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/omap-serial.c b/drivers/tty/serial/omap-serial.c
index ad7b366..a23bbdb 100644
--- a/drivers/tty/serial/omap-serial.c
+++ b/drivers/tty/serial/omap-serial.c
@@ -1335,7 +1335,7 @@ static void omap_serial_fill_features_erratas(struct uart_omap_port *up)
 	u32 mvr, scheme;
 	u16 revision, major, minor;
 
-	mvr = serial_in(up, UART_OMAP_MVER);
+	mvr = readl(up->port.membase + (UART_OMAP_MVER << up->port.regshift));
 
 	/* Check revision register scheme */
 	scheme = mvr >> OMAP_UART_MVR_SCHEME_SHIFT;
-- 
1.7.9.5

