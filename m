From: Manuel Lauss <manuel.lauss@googlemail.com>
Subject: [PATCH 1/2] serial: 8250: reduce Alchemy serial port space size
Date: Wed, 28 Oct 2009 20:09:13 +0100
Message-ID: <1256756954-29211-1-git-send-email-manuel.lauss@gmail.com>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from ey-out-2122.google.com ([74.125.78.26]:12968 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751946AbZJ1TJM (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 28 Oct 2009 15:09:12 -0400
Received: by ey-out-2122.google.com with SMTP id 9so272916eyd.19
        for <linux-serial@vger.kernel.org>; Wed, 28 Oct 2009 12:09:16 -0700 (PDT)
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>, Ralf Baechle <ralf@linux-mips.org>
Cc: Linux-MIPS <linux-mips@linux-mips.org>, linux-serial@vger.kernel.org, Manuel Lauss <manuel.lauss@gmail.com>

This patch limits the amount of address space claimed for Alchemy serial
ports to 0x1000.  On the Au1300, ports are only 0x1000 apart, and the
registers only extend to 0x110 at most on all supported alchemy models.

Signed-off-by: Manuel Lauss <manuel.lauss@gmail.com>
---
I'm not sure who to send this patch to; I added Ralf Baechle because
he always takes my alchemy patches, 8250 is unmaintained and this
patch is required for adding support for a new alchemy model (this patch
gets me a working serial console on the DB1300).

 drivers/serial/8250.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/serial/8250.c b/drivers/serial/8250.c
index b1ae774..2ff81eb 100644
--- a/drivers/serial/8250.c
+++ b/drivers/serial/8250.c
@@ -2429,7 +2429,7 @@ serial8250_pm(struct uart_port *port, unsigned int state,
 static unsigned int serial8250_port_size(struct uart_8250_port *pt)
 {
 	if (pt->port.iotype == UPIO_AU)
-		return 0x100000;
+		return 0x1000;
 #ifdef CONFIG_ARCH_OMAP
 	if (is_omap_port(pt))
 		return 0x16 << pt->port.regshift;
-- 
1.6.5

