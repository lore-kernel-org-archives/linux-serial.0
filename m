From: Frans Klaver <frans.klaver@xsens.com>
Subject: [PATCH 1/3] tty: omap-serial: prevent division by zero
Date: Tue, 29 Jul 2014 16:52:55 +0200
Message-ID: <1406645577-18620-2-git-send-email-frans.klaver@xsens.com>
References: <1406645577-18620-1-git-send-email-frans.klaver@xsens.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from filter1.ibarracuda.nl ([83.247.7.10]:33636 "EHLO
	filter1.ibarracuda.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754009AbaG2PFY (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 29 Jul 2014 11:05:24 -0400
Received: from XSMCASSVR01.xsens-tech.local (rev-215.116.249.87.virtu.nl [87.249.116.215]) by filter1.ibarracuda.nl with ESMTP id RQAJBpzHPLUVmEQ5 (version=TLSv1 cipher=AES128-SHA bits=128 verify=NO) for <linux-serial@vger.kernel.org>; Tue, 29 Jul 2014 16:53:30 +0200 (CEST)
In-Reply-To: <1406645577-18620-1-git-send-email-frans.klaver@xsens.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: Frans Klaver <frans.klaver@xsens.com>

If the chosen baud rate is large enough (e.g. 3.5 megabaud), the
calculated n13 and n16 values in serial_omap_baud_is_mode16 may become
0. This causes a division by zero when calculating the difference
between calculated and desired baud rates. To prevent this, cap n13 and
n16 on 1.

Signed-off-by: Frans Klaver <frans.klaver@xsens.com>
---
 drivers/tty/serial/omap-serial.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/omap-serial.c b/drivers/tty/serial/omap-serial.c
index d017cec..e454b7c 100644
--- a/drivers/tty/serial/omap-serial.c
+++ b/drivers/tty/serial/omap-serial.c
@@ -254,8 +254,16 @@ serial_omap_baud_is_mode16(struct uart_port *port, unsigned int baud)
 {
 	unsigned int n13 = port->uartclk / (13 * baud);
 	unsigned int n16 = port->uartclk / (16 * baud);
-	int baudAbsDiff13 = baud - (port->uartclk / (13 * n13));
-	int baudAbsDiff16 = baud - (port->uartclk / (16 * n16));
+	int baudAbsDiff13;
+	int baudAbsDiff16;
+
+	if (n13 == 0)
+		n13 = 1;
+	if (n16 == 0)
+		n16 = 1;
+
+	baudAbsDiff13 = baud - (port->uartclk / (13 * n13));
+	baudAbsDiff16 = baud - (port->uartclk / (16 * n16));
 	if (baudAbsDiff13 < 0)
 		baudAbsDiff13 = -baudAbsDiff13;
 	if (baudAbsDiff16 < 0)
-- 
1.9.3

